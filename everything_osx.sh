#!/bin/bash
EVERYTHING_CD=`pwd`


fail () {
  echo "=================================================================="
  echo " FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL "
  echo "=================================================================="
  cd $EVERYTHING_CD
  exit 1
}

source config_osx.sh

source osx/setup.sh

source osx/buildProjucer.sh
if [ $BUILD_PROJUCER_SH = "FAIL" ]
then
  echo "Projucer build FAIL"
  fail
fi

source osx/generateBuildFolders.sh

source osx/buildSkoar.sh
if [ $BUILD_SKOAR_SH = "FAIL" ] 
then
  echo "Skoar build FAIL"
  fail
fi

cd $EVERYTHING_CD
