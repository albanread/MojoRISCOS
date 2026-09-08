# pack-msix.ps1 -- the staged release as an MSIX package.
#
#     .\release\windows\pack-msix.ps1                       # from F:\winmojo-release\stage
#     .\release\windows\pack-msix.ps1 -Stage <dir> -Out <file.msix>
#     .\release\windows\pack-msix.ps1 -CertPfx dev.pfx -CertPassword ... -Publisher "CN=..."
#
# WHAT THIS PROVES. That the tree check-release.ps1 already showed to work
# read-only can be packaged at all: the manifest validates, every file the
# manifest names exists, and makeappx produces a package. It does NOT install
# anything -- installing a package signed by anyone but the Store needs either
# Developer Mode or the signing certificate in the machine's trust store, and
# both are security settings for a person to change, not a script.
#
# NO COPY. A mapping file lists the staged files in place, so nine hundred
# megabytes are read once, by makeappx, and never duplicated.
#
# IDENTITY. The manifest carries placeholders. For a local test package they
# are filled with a test name and whatever -Publisher is given (which must
# equal the signing certificate's subject, exactly). For the Store, Partner
# Center assigns Name and Publisher when the app is reserved; pass them in.
[CmdletBinding()]
param(
    [string]$Stage = 'F:\winmojo-release\stage',
    [string]$Out = '',
    [string]$IdentityName = 'AlbanRead.WinMojo',
    [string]$Publisher = 'CN=WinMojo Development',
    # Major.Minor.Build.Revision, each 0..65535. Defaults to today.
    [string]$Version = '',
    # Sign for sideloading. Without these the package is left unsigned, which
    # is the right state for a Store submission (the Store signs it).
    [string]$CertPfx = '',
    [string]$CertPassword = ''
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
if ($Version -eq '') { $Version = (Get-Date).ToString('yyyy.M.d') + '.0' }
if ($Out -eq '') { $Out = Join-Path (Split-Path $Stage -Parent) ("winmojo-" + (Get-Date).ToString('yyyy_MM_dd') + ".msix") }

function Say($t) { Write-Host "== $t" -ForegroundColor Cyan }

# ---- the SDK tools ---------------------------------------------------------
$kits = Join-Path ${env:ProgramFiles(x86)} 'Windows Kits\10\bin'
$makeappx = Get-ChildItem $kits -Recurse -Filter makeappx.exe -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -match '\\x64\\' } | Sort-Object FullName | Select-Object -Last 1
$signtool = Get-ChildItem $kits -Recurse -Filter signtool.exe -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -match '\\x64\\' } | Sort-Object FullName | Select-Object -Last 1
if (-not $makeappx) { throw "makeappx.exe not found under $kits -- install the Windows SDK" }
Write-Host "  makeappx: $($makeappx.FullName)"

if (-not (Test-Path (Join-Path $Stage 'bin\griddle.exe'))) { throw "not a staged release: $Stage" }

# ---- a tree that is read-only-safe is the precondition -----------------------
# Refuse to package a tree that would rewrite itself. Cheap, and the whole
# reason this can work.
$cfg = Get-Content (Join-Path $Stage 'modular.cfg') -Raw
if ($cfg -match '(?m)^[^#]*[A-Za-z]:\\') { throw 'modular.cfg names an absolute path; this tree is not relocatable and cannot be packaged' }
foreach ($stale in 'paths.cmd', 'modular.cfg.in', 'modular.cfg.root') {
    if (Test-Path (Join-Path $Stage $stale)) { throw "$stale is in the tree; it rewrites the package and must not ship" }
}

# ---- scratch: manifest and assets, beside the stage, never inside it ---------
$work = Join-Path (Split-Path $Stage -Parent) 'msix-work'
Remove-Item -Recurse -Force $work -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path (Join-Path $work 'Assets') | Out-Null

Say 'manifest'
$manifest = Get-Content (Join-Path $PSScriptRoot 'AppxManifest.xml') -Raw
$manifest = $manifest.Replace('@IDENTITY_NAME@', $IdentityName).Replace('@PUBLISHER@', $Publisher).Replace('@VERSION@', $Version)
[IO.File]::WriteAllText((Join-Path $work 'AppxManifest.xml'), $manifest, (New-Object Text.UTF8Encoding $false))
Write-Host "  identity  $IdentityName  $Version"
Write-Host "  publisher $Publisher"

