SET allow_experimental_object_type = 1;

CREATE DATABASE IF NOT EXISTS suricata;

CREATE TABLE suricata.eveflow
(
    `timestamp` DateTime64(9, 'Asia/Shanghai'),
    `flow_id` UInt64,
    `parent_id` Nullable(UInt64),
    `in_iface` Nullable(String),
    `src_ip` String,
    `dest_ip` String,
    `src_port` Nullable(UInt64),
    `dest_port` Nullable(UInt64),
    `proto` String,
    `event_type` String,
    `app_proto` Nullable(String),
    `icmp_type` Nullable(UInt64),
    `icmp_code` Nullable(UInt64),
    `response_icmp_type` Nullable(UInt64),
    `response_icmp_code` Nullable(UInt64),
    `spi` Nullable(UInt64),
    `app_proto_ts` Nullable(String),
    `app_proto_tc` Nullable(String),
    `app_proto_orig` Nullable(String),
    `app_proto_expected` Nullable(String),
    `community_id` Nullable(String),
    `tenant_id` Nullable(String),
    `flow` JSON,
    `ether` JSON,
    `tcp` JSON,

    INDEX flow_id_idx flow_id TYPE bloom_filter GRANULARITY 8,
    INDEX in_facle_idx in_iface TYPE set(1024) GRANULARITY 8,
    INDEX src_ip_idx src_ip TYPE bloom_filter GRANULARITY 8,
    INDEX dest_ip_idx dest_ip TYPE bloom_filter GRANULARITY 8,
    INDEX src_port_idx src_port TYPE bloom_filter GRANULARITY 8,
    INDEX dest_port_idx dest_port TYPE bloom_filter GRANULARITY 8,
    INDEX proto_idx proto TYPE set(1024) GRANULARITY 8,
    INDEX event_type_idx event_type TYPE set(1024) GRANULARITY 8,
    INDEX app_proto_idx app_proto TYPE set(1024) GRANULARITY 8
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(timestamp)
PRIMARY KEY timestamp
ORDER BY timestamp
TTL toDateTime(timestamp) + INTERVAL 1 HOUR
SETTINGS index_granularity = 8192;

CREATE VIEW suricata.view_service
AS
SELECT
    dest_ip,
    groupUniqArray(10)(proto) AS service_proto,
    groupUniqArray(10)(dest_port) AS service_port,
    min(flow.start) AS min_timestamp,
    max(flow.start) AS max_timestamp
FROM suricata.eveflow
WHERE (flow.pkts_toclient > 0) AND (flow.state != 'new')
GROUP BY dest_ip
ORDER BY max_timestamp DESC;

