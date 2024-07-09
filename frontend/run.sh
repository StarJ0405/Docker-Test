#!/bin/bash

LOG=/front.log

echo "FRONT started."

nohup npm run start > $LOG 2>&1 &