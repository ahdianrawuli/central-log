## config for alphaserver ##

# setup redis
redisv='5.0.7'
proc=$(nproc)
wget http://download.redis.io/releases/redis-$redisv.tar.gz -O /tmp/redis.tar.gz
tar xfvz /tmp/redis.tar.gz -C /tmp
sh -c "cd /tmp/redis-$redisv/ && make -j $proc"
## running redis as daemon
/tmp/redis-$redisv/src/redis-server ./alphaserver/redis.conf
echo "sleep 5 sec for waiting to up"
sleep 5
## set auth for redis
/tmp/redis-$redisv/src/redis-cli config set requirepass devops

# setup flask and app
pip install flask
screen -dmS flask -m -d /bin/sh ./alphaserver/run.sh
