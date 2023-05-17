#!/bin/bash

chmod 777 suricata
chmod 777 suricata/etc
chmod 777 suricata/lib
chmod 777 suricata/log

chmod 777 vector
chmod 777 vector/etc

chmod 777 clickhouse
chmod 777 clickhouse/docker-entrypoint-initdb.d
chmod 777 clickhouse/docker-entrypoint-startdb.d

chmod 777 minio
