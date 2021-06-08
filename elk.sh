#!/bin/bash
##### this command it tobring up the ELK, if the images are not already present on the local then it will pull the required images and will build own images as per the requirement.

docker-compose up -d

### the reason for this sleep time, ELK comes up properly before performing other taasks.

sleep 120

### Below command will create the index with the JSON payload.

curl -XPOST -D- 'http://localhost:5601/api/saved_objects/index-pattern' -H 'Content-Type: application/json' -H 'kbn-version: 7.13.0' -u elastic:changeme -d '{"attributes":{"title":"logstash-*","timeFieldName":"@timestamp"}}'

### this command will download the required file from below url
#wget https://github.com/mintel/sre-interview-assets/blob/master/challenges/challenge_01_docker_elk_apache_logs/WEB_access_log.log.gz

### command to unzip the file
#gunzip WEB_access_log.log.gz

### below command will pass the localfile to logstash which is listening on port 5000
cat WEB_access_log_20181017-135516.log | nc localhost 5000
