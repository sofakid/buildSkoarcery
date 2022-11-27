:: @echo on
set EVERYTHING_BAT=OK
set EVERYTHING_CD=%CD%

SET SETUP_BAT=RESET
call setup.bat
if %SETUP_BAT% == FAIL goto fail

call windows.bat
if %WINDOWS_BAT% == FAIL goto fail

:: call windows_store.bat
:: if %WINDOWS_BAT% == FAIL goto fail

:: call android.bat
:: if %ANDROID_BAT% == FAIL goto fail

:: call amazon_fire.bat
:: if %AMAZON_FIRE_BAT% == FAIL goto fail

:: call bat\deployWebsite.bat

goto pass
:fail
echo ==================================================================
echo  FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL 
echo ==================================================================
SET EVERYTHING_BAT=FAIL

goto end
:pass
echo =================
echo  EVERYTHING PASS 
echo =================
SET EVERYTHING_BAT=PASS

:end
cd %EVERYTHING_CD%
