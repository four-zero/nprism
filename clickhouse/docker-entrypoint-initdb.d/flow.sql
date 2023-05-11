DROP TABLE IF EXISTS suricata.evelogs;
DROP DATABASE IF EXISTS suricata;
CREATE DATABASE suricata;
CREATE TABLE suricata.evelogs
(
    `timestamp` DateTime64(9),
    `flow_id` UInt64,
    `in_iface` Nullable(String),
    `src_ip` String,
    `dest_ip` String,
    `src_port` Nullable(UInt64),
    `dest_port` Nullable(UInt64),
    `proto` String,
    `event_type` String,
    `app_proto` Nullable(String),
    INDEX flow_id_idx flow_id TYPE bloom_filter GRANULARITY 8,
    INDEX in_facle_idx in_iface TYPE set(1000) GRANULARITY 8,
    INDEX src_ip_idx src_ip TYPE bloom_filter GRANULARITY 8,
    INDEX dest_ip_idx dest_ip TYPE bloom_filter GRANULARITY 8,
    INDEX src_port_idx src_port TYPE bloom_filter GRANULARITY 8,
    INDEX dest_port_idx dest_port TYPE bloom_filter GRANULARITY 8,
    INDEX proto_idx proto TYPE set(1000) GRANULARITY 8,
    INDEX event_type_idx event_type TYPE set(1000) GRANULARITY 8,
    INDEX app_proto_idx app_proto TYPE set(1000) GRANULARITY 8
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(timestamp)
PRIMARY KEY timestamp
ORDER BY timestamp
TTL toDateTime(timestamp) + INTERVAL 1 HOUR
SETTINGS index_granularity = 8192;
