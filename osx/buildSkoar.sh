export BUILD_EDITOAR_SH="FAIL"

lastCd=`pwd`
cd p/Editoar/Builds/MacOSX

xcodebuild -scheme "Skoar - App" -configuration "Debug" build && export BUILD_EDITOAR_SH="OK"
#xcodebuild -scheme "Skoar - App" -configuration "Release" build && export BUILD_EDITOAR_SH="OK"

cd $lastCd

