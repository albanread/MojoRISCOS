# check-release.ps1 -- does the thing we are about to ship actually work?
#
#     .\tools\check-release.ps1 -Setup F:\winmojo-release\winmojo-setup-X.exe
#     .\tools\check-release.ps1 -Root C:\WinMojo          # test what is installed
#
# This exists because a release went out that could not run anything, and every
# check we had passed. That is worth being precise about, because the lesson is
# not "add more checks" -- it is that the checks were asking easier questions
# than a person does.
#
# What the other scripts ask:
#   check-packaged.ps1  -- do the examples COMPILE against the staged tree?
#   check-install.ps1   -- does the installer lay files down, and does a
#                          scrubbed shell get an exit code of 0 out of them?
#
# What neither asks, and this does:
#   * Does the program that came out the other end actually PRINT WHAT IT
#     SHOULD? An exit code of 0 from a compiler says the compiler was happy.
#     It says nothing about whether the thing it built does anything.
#   * Does it work from a tree that has MOVED? Every path in modular.cfg is
#     absolute. `paths.cmd` exists to repair that and says so in its own
#     comments: a moved installation reports "unable to locate module 'std'",
#     which reads like a broken install rather than a moved one. Nothing
#     tested it, and griddle.exe does not call paths.cmd at all -- so the ZIP
#     product, and any installation somebody drags to another drive, is a
#     coin toss.
#   * Do PYTHON apps work? The toolchain carries a CPython, the IDE builds
#     virtual environments and installs requirements, and examples ship
#     needing pygame and matplotlib. None of that was ever exercised against
#     a release.
#   * Does it terminate? A GUI example run headlessly waits forever. A check
#     that hangs is a check nobody runs.
#
# Every case here asserts on OUTPUT the program itself produced. If a case
# cannot say what it expected to see, it is not a case.
[CmdletBinding()]
param(
    # Install this setup into -InstallTo and test that, the way a user gets it.
    [string]$Setup = '',

    # Or test a tree that is already there.
    [string]$Root = 'C:\WinMojo',

    [string]$InstallTo = 'F:\winmojo-release\test-release',

    # Where a relocated copy goes. The relocation case is the one that catches
    # "std is missing", so it is on by default; -Quick turns it off along with
    # the slower downloads.
    [string]$RelocateTo = 'F:\winmojo-release\test-relocated',

    [switch]$Quick,
    [switch]$KeepInstall,

    [int]$TimeoutMs = 300000
)

$ErrorActionPreference = 'Continue'
$script:fail = 0
$script:results = @()

function Record($name, $ok, $detail) {
    $verdict = 'FAIL'
    if ($ok) { $verdict = 'PASS' }
    Write-Host ("  {0} {1}  {2}" -f $name.PadRight(26), $verdict, $detail)
    $script:results += [pscustomobject]@{ Name = $name; Ok = [bool]$ok; Detail = $detail }
    if (-not $ok) { $script:fail++ }
}

function Show-Tail($label, $text, $n) {
    if (-not $text) { return }
    Write-Host "    --- $label"
    ($text -split "`r?`n" | Where-Object { $_.Trim() -ne '' } | Select-Object -Last $n) |
        ForEach-Object { Write-Host "      $_" }
}

