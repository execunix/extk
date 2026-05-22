#!/bin/bash
readonly TARGET_IP="$1"
readonly PROGRAM="$2"
readonly TARGET_DIR="/mnt/work/tmp/pdu"
readonly SSH_USER="root"

# Must match startsPattern in tasks.json
echo "Deploying to target"

# kill gdbserver on target and delete old binary
ssh ${SSH_USER}@${TARGET_IP} "sh -c '/usr/bin/killall -q gdbserver; rm -rf ${TARGET_DIR}/${PROGRAM}; rm -rf /tmp/app.fifo; exit 0'"

# send the program to the target
scp out/libex2_x11_arm.so ${SSH_USER}@${TARGET_IP}:${TARGET_DIR}
scp out/${PROGRAM} ${SSH_USER}@${TARGET_IP}:${TARGET_DIR}

# Must match endsPattern in tasks.json
echo "Starting GDB Server on Target"

# start gdbserver on target
ssh -t ${SSH_USER}@${TARGET_IP} "sh -c 'cd ${TARGET_DIR}; export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.; gdbserver localhost:3000 ${PROGRAM}'"
