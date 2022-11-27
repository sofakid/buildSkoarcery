@echo off
SET LASTCD=%CD%
SET BUILD_EDITOAR_VS2015_BAT=OK

cd p\Editoar\Builds\VisualStudio2015\

set VCTargetsPath=%VCTargetsPath2015%

msbuild "Skoar.sln" /p:Configuration=Release /p:Platform=x64 /m:3
if NOT %ERRORLEVEL% == 0 goto fail

if EXIST x64\Release\App\Skoar_App.tlog\unsuccessfulbuild goto fail

goto end
:fail
SET BUILD_EDITOAR_VS2015_BAT=FAIL
goto end

:end
cd %LASTCD%
set VCTargetsPath=