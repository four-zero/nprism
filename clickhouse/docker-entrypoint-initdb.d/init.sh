#!/bin/bash

clickhouse-client -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/drop.sql

clickhouse-client -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/eveflow.sql

