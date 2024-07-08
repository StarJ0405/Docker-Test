#!/bin/bash

FRONT_PID=$(ps -ef | grep next-server | awk '{print $2}')


if [ -z "$FRONT_PID" ];

then

    echo "FRONT is not running"

else

    kill -9 $FRONT_PID

    echo "FRONT stopped."
	
fi

LOG=/home/ubuntu/honeybadger/frontend/front.log

echo "FRONT started."
 
nohup npm run start > $LOG 2>&1 &
 