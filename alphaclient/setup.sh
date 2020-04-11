#!/bin/bash

## config for alphaclients ##
redis_pass=$2
##### config for alphaclients #####
## stop all filebeat
pkill -9 filebeat;
## comopile filebeat and run
filebeatv='7.5.1'
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$filebeatv-linux-x86_64.tar.gz -O /tmp/filebeat.tar.gz
tar xfvz /tmp/filebeat.tar.gz -C /tmp
screen -dmS filebeat -m -d /tmp/filebeat-$filebeatv-linux-x86_64/filebeat -E "output.redis.hosts=$1" -E "output.redis.password=$redis_pass" -c ./log.yml -strict.perms=false

status=$(ps uax | grep filebeat | grep -v grep)
if [ "$status" ]; then
        echo -e "\r\nFilebeat running as well";
        sleep 2;
else
        echo -e "\r\nFilebeat not running";
        sleep 2;
fi
