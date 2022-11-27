#!/bin/bash
EVERYTHING_CD=`pwd`


fail () {
  echo "=================================================================="
  echo " FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL "
  echo "=================================================================="
  cd $EVERYTHING_CD
  exit 1
}

source config_linux.sh

source linux/setup.sh

source linux/buildProjucer.sh
if [ $BUILD_PROJUCER_SH = "FAIL" ]
then
  echo "Projucer build FAIL"
  fail
fi

source linux/generateBuildFolders.sh
if [ $GENERATE_BUILD_FOLDERS_SH = "FAIL" ]
then
  echo "Projucer generate build folders FAIL"
  fail
fi

source linux/buildSkoarcery.sh
if [ $BUILD_SKOARCERY_SH = "FAIL" ] 
then
  echo "libkjv build FAIL"
  fail
fi

source linux/buildSevenStars.sh
if [ $BUILD_EDITOAR_SH = "FAIL" ] 
then
  echo "Seven Stars build FAIL"
  fail
fi

cd $EVERYTHING_CD
