#!/bin/bash

## config for alphaserver ##

###### setup redis ######

## stop redis running
pkill -9 redis
## compile redis
redisv='5.0.7'
redis_pass=$1
proc=$(nproc)
wget http://download.redis.io/releases/redis-$redisv.tar.gz -O /tmp/redis.tar.gz
tar xfvz /tmp/redis.tar.gz -C /tmp
sh -c "cd /tmp/redis-$redisv/ && make -j $proc"
## running redis as daemon
/tmp/redis-$redisv/src/redis-server ./redis.conf
echo "wait 5 second to start"
sleep 5
## set auth for redis
status=$(ps uax | grep redis-server | grep -v grep)
if [ "$status" ]; then
        /tmp/redis-$redisv/src/redis-cli config set requirepass $redis_pass
else
        clear;
        echo "REDIS not running";
        sleep 3;
        exit
fi

###### setup flask and app ######

## stop flask
pkill -9 flask
pip install -r ./requirements.txt
## install app
screen -dmS flask -m -d /bin/bash ./run.sh $redis_pass
status=$(ps uax | grep flask | grep -v grep)
if [ "$status" ]; then
        clear;
        echo -e "\r\n######### congratulations ;) #########\r\nAPP running at http://[IP_MASTER]:5555";
	sleep 3;
else
        clear;
        echo -e "\r\nAPP not running";
fi
