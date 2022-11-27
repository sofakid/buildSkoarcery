export BUILD_PROJUCER_SH="FAIL"

lastCd=`pwd`
cd p/JUCE/extras/Projucer/Builds/MacOSX

#xcodebuild -scheme "Projucer - App" -configuration "Release" build && export BUILD_PROJUCER_SH="OK"
xcodebuild -scheme "Projucer - App" -configuration "Debug" build && export BUILD_PROJUCER_SH="OK"

cd $lastCd

