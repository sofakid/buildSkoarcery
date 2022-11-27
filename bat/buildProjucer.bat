@echo off
SET LASTCD=%CD%
SET BUILD_PROJUCER_BAT=OK

cd p\JUCE\extras\Projucer\Builds\VisualStudio2017\

::set VCTargetsPath=%VCTargetsPath2015%

set LOCAL_BPJ=1
setlocal
set LOCAL_BPJ=0

call %VCVARS2017% x64 8.1
msbuild "Projucer.sln" /p:Configuration=Debug /p:Platform=x64 /m:3
if NOT %ERRORLEVEL% == 0 goto fail

endlocal

if EXIST x64\Debug\App\Projucer_App.tlog\unsuccessfulbuild goto fail

goto end
:fail
if %LOCAL_BPJ%==0 endlocal
SET BUILD_PROJUCER_BAT=FAIL
goto end

:end
cd %LASTCD%
::set VCTargetsPath=
