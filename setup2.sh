## config for alphaclients ##

filebeatv='7.5.1'
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$filebeatv-linux-x86_64.tar.gz -O /tmp/filebeat.tar.gz
tar xfvz /tmp/filebeat.tar.gz -C /tmp
screen -dmS filebeat -m -d /tmp/filebeat-$filebeatv-linux-x86_64/filebeat -E 'output.redis.hosts=0.0.0.0' -E 'output.redis.password=devops' -c ./alphaclient/log.yml
