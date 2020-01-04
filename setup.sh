while [ "$1" != "" ]; do
    case $1 in
        -s | --alphaserver)     shift
                                master=$1
                                ;;
        -c | --alphaclient)     shift
                                node=$1
                                ;;
    esac
    shift
done

## setup alphaserver ##
ssh root@$master "git clone https://github.com/ahdianrawuli/gjk-tst.git /tmp/gjk-master;cd /tmp/gjk-master;/bin/bash alphaserver.sh"

## setup alphaclient ##
IFS=',' read -r -a array <<< "$node"
for i in "${array[@]}";
do
	ssh root@$node "git clone https://github.com/ahdianrawuli/gjk-tst.git /tmp/gjk-node;cd /tmp/gjk-node;/bin/bash alphaclient.sh"
done
