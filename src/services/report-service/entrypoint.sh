#!/bin/bash
set -e

cd /report-service

./wait-for-it.sh database:5432 --timeout=30 --strict
./wait-for-it.sh rabbitmq:5672 --timeout=30 --strict

exec java -jar report-service.jar