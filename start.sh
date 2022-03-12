#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

docker stop $(docker ps -aq)
sudo docker-compose build && docker-compose up --remove-orphans -d
chown -R $DOCKER_USER:$DOCKER_USER ../$NAME