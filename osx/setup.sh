
lastCd=`pwd`

git submodule init
git submodule update



echo "Updating Skoarcery..."
cd p/Skoarcery
git fetch origin master
git reset --hard origin/master
cd ../..

echo "Updating Editoar..."
cd p/Editoar
git fetch origin master
git reset --hard origin/master
cd ../..

echo "Updating JUCE..."
cd p/JUCE
git reset --hard $JUCE_TAG
cd ../..

$PYTHON_COMMAND py/setVersions.py

export SS_ANDROID_VERSION=$(<version/androidVersionCode)
echo "SS_ANDROID_VERSION='${SS_ANDROID_VERSION}'"
$PYTHON_COMMAND py/hackJucer.py

cd $lastCd