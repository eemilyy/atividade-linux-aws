#!/bin/bash
data=$(date +%d/%m/%Y-%H:%M:%S)
if systemctl --type=service --state=running | grep httpd.service
then
        echo "$data - httpd.service - online - Apache_ligado" | tee -a /script/log/logOnhttp

else
        echo "$data - httpd.service - offline - Apache_desligado" | tee -a /script/log/logOffhttp
fi
