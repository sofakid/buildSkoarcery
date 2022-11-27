lastCd=`pwd`
projucer="${lastCd}/p/JUCE/extras/Projucer/Builds/MacOSX/build/Debug/Projucer.app/Contents/MacOS/Projucer"
editoar="${lastCd}/p/Editoar"
cd $editoar

$projucer --resave "${editoar}/Editoar.jucer"

cd $lastCd