# Placeholder logos, generated, so the manifest's references resolve. A real
# icon replaces these when there is one; makeappx only requires that the files
# exist and are PNGs of the declared size.
Add-Type -AssemblyName System.Drawing
foreach ($spec in @(@('Square44x44Logo.png', 44), @('Square150x150Logo.png', 150), @('StoreLogo.png', 50))) {
    $bmp = New-Object Drawing.Bitmap $spec[1], $spec[1]
    $g = [Drawing.Graphics]::FromImage($bmp)
    $g.Clear([Drawing.Color]::FromArgb(255, 25, 28, 33))
    $g.FillEllipse((New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(255, 232, 132, 52))),
        [int]($spec[1] * 0.2), [int]($spec[1] * 0.2), [int]($spec[1] * 0.6), [int]($spec[1] * 0.6))
    $g.Dispose()
    $bmp.Save((Join-Path $work ('Assets\' + $spec[0])), [Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

# ---- the mapping file --------------------------------------------------------
Say 'mapping the staged tree'
$lines = New-Object Collections.Generic.List[string]
$lines.Add('[Files]')
$lines.Add('"' + (Join-Path $work 'AppxManifest.xml') + '" "AppxManifest.xml"')
foreach ($a in Get-ChildItem (Join-Path $work 'Assets')) { $lines.Add('"' + $a.FullName + '" "Assets\' + $a.Name + '"') }
$skip = @('install.ps1', 'uninstall.exe', 'SHA256SUMS.txt')
$count = 0
foreach ($f in Get-ChildItem $Stage -Recurse -File -Force) {
    $rel = $f.FullName.Substring($Stage.TrimEnd('\').Length + 1)
    if ($skip -contains $f.Name) { continue }
    if ($rel -match '^(cache|crashdb)\\') { continue }
    $lines.Add('"' + $f.FullName + '" "' + $rel + '"')
    $count++
}
$mapping = Join-Path $work 'mapping.txt'
[IO.File]::WriteAllLines($mapping, $lines, (New-Object Text.UTF8Encoding $false))
Write-Host "  $count files"

# ---- pack --------------------------------------------------------------------
Say "packing $([IO.Path]::GetFileName($Out))"
Remove-Item $Out -Force -ErrorAction SilentlyContinue
$sw = [Diagnostics.Stopwatch]::StartNew()
# Verbose, and on failure the lines that say WHY. The default output ends
# with "The package manifest is not valid" and puts the reason -- line,
# column, and which rule -- several lines above it, where a tail of four lines
# never showed it.
$packOut = & $makeappx.FullName pack /o /v /f $mapping /p $Out 2>&1 | ForEach-Object { "$_" }
if ($LASTEXITCODE -ne 0 -or -not (Test-Path $Out)) {
    $packOut | Where-Object { $_ -match 'error|Reason|Line \d+' } | Select-Object -Unique | ForEach-Object { Write-Host "  $_" }
    throw "makeappx failed ($LASTEXITCODE)"
}
$packOut | Select-Object -Last 1 | ForEach-Object { Write-Host "  $_" }
Write-Host ('  {0:N1} MiB in {1}s' -f ((Get-Item $Out).Length / 1MB), [int]$sw.Elapsed.TotalSeconds)

# ---- sign, if asked ----------------------------------------------------------
if ($CertPfx -ne '') {
    if (-not $signtool) { throw 'signtool.exe not found' }
    Say 'signing for sideload'
    $args = @('sign', '/fd', 'SHA256', '/f', $CertPfx)
    if ($CertPassword -ne '') { $args += @('/p', $CertPassword) }
    $args += $Out
    & $signtool.FullName @args 2>&1 | Select-Object -Last 2 | ForEach-Object { Write-Host "  $_" }
    if ($LASTEXITCODE -ne 0) { throw "signtool failed ($LASTEXITCODE) -- the certificate subject must equal '$Publisher' exactly" }
}

Write-Host ''
Write-Host "  package   $Out" -ForegroundColor Green
if ($CertPfx -eq '') {
    Write-Host '  unsigned  -- correct for a Store submission (the Store signs it).'
    Write-Host '  To sideload for a local test instead, a person must do two things this script will not:'
    Write-Host '    1. Settings > System > For developers > Developer Mode: On'
    Write-Host '    2. sign it with a self-signed certificate whose subject is the Publisher above, and'
    Write-Host '       import that certificate into Local Machine > Trusted People'
    Write-Host "  then:  Add-AppxPackage -Path `"$Out`""
}
