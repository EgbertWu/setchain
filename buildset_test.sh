#!/bin/bash
datadir="/setdata"

cd /var/lib/jenkins/setchain

make all

cp -a ./build/bin/* ./docker/

cd ./docker/

docker build -t setchain/settest:setnode .

echo "Installing SetNode......"


mkdir $datadir

if [ ! -f $key ]
then 
{
	echo "$key is no exist,please upload them."
	exit 110
}
fi

cp -r ./$key $datadir/$key

echo "copied the key to $datadir."

sleep 5s 


docker run --name $nodename -itd --restart=always -v $datadir:$datadir -p 2022:2022 setchain/setimages:setnode -g ../genesis.json --p2p_listenaddr :2022 --p2p_name $1 --p2p_staticnodes=../nodes.txt --http_host 0.0.0.0 --http_port 8989 --datadir $datadir  --ipcpath /setdata/set.ipc --contractlog --http_modules=fee,miner,dpos,account,txpool,set
sleep 5s
docker exec -i $nodename ./set miner -i $datadir/set.ipc setcoinbase  "$nodename" $datadir/$key
sleep 5s
docker exec -i $nodename ./set miner -i $datadir/set.ipc start
