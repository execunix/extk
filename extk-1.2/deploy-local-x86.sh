#!/bin/bash
readonly PROGRAM="$2"
readonly TARGET_DIR="/mnt/work/tmp/pdu"
#export DISPLAY=:10.0

# Must match startsPattern in tasks.json
echo "Deploying to target"

# kill gdbserver on target and delete old binary
/usr/bin/killall -q gdbserver; rm -rf ${TARGET_DIR}/${PROGRAM}; rm -rf /tmp/app.fifo

# send the program to the target
cp libex2/bin/libgeminit-gn-gdc_x86.so ${TARGET_DIR}
cp appmain/${PROGRAM} ${TARGET_DIR}

# Must match endsPattern in tasks.json
echo "Starting GDB Server on Target"

# start gdbserver on target
cd ${TARGET_DIR}; export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.; gdbserver localhost:3000 ${PROGRAM}
