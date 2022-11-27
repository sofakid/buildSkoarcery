@echo off
set SETUP_BAT=OK

set SETUP_CD=%CD%

call config.bat funtimes
if %CONFIG_BAT% == FAIL goto fail

call bat\clone.bat
if %CLONE_BAT% == FAIL goto fail

call bat\pull.bat
if %PULL_BAT% == FAIL goto fail

%PYTHON_COMMAND% py/setVersions.py
if NOT %ERRORLEVEL% == 0 goto python_fail_ver

set /p SS_ANDROID_VERSION=<version\androidVersionCode

%PYTHON_COMMAND% py/hackJucer.py
if NOT %ERRORLEVEL% == 0 goto python_fail_jucer

call bat\buildProjucer.bat
if %BUILD_PROJUCER_BAT% == FAIL goto fail

call bat\jucerGenerateBuildFolders.bat
if %JUCER_GENERATE_BUILD_FOLDERS_BAT% == FAIL goto fail

rem %PYTHON_COMMAND% py/hackGradles.py
rem if NOT %ERRORLEVEL% == 0 goto python_fail_gradles

rem %PYTHON_COMMAND% py/hackSolution.py
rem if NOT %ERRORLEVEL% == 0 goto python_fail_solution

goto end

:python_fail_ver
echo Failed to hack jucer file.
goto fail

:python_fail_jucer
echo Failed to hack jucer file.
goto fail

:python_fail_gradles
echo Failed to hack gradles and manifest file.
goto fail

:python_fail_solution
echo Failed to hack gradles and manifest file.
goto fail

:fail
echo ==================================================================
echo  FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL 
echo ==================================================================
set SETUP_BAT=FAIL

:end
cd %SETUP_CD%
