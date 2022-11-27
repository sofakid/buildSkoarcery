export GENERATE_BUILD_FOLDERS_SH="FAIL"
lastCd=`pwd`
projucer="${lastCd}/p/JUCE/extras/Projucer/Builds/LinuxMakefile/build/Projucer"
editoar="${lastCd}/p/Editoar"
cd $editoar

$projucer --resave "${editoar}/Editoar.jucer" && export GENERATE_BUILD_FOLDERS_SH="OK"

cd $lastCd
