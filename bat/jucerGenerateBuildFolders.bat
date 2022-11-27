set LAST_CD=%CD%
set JUCER_GENERATE_BUILD_FOLDERS_BAT=OK

cd p\Editoar

%LAST_CD%\p\JUCE\extras\Projucer\Builds\VisualStudio2017\x64\Debug\App\Projucer.exe --resave %cd%\Editoar.jucer

goto done

:fail
set JUCER_GENERATE_BUILD_FOLDERS_BAT=FAIL
goto done

:done

cd %LAST_CD%
