#!/bin/bash
file_path='/etc/systemd/system/yozh.service'

while true
do
    if [ -e $file_path ]; then
        serv_state=$(systemctl is-active yozh.service)
        if [ $serv_state == "active" ]; then
            echo "yozh active"
            process_count=$(grep '\-c [0-9]\+' $file_path | grep -o '[0-9]\+')
            if [ $process_count -gt "600" ]; then
                sed -i 's/-c [0-9]\+/-c 600/' $file_path
                systemctl daemon-reload
                systemctl restart yozh.service
            fi
        fi
    fi
    sleep 1
done
