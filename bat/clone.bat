@echo off
set LAST_CD=%CD%
set CLONE_BAT=OK

git submodule init
git submodule update --force

goto end

:end
@echo Step: Clone: Done.
cd %LAST_CD%