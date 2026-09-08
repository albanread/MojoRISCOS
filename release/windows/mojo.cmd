@echo off
setlocal
set "MOJO_RELEASE_ROOT=%~dp0"
if "%MOJO_RELEASE_ROOT:~-1%"=="\" set "MOJO_RELEASE_ROOT=%MOJO_RELEASE_ROOT:~0,-1%"

rem bin for the compiler, lib for the runtime DLLs a built program loads.
rem Nothing here points the compiler at its configuration: it finds that from
rem its own executable, wherever this copy has been unpacked.
set "PATH=%MOJO_RELEASE_ROOT%\bin;%MOJO_RELEASE_ROOT%\lib;%PATH%"

rem lld-link needs the MSVC/UCRT import-library paths. Resolved without
rem assuming an edition or install root; see vsenv.cmd.
call "%MOJO_RELEASE_ROOT%\vsenv.cmd"

"%MOJO_RELEASE_ROOT%\bin\mojo.exe" %*
exit /b %ERRORLEVEL%
