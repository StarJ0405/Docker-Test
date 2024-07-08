#!/bin/bash

FRONT_PID=$(ps -ef | grep next-server | awk '{print $2}')


if [ -z "$FRONT_PID" ];

then

    echo "FRONT_FRONT is not running"

else

    kill -9 $FRONT_PID

    echo "FRONT_FRONT stopped."
	
	LOG=/home/ubuntu/honeybadger/frontend/front.log

	echo "FRONT_FRONT started."
	 
	nohup npm run start > $LOG 2>&1 &
fi
