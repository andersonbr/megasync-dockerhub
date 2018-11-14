#!/bin/bash

#
if [ "$RES" = "" ]; then
  # resolucao padrao
  RES="1280x720"
fi
echo "Initializing with resolution $RES"

vncserver :1 -geometry 1280x720 -depth 24 && tail -F /root/.vnc/*.log
sleep 1
while [ `pgrep Xtightvnc|wc -l` -ne 0 ]; do sleep 1; done