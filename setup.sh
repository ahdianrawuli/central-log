while [ "$1" != "" ]; do
    case $1 in
        -m | --alphaserver)     shift
                                master=$1
                                ;;
        -n | --alphaclient)     shift
                                node=$1
                                ;;
    esac
    shift
done

if [ -z "$master" ] || [ -z "$node" ];then
        echo "Command not valid";
        exit;
fi

## setup alphaserver ##
ssh root@$master "
if [ -d "/tmp/gjk-master" ]; then
        echo "git-pull..";
        sleep 1;
        cd /tmp/gjk-master;
        git pull;
        /bin/bash alphaserver.sh;
else
        echo "git-clone..";
        sleep 1;
        git clone https://github.com/ahdianrawuli/gjk-tst.git /tmp/gjk-master;
        cd /tmp/gjk-master;
        /bin/bash alphaserver.sh
fi
"

## setup alphaclient ##
IFS=',' read -r -a array <<< "$node"
for i in "${array[@]}";
do
        ssh root@$i "
        if [ -d "/tmp/gjk-node" ]; then
                echo "git-pull..";
                sleep 1;
                cd /tmp/gjk-node;
                git pull;
                /bin/bash alphaclient.sh $master;
        else
                echo "git-clone..";
                sleep 1;
                git clone https://github.com/ahdianrawuli/gjk-tst.git /tmp/gjk-node;
                cd /tmp/gjk-node;
                /bin/bash alphaclient.sh $master
        fi
"
done

echo -e "\r\nCheck the metrics ssh attempts in http://$master:5555";
