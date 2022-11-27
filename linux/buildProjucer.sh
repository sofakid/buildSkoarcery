export BUILD_PROJUCER_SH="FAIL"

lastCd=`pwd`
cd p/JUCE/extras/Projucer/Builds/LinuxMakefile
make && export BUILD_PROJUCER_SH="OK"

cd $lastCd

