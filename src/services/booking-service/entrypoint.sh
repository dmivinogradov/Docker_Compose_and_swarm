#!/bin/bash

set -e  

cd /booking-service

./wait-for-it.sh database:5432 -t 30 &
./wait-for-it.sh rabbitmq:5672 -t 30 &
./wait-for-it.sh hotel-service:8082 -t 30 &
./wait-for-it.sh payment-service:8084 -t 30 &
./wait-for-it.sh loyalty-service:8085 -t 30 &

wait

exec java -jar booking-service.jar