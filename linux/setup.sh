
lastCd=`pwd`

git submodule init
git submodule update

cd p/JUCE
git reset --hard $JUCE_TAG
cd ../..

$PYTHON_COMMAND py/setVersions.py

export SS_ANDROID_VERSION=$(<version/androidVersionCode)
echo "SS_ANDROID_VERSION='${SS_ANDROID_VERSION}'"
$PYTHON_COMMAND py/hackJucer.py

cd $lastCd