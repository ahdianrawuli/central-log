## config for alphaserver ##

###### setup redis ######
redisv='5.0.7'
redis_pass='devops'
proc=$(nproc)
wget http://download.redis.io/releases/redis-$redisv.tar.gz -O /tmp/redis.tar.gz
tar xfvz /tmp/redis.tar.gz -C /tmp
sh -c "cd /tmp/redis-$redisv/ && make -j $proc"
## running redis as daemon
/tmp/redis-$redisv/src/redis-server ./alphaserver/redis.conf
echo "wait 5 second to start"
sleep 5
## set auth for redis
status=$(ps uax | grep alphaserver | grep -v grep)
if [ "$status" ]; then
	/tmp/redis-$redisv/src/redis-cli config set requirepass $redis_pass
else
        clear;
        echo "REDIS not running";
	sleep 3;
	exit
fi

###### setup flask and app ######
pip install flask
screen -dmS flask -m -d /bin/sh ./alphaserver/run.sh $redis_pass
status=$(ps uax | grep alphaserver | grep -v grep)
if [ "$status" ]; then
	clear;
	echo "APP Running as well";
else
	clear;
	echo "APP not running";
fi
