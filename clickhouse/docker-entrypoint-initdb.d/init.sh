#!/bin/bash

clickhouse-client -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/drop.sql

clickhouse-client -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/db.sql

clickhouse-client -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/eveflow.sql

clickhouse-client -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/eveapplayer.sql

clickhouse-client -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/evestats.sql

clickhouse-client -u clickhouse --password 00000000 --multiquery </docker-entrypoint-initdb.d/asset.sql


