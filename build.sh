#!/bin/bash
TIMESTAMP="$( date '+%Y%m%d%H%M' )"

test -e /tmp/otmonitor && rm -rf /tmp/otmonitor

echo -ne "Stop service"
sudo systemctl stop otmonitor
echo -ne " [OK]\n"

echo "Building otmonitor"
./kit/tclkit kit/sdx.kit wrap /tmp/otmonitor -runtime kit/runtime

echo -ne "Moving in place"
test -f /opt/otmonitor/otmonitor && sudo mv /opt/otmonitor/otmonitor "/tmp/otmonitor.${TIMESTAMP}"
test -f /tmp/otmonitor && sudo mv /tmp/otmonitor /opt/otmonitor/otmonitor
echo -ne " [OK]\n"

echo -ne "Start service"
sudo systemctl start otmonitor
echo -ne " [OK]\n"