# A process with a DEADLINE. Every previous check used `cmd /c ... | Out-String`,
# which waits forever -- so a GUI example that never exits does not fail the
# check, it hangs it, and a hung check gets killed and its verdict never
# recorded. Killing the process and calling that a failure is the whole point.
#
# The pipes are read asynchronously because a child that fills its stdout
# buffer blocks forever while the parent is inside WaitForExit, and both sides
# then wait for each other. That deadlock is silent and looks exactly like a
# slow build.
function Invoke-Timed {
    param(
        [string]$Exe,
        [string]$ArgLine,
        [string]$Cwd,
        [int]$Ms = 120000,
        [hashtable]$SetEnv,
        [string[]]$ClearEnv
    )
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $Exe
    $psi.Arguments = $ArgLine
    $psi.WorkingDirectory = $Cwd
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    if ($ClearEnv) { foreach ($k in $ClearEnv) { [void]$psi.EnvironmentVariables.Remove($k) } }
    if ($SetEnv) { foreach ($k in $SetEnv.Keys) { $psi.EnvironmentVariables[$k] = $SetEnv[$k] } }

    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $psi
    $null = $p.Start()
    $so = $p.StandardOutput.ReadToEndAsync()
    $se = $p.StandardError.ReadToEndAsync()
    $finished = $p.WaitForExit($Ms)
    if (-not $finished) {
        try { $p.Kill() } catch { }
        [void]$p.WaitForExit(5000)
    }
    $text = ''
    try { $text = $so.Result + $se.Result } catch { }
    $code = -999
    if ($finished) { $code = $p.ExitCode }
    $p.Dispose()
    return [pscustomobject]@{ ExitCode = $code; Output = $text; TimedOut = (-not $finished) }
}

# Drive the IDE the way the Start Menu and Desktop shortcuts do: bin\griddle.exe
# DIRECTLY, not through griddle.cmd. That distinction matters. griddle.cmd calls
# paths.cmd, sets MODULAR_HOME, puts bin and lib on PATH and runs vsenv; the
# shortcuts do none of it. Testing through the wrapper tests a path most people
# never take.
function Griddle {
    # $SetEnv and $Ms are deliberately not positional: passing a timeout third
    # bound it to the hashtable, the call threw, and $r kept the previous
    # case's output -- so a failure was reported against another test's
    # transcript. Name them or do not pass them.
    param(
        [Parameter(Position = 0)][string]$Commands,
        [Parameter(Position = 1)][string]$Cwd = $script:Root,
        [Parameter()][hashtable]$SetEnv,
        [Parameter()][int]$Ms = 0
    )
    if ($Ms -le 0) { $Ms = $TimeoutMs }
    $exe = Join-Path $script:Root 'bin\griddle.exe'
    return Invoke-Timed -Exe $exe -ArgLine ('--no-lsp --cmd "' + $Commands + '"') -Cwd $Cwd -Ms $Ms -SetEnv $SetEnv
}

Write-Host "== release check =="

# ---- 0. get something to test ----------------------------------------------
if ($Setup -ne '') {
    if (-not (Test-Path $Setup)) { throw "no such setup: $Setup" }
    if (Test-Path $InstallTo) { Remove-Item -Recurse -Force $InstallTo -ErrorAction SilentlyContinue }
    $sw = [Diagnostics.Stopwatch]::StartNew()
    $p = Start-Process -FilePath $Setup -ArgumentList '/S', "/D=$InstallTo" -Wait -PassThru
    Record 'install' ($p.ExitCode -eq 0) "exit $($p.ExitCode) after $([int]$sw.Elapsed.TotalSeconds)s into $InstallTo"
    $Root = $InstallTo
}
$script:Root = $Root
Write-Host "  root: $Root"
if (-not (Test-Path (Join-Path $Root 'bin\griddle.exe'))) { throw "not an installation: $Root" }

$work = Join-Path $env:TEMP ('winmojo-relcheck-' + $PID)
Remove-Item -Recurse -Force $work -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $work | Out-Null

