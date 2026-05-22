#!/bin/bash

CORES=$(grep -c processor /proc/cpuinfo)

####
echo "setup tool-chain"
####

if [[ ! -v SDKTARGETSYSROOT ]]; then
. /opt/fslc-xwayland/3.3/environment-setup-cortexa53-crypto-fslc-linux
fi

MKAPP_ENV=`pwd`
echo "     DEPLOY_PATH: $DEPLOY_PATH"
echo "SDKTARGETSYSROOT: $SDKTARGETSYSROOT"

####
echo "build pdu-app"
####
make -j$CORES clean
if [ "$1" == "install" ]; then
make RELEASE_BUILD=y -j$CORES install
else
make -j$CORES
fi

####
echo "build swwatchdog"
####
mkdir -p support/swwatchdog/build
cd support/swwatchdog/build
cmake ..
make -j$CORES
if [ "$1" == "install" ]; then
cp -v swwatchdog $MKAPP_ENV/../pdu-deploy/mutables/usr/bin
fi
cd $MKAPP_ENV

####
# echo "build template"
####

# end
cd $MKAPP_ENV
