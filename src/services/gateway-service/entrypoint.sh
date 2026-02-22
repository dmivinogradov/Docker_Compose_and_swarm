#!/bin/bash

set -e  

cd /gateway-service

./wait-for-it.sh session-service:8081 -t 30 &
./wait-for-it.sh hotel-service:8082 -t 30 &
./wait-for-it.sh booking-service:8083 -t 30 &
./wait-for-it.sh loyalty-service:8085 -t 30 &
./wait-for-it.sh report-service:8086 -t 30 

wait

exec java -jar gateway-service.jar