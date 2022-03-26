#!/bin/bash

cd $KAFKA_HOME/bin

#by default user server conf
START_SCRIPT=./kafka-server-start.sh
PROPS=../config/server.properties

if [[ "$KAFKA_RUN_AS" == "zookeeper" ]]
then
	START_SCRIPT=./zookeeper-server-start.sh 
	PROPS=../config/zookeeper.properties
fi


### reemplacing properties with .env values
envsubst "`printf '${%s} ' $(sh -c "env|cut -d'=' -f1")`" < $PROPS > run.properties 

bash $START_SCRIPT run.properties 