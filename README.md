Build automation for Skoar 3, Editoar, and my version of JUCE we use.
================

Only tested on windows so far. And it doesn't build a debug build, which we need for the memory leak tests. I haven't seen this in years, surprised it still works honestly.

Instructions
============

edit `config.bat` and set the environment variables (ignore the android ones) python and VS2017 paths, get those right.

run `everything.bat` and it should:
  - checkout latest Skoar3
  - checkout latest Editoar
  - checkout JUCE version we use (my branch)
  - build Projucer with msbuild
  - run Projucer to make the VS2017 build files, editoar pointing at skoarcery correctly
  - build it all
  - results in a Skoar.exe
