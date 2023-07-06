#!/bin/bash

docker image load -i images/jasonish.suricata.6.0.tar
docker image load -i images/bitnami.redis.7.0.tar
docker image load -i images/timberio.vector.0.29.X-debian.tar
docker image load -i images/bitnami.clickhouse.23.tar
#docker image load -i images/bitnami.grafana.9.tar
