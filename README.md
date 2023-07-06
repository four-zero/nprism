# nprism

## suricata
input:
    capture from some interface like: eth0
    suricata/etc/suricata.yaml
output:
    publish to channel suricata.eveflow
    publish to channel suricata.evestats

## redis
channel:
    redis pub/sub channel suricata.eveflow
    redis pub/sub channel suricata.evestats

## vector
input:
    subscribe from channel suricata.eveflow
    subscribe from channel suricata.evestats
    vector/etc/eveflow.toml
    vector/etc/evestats.toml
output:
    insert into clickhouse table suricata.eveflow
    insert into clickhouse table suricata.evestats
    
## clickhouse
db:
    create database: suricata clickhouse/docker-entrypoint-initdb.d/db.sql
table:
    create table: eveflow clickhouse/docker-entrypoint-initdb.d/eveflow.sql
    create table: evestats clickhouse/docker-entrypoint-initdb.d/evestats.sql

## grafana
sql:
    会话创建速率 sql/app_layer.flow.sql
    包捕获速率 sql/capture.sql
    主机资产 sql/host_asset.sql
    ...(其他主机视角分析图表) sql/host_xxx.sql
    应用资产 sql/service_asset.sql
    ...(其他应用视角分析图表) sql/service_xxx.sql
