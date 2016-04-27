#!/bin/bash
HOST=$(docker-machine ip)
NAME=http-proxied-svn-username-test
ID=$(date +%y%m%d_%H%M%S)
docker build -t $NAME . || exit 1
docker run -d --name $NAME -p 80:80 $NAME || exit 1
docker exec $NAME repocreate test -o daemon || exit 1
svn import "$0" -m "test" --username "working--username" --password "" http://$HOST/svn/test/$ID
LOG=$(svn log --username "working--username" --password "" http://$HOST/svn/test/$ID)
docker logs $NAME
docker kill $NAME
docker rm $NAME
echo $LOG
echo $LOG | grep "working--username" || echo "Failure: Wrong user" && exit 1
