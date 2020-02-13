#!/bin/bash

#This file should be set as a cronjob, change ports and mountpoints to suit your needs

# Icecast2
icec=$(curl -o /dev/null -L -s -w "%{http_code}" http://localhost:8000)
if [ $icec -lt 1 -o $icec -gt 400 ]
then
        echo $(date) "Icecast restarted because code: $icec"
        sh /home/admin/radioScripts/restartRadio.sh
fi

# Ices
ices=$(curl -L http://localhost:8000/ices -o /dev/null --max-time 1 -w '%{http_code}\n' -s)
if [ $ices -lt 1 -o $ices -gt 399 ]
then
        echo "$(date): Ices restarted because code: $ices"
        sh /home/admin/radioScripts/restartRadio.sh
fi
