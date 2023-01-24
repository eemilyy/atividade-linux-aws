#!/bin/bash
data=$(date +%d/%h/%Y-%H:%M:%S)
if systemctl --type=service --state=running | grep httpd.service
then
        echo "[ $data ] - httpd - online - Servico Apache ligado" | tee -a /nfs/emily/log/apacheOn

else
        echo "[ $data ] - httpd - offline - Servico Apache desligado" | tee -a /nfs/emily/log/apacheOff
fi