# ---- 1. the configuration describes a tree that is really there -------------
# Cheap, and it is the direct precondition for everything below. Every path in
# modular.cfg is absolute and was written for whichever directory the release
# was packaged or installed into; if one of them names somewhere that does not
# exist, the compiler's complaint will be about a module rather than a path,
# and the person reading it will think the toolchain is broken.
$cfgPath = Join-Path $Root 'modular.cfg'
if (Test-Path $cfgPath) {
    $cfg = Get-Content $cfgPath -Raw
    $declared = @{}
    foreach ($line in ($cfg -split "`r?`n")) {
        if ($line -match '^\s*([a-z_]+)\s*=\s*(.+?)\s*$') { $declared[$matches[1]] = $matches[2] }
    }
    $rootNamed = ''
    if ($declared.ContainsKey('package_root')) { $rootNamed = $declared['package_root'] }
    $sameRoot = ($rootNamed.TrimEnd('\') -ieq $Root.TrimEnd('\'))
    Record 'cfg-names-this-tree' $sameRoot "package_root = $rootNamed"

    $missing = @()
    foreach ($k in @('driver_path', 'compilerrt_path', 'winkb_path', 'lld_path', 'linker_driver', 'import_path')) {
        if ($declared.ContainsKey($k)) {
            if (-not (Test-Path $declared[$k])) { $missing += ("$k -> " + $declared[$k]) }
        }
    }
    if ($declared.ContainsKey('shared_libs')) {
        foreach ($lib in ($declared['shared_libs'] -split ',')) {
            if ($lib.Trim() -ne '' -and -not (Test-Path $lib.Trim())) { $missing += ("shared_libs -> " + $lib.Trim()) }
        }
    }
    Record 'cfg-paths-exist' ($missing.Count -eq 0) $(if ($missing.Count -eq 0) { 'every path in modular.cfg is on disk' } else { ($missing -join '; ') })

    $ip = ''
    if ($declared.ContainsKey('import_path')) { $ip = $declared['import_path'] }
    $hasStd = ($ip -ne '') -and (Test-Path (Join-Path $ip 'std.mojoc'))
    Record 'stdlib-reachable' $hasStd "import_path = $ip"
} else {
    Record 'cfg-names-this-tree' $false 'no modular.cfg at the root'
}

# ---- 2. the compiler alone, with no help from anything ----------------------
# Before the IDE is involved at all. `mojo.exe` is handed a file and nothing
# else: no MODULAR_HOME, no PATH entries, no launcher script. If `std` does not
# resolve here, it resolves nowhere, and this is the case that says so in one
# line instead of leaving somebody to guess.
# The variables a DEVELOPMENT shell in this repository has and a stranger's
# machine does not. Cleared for every case below, so nothing passes because of
# something only this checkout provides.
#
# MODULAR_HOME is deliberately NOT in this list, and that is the whole point of
# the case below it. `bin\mojo.exe` cannot find modular.cfg by itself -- not
# beside itself, not one directory up where the installer writes it. It reads
# MODULAR_HOME and nothing else, so on a machine where nothing sets it the
# compiler answers `unable to locate module 'std'` on a complete and correct
# installation. The installer sets it now; what this checks is that a shell
# which inherits it, the way any shell opened after installation does, gets a
# working compiler.
$scrub = @('MODULAR_MOJO_MAX_WINKB_PATH', 'MOJO_PYTHON', 'MOJO_PYTHON_LIBRARY', 'GRIDDLE_PYTHON_HOME')

# Read from the registry rather than from this process: this process may have
# been started before the install, and an installer's environment change only
# reaches shells opened afterwards.
$registeredHome = ''
try {
    $registeredHome = (Get-ItemProperty 'HKCU:\Environment' -Name MODULAR_HOME -ErrorAction Stop).MODULAR_HOME
} catch { }
$homeOk = ($registeredHome -ne '') -and ($registeredHome.TrimEnd('\') -ieq $Root.TrimEnd('\'))
Record 'modular-home-registered' $homeOk $(
    if ($registeredHome -eq '') { 'nothing sets MODULAR_HOME, so `mojo` outside a launcher cannot find std' }
    elseif (-not $homeOk) { "MODULAR_HOME names $registeredHome, not this tree" }
    else { "MODULAR_HOME = $registeredHome" })
$helloDir = Join-Path $work 'hello'
New-Item -ItemType Directory -Force -Path $helloDir | Out-Null
Set-Content -Path "$helloDir\main.mojo" -Encoding ascii -Value @(
    'def main():',
    '    var total = 0',
    '    for i in range(10):',
    '        total += i * i',
    '    print("MOJO-OK", total)'
)
$shellEnv = @{}
if ($registeredHome -ne '') { $shellEnv['MODULAR_HOME'] = $registeredHome }
$r = Invoke-Timed -Exe (Join-Path $Root 'bin\mojo.exe') -ArgLine ('run --no-optimization "' + $helloDir + '\main.mojo"') -Cwd $helloDir -Ms 180000 -ClearEnv $scrub -SetEnv $shellEnv
$sawStd = ($r.Output -match "locate module|unable to find.*std|'std'")
Record 'compiler-alone-runs' ($r.Output -match 'MOJO-OK 285') $(
    if ($sawStd -and $registeredHome -eq '') { 'no MODULAR_HOME anywhere, so the compiler cannot find std' }
    elseif ($sawStd) { 'the compiler cannot find std even with MODULAR_HOME set' }
    elseif ($r.TimedOut) { 'timed out' }
    else { "printed what it computed (exit $($r.ExitCode))" })
if (-not ($r.Output -match 'MOJO-OK 285')) { Show-Tail 'mojo run' $r.Output 12 }

# ---- 3. the IDE builds, and the thing it built runs -------------------------
# Two separate claims, and only the second one is what a person cares about.
# A release shipped in which Build passed --no-optimization and Run did not, so
# every example compiled and none of them started; a check that only builds
# cannot see that, and did not.
$r = Griddle ('open ' + $helloDir + '\main.mojo;;build;;build wait 240000') $helloDir
$builtExe = Join-Path $helloDir 'main.exe'
Record 'ide-builds' (($r.Output -match 'exit 0') -and (Test-Path $builtExe)) $(
    if ($r.TimedOut) { 'timed out' } else { 'Build produced ' + (Split-Path $builtExe -Leaf) })
if (-not (Test-Path $builtExe)) { Show-Tail 'build' $r.Output 15 }

$r = Griddle ('open ' + $helloDir + '\main.mojo;;run;;run wait 240000;;output') $helloDir
Record 'ide-runs' ($r.Output -match 'MOJO-OK 285') $(
    if ($r.TimedOut) { 'timed out' } else { 'Run printed what the program computed' })
if (-not ($r.Output -match 'MOJO-OK 285')) { Show-Tail 'run' $r.Output 15 }

# The built executable, started by itself, from a directory that is not the
# installation. This is how a person's own program gets run once they have one,
# and it is the case that proves the runtime DLLs can be found.
if (Test-Path $builtExe) {
    $away = Join-Path $work 'elsewhere'
    New-Item -ItemType Directory -Force -Path $away | Out-Null
    $r = Invoke-Timed -Exe $builtExe -ArgLine '' -Cwd $away -Ms 60000 -ClearEnv $scrub
    Record 'built-exe-runs-alone' ($r.Output -match 'MOJO-OK 285') $(
        if ($r.ExitCode -eq -1073741515) { 'STATUS_DLL_NOT_FOUND -- a runtime DLL is not beside it or on PATH' }
        elseif ($r.TimedOut) { 'timed out' }
        else { "ran outside the installation (exit $($r.ExitCode))" })
    if (-not ($r.Output -match 'MOJO-OK 285')) { Show-Tail 'standalone' $r.Output 8 }
}

# ---- 4. a windowed program -------------------------------------------------
# The game pane counts its own frames and stops, which is the only reason a
# windowed program can be checked without somebody watching it. GAMEPANE_FRAMES
# is that contract; if it ever stops being honoured this case hangs and is
# killed, and the timeout is the failure.
$pane = Join-Path $Root 'examples\win32\gamepane-canvas\main.mojo'
if (Test-Path $pane) {
    $r = Griddle ('open ' + $pane + ';;run;;run wait 300000;;output') (Split-Path $pane) -SetEnv @{ GAMEPANE_FRAMES = '20' }
    Record 'windowed-app-runs' (($r.Output -match 'presented 20 frames') -and ($r.Output -match 'exit 0')) $(
        if ($r.TimedOut) { 'timed out -- it never stopped on its own' } else { 'presented frames and exited' })
    if (-not ($r.Output -match 'presented 20 frames')) { Show-Tail 'gamepane' $r.Output 15 }
} else {
    Record 'windowed-app-runs' $false 'gamepane-canvas is not in this release'
}

# A shipped Win32 example that does NOT self-terminate. It cannot be run to
# completion, so the claim is narrower and stated honestly: it compiles, and
# the executable it produces starts and stays up rather than dying on load.
$life = Join-Path $Root 'examples\win32\life\main.mojo'
if (Test-Path $life) {
    $r = Griddle ('open ' + $life + ';;build;;build wait 300000') (Split-Path $life)
    $lifeExe = Join-Path (Split-Path $life) 'main.exe'
    $built = (Test-Path $lifeExe)
    $stayed = $false
    $complaint = ''
    if ($built) {
        $lp = Start-Process -FilePath $lifeExe -PassThru -WorkingDirectory (Split-Path $life)
        Start-Sleep -Milliseconds 2500
        $lp.Refresh()
        $stayed = -not $lp.HasExited
        if ($stayed) {
            # ALIVE IS NOT WORKING. A program that cannot resolve one of its
            # imported DLLs does not exit -- Windows puts up a modal
            # "main.exe - System Error / The code execution cannot proceed
            # because KGENCompilerRTShared.dll was not found" and the process
            # sits behind it forever. This check passed on exactly that, which
            # made it worse than no check: it reported a release as good while
            # the error box was on the screen.
            #
            # So the window is read. A working Win32 example has a title of its
            # own; a broken one is announced by Windows in its own words.
            $title = ''
            try { $title = $lp.MainWindowTitle } catch { }
            if ($title -match 'System Error|Application Error|has stopped working') {
                $stayed = $false
                $complaint = "it started but Windows says: $title"
            }
            try { $lp.Kill() } catch { }
        }
    }
    Record 'win32-example-starts' ($built -and $stayed) $(
        if (-not $built) { 'it did not build' }
        elseif ($complaint -ne '') { $complaint }
        elseif (-not $stayed) { 'it built but the window died within 2.5s' }
        else { 'built, started, and put up a window of its own' })
    if (-not $built) { Show-Tail 'life build' $r.Output 15 }
}

# ---- 5. the GPU --------------------------------------------------------------
# nvptxrt is a DLL rather than a static archive, so a GPU program depends on the
# release having shipped it AND on it being findable at run time.
$gpuDir = Join-Path $work 'gpu'
New-Item -ItemType Directory -Force -Path $gpuDir | Out-Null
Set-Content -Path "$gpuDir\main.mojo" -Encoding ascii -Value @(
    'from max.gpu.host import DeviceContext',
    '',
    '',
    'def main() raises:',
    '    var ctx = DeviceContext()',
    '    var buf = ctx.enqueue_create_buffer[DType.float32](64)',
    '    var host = ctx.enqueue_create_host_buffer[DType.float32](64)',
    '    ctx.enqueue_memset(buf, Float32(6.5))',
    '    host.enqueue_copy_from(buf)',
    '    ctx.synchronize()',
    '    print("GPU-OK", host[0], ctx.name())'
)
$r = Griddle ('project ' + $gpuDir + ';;open ' + $gpuDir + '\main.mojo;;run;;run wait 300000;;output') $gpuDir
Record 'gpu-runs' ($r.Output -match 'GPU-OK 6\.5') $(
    if ($r.TimedOut) { 'timed out' } else { 'a GPU program built and ran' })
if (-not ($r.Output -match 'GPU-OK 6\.5')) { Show-Tail 'gpu' $r.Output 15 }

# ---- 6. PYTHON --------------------------------------------------------------
# The part nothing tested. Three separate things can be broken independently
# and all three ship in every release:
#
#   a. the bundled CPython, and whether it can build a virtual environment
#      (which needs Lib\venv and Lib\ensurepip to have survived packaging),
#   b. the IDE's dependency handling: read requirements.txt, make the
#      environment, install into it, then run the file with that interpreter,
#   c. Mojo-to-Python interop, which loads CPython INTO the built program and
#      needs MOJO_PYTHON_LIBRARY pointed at the right DLL -- something the
#      compiler cannot work out on Windows and the IDE has to supply.
Write-Host "  -- python"

$pyEnvRoot = ''
$pyProj = Join-Path $work 'pyproj'
New-Item -ItemType Directory -Force -Path $pyProj | Out-Null
Set-Content -Path "$pyProj\requirements.txt" -Encoding ascii -Value 'six==1.16.0'
Set-Content -Path "$pyProj\main.py" -Encoding ascii -Value @(
    'import sys, six',
    'print("PY-OK", six.__version__, sys.executable)'
)

# Where the environment will go. Asked for rather than constructed: under a
# packaged application %LOCALAPPDATA% is redirected and this script must not
# guess.
$shown = Griddle ('project ' + $pyProj + ';;python show') $pyProj
if ($shown.Output -match 'venv (\S.*?)\s+(?:absent|present)') { $pyEnvRoot = $matches[1].Trim() }
if ($pyEnvRoot -ne '') { Remove-Item -Recurse -Force $pyEnvRoot -ErrorAction SilentlyContinue }
Record 'python-env-located' ($pyEnvRoot -ne '') "venv would go to $pyEnvRoot"

# The menu item, by its visible name, on a project that has nothing yet. It has
# to create the environment, put pip in it, and install what the file asks for.
$r = Griddle ('project ' + $pyProj + ';;menu Python > Install Project Dependencies;;build wait 300000;;output') $pyProj
$pyExe = ''
if ($pyEnvRoot -ne '') { $pyExe = Join-Path $pyEnvRoot 'Scripts\python.exe' }
$made = ($pyExe -ne '') -and (Test-Path $pyExe)
$landed = $false
if ($made) {
    $probe = Invoke-Timed -Exe $pyExe -ArgLine '-c "import six;print(six.__version__)"' -Cwd $pyProj -Ms 60000
    $landed = ($probe.Output -match '1\.16\.0')
}
Record 'python-deps-install' ($made -and $landed) $(
    if (-not $made) { 'no virtual environment was created' }
    elseif (-not $landed) { 'the environment exists but the package is not in it' }
    else { 'venv built with the bundled CPython, requirements installed' })
if (-not ($made -and $landed)) { Show-Tail 'install' $r.Output 20 }

# And Run uses that interpreter, not some other Python on the machine.
$r = Griddle ('project ' + $pyProj + ';;open ' + $pyProj + '\main.py;;run;;run wait 300000;;output') $pyProj
$ranInEnv = ($r.Output -match 'PY-OK 1\.16\.0') -and ($pyEnvRoot -ne '') -and ($r.Output -match [regex]::Escape($pyEnvRoot))
Record 'python-app-runs' $ranInEnv $(
    if ($ranInEnv) { 'Run used the project virtual environment' }
    elseif ($r.TimedOut) { 'timed out' }
    elseif ($r.Output -match 'PY-OK') { 'it ran, but not on the project interpreter' }
    else { 'the Python file did not run' })
if (-not $ranInEnv) { Show-Tail 'python run' $r.Output 15 }

# An unchanged requirements.txt must not reinstall anything. Slow startup is
# how a good feature becomes one people turn off.
$r = Griddle ('project ' + $pyProj + ';;open ' + $pyProj + '\main.py;;run;;run wait 300000;;output') $pyProj
Record 'python-run-is-cached' (($r.Output -match 'PY-OK') -and ($r.Output -notmatch 'Collecting six')) `
    'a second Run reinstalls nothing'

# Mojo calling Python: CPython loaded into the built program.
$interop = Join-Path $work 'interop'
New-Item -ItemType Directory -Force -Path $interop | Out-Null
Set-Content -Path "$interop\main.mojo" -Encoding ascii -Value @(
    'from std.python import Python',
    '',
    '',
    'def main() raises:',
    '    var sys = Python.import_module("sys")',
    '    var math = Python.import_module("math")',
    '    print("INTEROP-OK", sys.version_info[0], math.sqrt(1764.0))'
)
$r = Griddle ('project ' + $interop + ';;open ' + $interop + '\main.mojo;;run;;run wait 300000;;output') $interop
Record 'mojo-calls-python' ($r.Output -match 'INTEROP-OK 3 42') $(
    if ($r.TimedOut) { 'timed out' }
    elseif ($r.Output -match 'MOJO_PYTHON_LIBRARY|libpython|Python library') { 'the CPython library was not found' }
    else { 'Mojo loaded CPython and called it' })
if (-not ($r.Output -match 'INTEROP-OK 3 42')) { Show-Tail 'interop' $r.Output 15 }

# A SHIPPED Python example, with its own requirements, set up the way its
# comments tell a reader to set it up. Skipped by -Quick because the wheels are
# large; it is the case that proves the examples we advertise actually work.
if (-not $Quick) {
    $shipped = Join-Path $Root 'examples\win32\life-python'
    if (Test-Path (Join-Path $shipped 'requirements.txt')) {
        $shownS = Griddle ('project ' + $shipped + ';;python show') $shipped
        $sEnv = ''
        if ($shownS.Output -match 'venv (\S.*?)\s+(?:absent|present)') { $sEnv = $matches[1].Trim() }
        if ($sEnv -ne '') { Remove-Item -Recurse -Force $sEnv -ErrorAction SilentlyContinue }
        $r = Griddle ('project ' + $shipped + ';;menu Python > Install Project Dependencies;;build wait 600000;;output') $shipped -Ms 600000
        $ok = $false
        if ($sEnv -ne '') {
            $sPy = Join-Path $sEnv 'Scripts\python.exe'
            if (Test-Path $sPy) {
                $probe = Invoke-Timed -Exe $sPy -ArgLine '-c "import pygame;print(pygame.version.ver)"' -Cwd $shipped -Ms 90000 -SetEnv @{ PYGAME_HIDE_SUPPORT_PROMPT = '1' }
                $ok = ($probe.ExitCode -eq 0)
            }
        }
        Record 'shipped-python-example' $ok 'life-python: its requirements install and import'
        if (-not $ok) { Show-Tail 'life-python' $r.Output 20 }
        if ($sEnv -ne '') { Remove-Item -Recurse -Force $sEnv -ErrorAction SilentlyContinue }
    }
}
if ($pyEnvRoot -ne '') { Remove-Item -Recurse -Force $pyEnvRoot -ErrorAction SilentlyContinue }

# ---- 7. a tree that has MOVED ------------------------------------------------
# The case that catches "std is missing".
#
# Every path in modular.cfg is absolute. The installer rewrites them for the
# directory it installs into, so an installed tree is fine -- but the ZIP is a
# product too, and people drag installations to other drives. `paths.cmd`
# repairs it, and the .cmd launchers call it; griddle.exe does NOT, so starting
# the IDE from a moved tree by its executable -- which is exactly what the
# Start Menu and Desktop shortcuts do -- gets whatever modular.cfg last said.
#
# Two claims, in order, and they are different claims:
#   * after paths.cmd has run, a moved tree works;
#   * the IDE, started directly from a moved tree, works too.
# The second is the one that has never been true by construction rather than by
# luck. If it fails, that is the bug, stated precisely.
if (-not $Quick) {
    Write-Host "  -- relocation"
    if (Test-Path $RelocateTo) { Remove-Item -Recurse -Force $RelocateTo -ErrorAction SilentlyContinue }
    $sw = [Diagnostics.Stopwatch]::StartNew()
    $rc = Start-Process -FilePath 'robocopy.exe' `
        -ArgumentList @($Root, $RelocateTo, '/E', '/MT:16', '/NFL', '/NDL', '/NJH', '/NJS', '/NP', '/R:1', '/W:1') `
        -Wait -PassThru -NoNewWindow
    # robocopy: below 8 means it copied something and nothing failed.
    $copied = ($rc.ExitCode -lt 8) -and (Test-Path (Join-Path $RelocateTo 'bin\griddle.exe'))
    Record 'relocated-copy-made' $copied "$([int]$sw.Elapsed.TotalSeconds)s, robocopy exit $($rc.ExitCode)"

    if ($copied) {
        $movedProj = Join-Path $work 'moved'
        New-Item -ItemType Directory -Force -Path $movedProj | Out-Null
        Copy-Item "$helloDir\main.mojo" "$movedProj\main.mojo"

        # The launcher route, which is the one that is supposed to work.
        $r = Invoke-Timed -Exe 'cmd.exe' `
            -ArgLine ('/c ""' + (Join-Path $RelocateTo 'mojo.cmd') + '" run --no-optimization "' + $movedProj + '\main.mojo""') `
            -Cwd $movedProj -Ms 240000 -ClearEnv $scrub
        Record 'relocated-launcher-repairs' ($r.Output -match 'MOJO-OK 285') `
            'mojo.cmd rewrote modular.cfg for the new location and ran'
        if (-not ($r.Output -match 'MOJO-OK 285')) { Show-Tail 'mojo.cmd on moved tree' $r.Output 15 }

        # And the IDE, started by its executable, from the moved tree. A person
        # who drags an installation and then double-clicks Griddle takes this
        # path and no other.
        $r = Invoke-Timed -Exe (Join-Path $RelocateTo 'bin\griddle.exe') `
            -ArgLine ('--no-lsp --cmd "project ' + $movedProj + ';;open ' + $movedProj + '\main.mojo;;run;;run wait 240000;;output"') `
            -Cwd $movedProj -Ms 300000 -ClearEnv $scrub
        $movedOk = ($r.Output -match 'MOJO-OK 285')
        Record 'relocated-ide-runs' $movedOk $(
            if ($r.Output -match "locate module|'std'") { 'the moved IDE cannot find std -- griddle.exe never relocates the tree' }
            elseif ($r.TimedOut) { 'timed out' }
            else { 'the IDE ran from a moved tree' })
        if (-not $movedOk) { Show-Tail 'griddle on moved tree' $r.Output 15 }

        Remove-Item -Recurse -Force $RelocateTo -ErrorAction SilentlyContinue
    }
}

# ---- 8. the launchers we ship ------------------------------------------------
foreach ($pair in @(@('mojo.cmd', 'run --no-optimization'), @('mojo-gpu-run.cmd', ''))) {
    $script = Join-Path $Root $pair[0]
    if (-not (Test-Path $script)) { continue }
    if ($pair[0] -eq 'mojo-gpu-run.cmd') { continue }
    $r = Invoke-Timed -Exe 'cmd.exe' `
        -ArgLine ('/c ""' + $script + '" ' + $pair[1] + ' "' + $helloDir + '\main.mojo""') `
        -Cwd $helloDir -Ms 240000 -ClearEnv $scrub
    Record ('launcher-' + $pair[0].Replace('.cmd', '')) ($r.Output -match 'MOJO-OK 285') "$($pair[0]) resolves std and runs"
    if (-not ($r.Output -match 'MOJO-OK 285')) { Show-Tail $pair[0] $r.Output 12 }
}

# ---- done --------------------------------------------------------------------
Remove-Item -Recurse -Force $work -ErrorAction SilentlyContinue
if ($Setup -ne '' -and -not $KeepInstall) {
    $u = Join-Path $InstallTo 'uninstall.exe'
    if (Test-Path $u) {
        $p = Start-Process -FilePath $u -ArgumentList '/S', "_?=$InstallTo" -Wait -PassThru
        Remove-Item $u -Force -ErrorAction SilentlyContinue
        Remove-Item $InstallTo -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host ""
$passed = ($script:results | Where-Object { $_.Ok }).Count
Write-Host ("{0} checks: {1} passed, {2} failed" -f $script:results.Count, $passed, $script:fail)
if ($script:fail -gt 0) {
    Write-Host "FAILED:"
    $script:results | Where-Object { -not $_.Ok } | ForEach-Object { Write-Host ("  " + $_.Name + " -- " + $_.Detail) }
}
exit $(if ($script:fail -gt 0) { 1 } else { 0 })
