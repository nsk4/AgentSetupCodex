@echo off
setlocal

set "hook=%CD%\.codex\hooks\session-start.sh"
if exist "%hook%" goto find_bash
if defined CODEX_HOME (
  set "hook=%CODEX_HOME%\hooks\session-start.sh"
) else (
  set "hook=%USERPROFILE%\.codex\hooks\session-start.sh"
)
if not exist "%hook%" exit /b 0

:find_bash
set "bash_exe=%ProgramFiles%\Git\bin\bash.exe"
if exist "%bash_exe%" goto run
set "bash_exe=%LOCALAPPDATA%\Programs\Git\bin\bash.exe"
if exist "%bash_exe%" goto run
for /f "delims=" %%G in ('where git.exe 2^>nul') do (
  set "git_exe=%%G"
  goto from_git
)
>&2 echo QWE SessionStart hook requires Git Bash.
exit /b 1

:from_git
for %%D in ("%git_exe%") do set "bash_exe=%%~dpD..\bin\bash.exe"
if not exist "%bash_exe%" (
  >&2 echo QWE SessionStart hook could not locate Git Bash.
  exit /b 1
)

:run
"%bash_exe%" --login "%hook%"
exit /b %ERRORLEVEL%