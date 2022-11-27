@echo off
set LAST_CD=%CD%
set PULL_BAT=OK

@echo Updating code
cd p

:Skoarcery
if NOT EXIST Skoarcery goto no_Skoarcery

@echo Updating Skoarcery...
cd Skoarcery
git fetch origin master
git reset --hard origin/master
cd ..

:Editoar
if NOT EXIST Editoar goto no_Editoar

@echo Updating Editoar...
cd Editoar
git fetch origin master
git reset --hard origin/master
cd ..

:juce
@echo Updating JUCE...
cd JUCE
git reset --hard %JUCE_TAG%
if %ERRORLEVEL% == 0 goto juce_done 
git fetch --all
git checkout %JUCE_TAG%
if %ERRORLEVEL% == 1 goto juce_fail 
goto juce_done

:juce_fail
echo JUCE update fail. check tag: %JUCE_TAG%
goto fail

:juce_done
cd ..

goto end

:no_Skoarcery
echo Skoarcery not found.
goto fail

:no_Editoar
echo Editoar not found.
goto fail

:fail
set PULL_BAT=FAIL

:end
cd %LAST_CD%
echo Udpated code.
