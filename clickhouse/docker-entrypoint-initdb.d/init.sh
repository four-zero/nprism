#!/bin/bash

clickhouse-client --port 9003 -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/drop.sql

clickhouse-client --port 9003 -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/eveflow.sql

