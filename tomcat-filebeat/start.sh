#!/bin/bash

curl -XPUT 'http://elk:9200/_template/filebeat?pretty' -d@/etc/filebeat/filebeat.template.json
#/etc/init.d/filebeat start
catalina.sh start
filebeat -e -c /etc/filebeat/filebeat.yml

