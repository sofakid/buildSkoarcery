@echo off
SET LASTCD=%CD%
SET BUILD_EDITOAR_VS2017_BAT=OK

echo Buidling Editoar
echo %CD%

cd p\Editoar\Builds\VisualStudio2017\

set LOCAL_BSSFWS_B=1
:: =====================================================
::
::    build x64
::
:: =====================================================
setlocal
set LOCAL_BSSFWS_B=0

::call %VCVARS2017% x64 10.0.14393.0 -vcvars_ver=14.1
call %VCVARS2017% x64 8.1
msbuild "Skoar.sln" /p:Configuration=Release /p:Platform=x64 /m:3

if NOT "%ERRORLEVEL%" == "0" goto fail

cd "x64\Release_x64\App\Editoar_App.tlog\"
if EXIST unsuccessfulbuild goto fail

endlocal
:: =====================================================
::
::    build appx package
::
:: =====================================================
:package
setlocal
set LOCAL_BSSFWS_B=0


::call %VCVARS2017% x64 store 10.0.14393.0 -vcvars_ver=14.1
::msbuild "Editoar.sln" /p:Configuration=Release;AppxBundle=Always;AppxBundlePlatforms="x86|x64";AppxPackageDir=%CD%\AppPackages;UapAppxPackageBuildMode=StoreUpload

if NOT "%ERRORLEVEL%" == "0" goto fail

:: /p:AppxBundlePlatforms="x86|x64" /p:AppxPackageDir="AppPackages\" /p:UapAppxPackageBuildMode=StoreUpload
:: mkdir AppPackages
:: msbuild "Editoar.sln" /p:Configuration=Release /p:AppxBundlePlatforms="x86|x64" /p:AppxPackageDir=AppPackages\ /p:UapAppxPackageBuildMode=StoreUpload

endlocal
goto end
:fail
if LOCAL_BSSFWS_B==0 endlocal
SET BUILD_EDITOAR_FOR_WINDOWS_STORE_BAT=FAIL
goto end

:end
cd %LASTCD%

if LOCAL_BSSFWS_B==0 endlocal

if NOT %ERRORLEVEL% == 0 goto fail

if EXIST x64\Release\App\Skoar_App.tlog\unsuccessfulbuild goto fail

goto end
:fail
SET BUILD_EDITOAR_VS2017_BAT=FAIL
goto end

:end
cd %LASTCD%
set VCTargetsPath=