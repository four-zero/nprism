#!/bin/bash

docker image save bitnami/redis:7.0 -o images/bitnami.redis.7.0.tar
docker image save bitnami/clickhouse:23 -o images/bitnami.clickhouse.23.tar
docker image save timberio/vector:0.29.X-debian -o images/timberio.vector.0.29.X-debian.tar
docker image save jasonish/suricata:6.0 -o images/jasonish.suricata.6.0.tar
#docker image save bitnami/grafana:9 -o images/bitnami.grafana.9.tar
