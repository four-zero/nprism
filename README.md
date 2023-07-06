# nprism

## suricata
input:
    eth0
    suricata/etc/suricata.yaml
output:
    redis channel suricata.eveflow
    redis channel suricata.evestats

## redis
channel:
    redis channel suricata.eveflow
    redis channel suricata.evestats

## vector
input:
    redis channel suricata.eveflow
    redis channel suricata.evestats
    vector/etc/eveflow.toml
    vector/etc/evestats.toml
output:
    clickhouse table suricata.eveflow
    clickhouse table suricata.evestats
    
## clickhouse
db:
    suricata clickhouse/docker-entrypoint-initdb.d/db.sql
table:
    eveflow clickhouse/docker-entrypoint-initdb.d/eveflow.sql
    evestats clickhouse/docker-entrypoint-initdb.d/evestats.sql

## grafana
sql:
    会话创建速率 sql/app_layer.flow.sql
    包捕获速率 sql/capture.sql
    主机资产 sql/host_asset.sql
    应用资产 sql/service_asset.sql
