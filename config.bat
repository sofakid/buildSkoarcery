@echo off
if "%1"=="testing" goto okfine
if NOT "%1"=="funtimes" goto lol_no
:okfine
SET CONFIG_BAT=OK

SET JUCE_TAG="master"

if DEFINED BUILDING_ON_AZURE goto azure_build
goto local_build
:azure_build
SET PYTHON_COMMAND="%PYTHON_HOME%\python.exe"

if NOT EXIST %PYTHON_COMMAND% goto python_fail

goto skip_local
:local_build
echo.
echo Not building on Azure.
echo.

::SET VCTargetsPath2015=C:\Progra~2\MSBuild\Microsoft.Cpp\v4.0\V140
SET VCVARS2017="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat"
SET JAVA_HOME="c:\Program Files\Java\jdk1.8.0_191"
SET PYTHON_COMMAND=c:\Python37\python
SET ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk
SET ANDROID_NDK_HOME=%LOCALAPPDATA%\Android\Sdk\ndk-bundle
SET ANDROID_BUILD_TOOLS=%ANDROID_HOME%\build-tools\28.0.3
SET ADB=%ANDROID_HOME%\platform-tools\adb.exe


::if NOT EXIST %VCTargetsPath2015%\Microsoft.Cpp.Default.props goto vc_targets_fail

:skip_local

goto done

:done
echo Configured environment:
echo   - JAVA_HOME=%JAVA_HOME%
::echo   - VCTargetsPath2015=%VCTargetsPath2015%
echo   - VCVARS2017=%VCVARS2017%
echo   - JUCE_TAG=%JUCE_TAG%
echo   - PYTHON_COMMAND=%PYTHON_COMMAND%
echo   - ANDROID_HOME=%ANDROID_HOME%
echo   - ANDROID_NDK_HOME=%ANDROID_NDK_HOME%
echo   - ANDROID_BUILD_TOOLS=%ANDROID_BUILD_TOOLS%
goto end

:lol_no
echo You're supposed to edit this, not run it.
goto end

:vc_targets_fail
echo FAIL: VCTargetsPath2015=%VCTargetsPath2015%
set CONFIG_BAT=FAIL
goto end

:python_fail
echo FAIL: %PYTHON_COMMAND% doesn't exist.
set CONFIG_BAT=FAIL
goto end

:end
