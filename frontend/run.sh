#!/bin/bash

LOG=/front.log

echo "FRONT_FRONT started."

nohup npm run start > $LOG 2>&1 &
