:: @echo on
set EVERYTHING_CD=%CD%
set WINDOWS_BAT=OK

if "%SETUP_BAT%" == "OK" goto skip_setup

call setup.bat
if %SETUP_BAT% == FAIL goto fail

:skip_setup
call config.bat funtimes
if %CONFIG_BAT% == FAIL goto fail

call bat\buildEditoarVS2017.bat
if %BUILD_EDITOAR_VS2017_BAT% == FAIL goto fail

:: call bat\outputEditoarWindows.bat
:: if %OUTPUT_EDITOAR% == FAIL goto fail

goto end
:fail
echo ==================================================================
echo  FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL 
echo ==================================================================
set WINDOWS_BAT=FAIL

:end
cd %EVERYTHING_CD%
