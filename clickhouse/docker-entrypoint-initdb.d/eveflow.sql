CREATE DATABASE IF NOT EXISTS suricata;

CREATE TABLE suricata.eveflow
(
    `timestamp` DateTime64(9, 'Asia/Shanghai'),
    `flow_id` UInt64,
    `parent_id` UInt64,
    `in_iface` LowCardinality(String),
    `src_ip` String,
    `dest_ip` String,
    `src_port` UInt16,
    `dest_port` UInt16,
    `proto` LowCardinality(String),
    `event_type` LowCardinality(String),
    `app_proto` LowCardinality(String),
    `icmp_type` UInt8,
    `icmp_code` UInt8,
    `response_icmp_type` UInt8,
    `response_icmp_code` UInt8,
    `spi` UInt32,
    `app_proto_ts` LowCardinality(String),
    `app_proto_tc` LowCardinality(String),
    `app_proto_orig` LowCardinality(String),
    `app_proto_expected` LowCardinality(String),
    `community_id` String,
    `tenant_id` LowCardinality(String),
    `ether` Tuple(
        dest_macs Array(String),
        src_macs Array(String)
    ),
    `flow` Tuple(
        pkts_toserver UInt64,
        pkts_toclient UInt64,
        bytes_toserver UInt64,
        bytes_toclient UInt64,
        bypassed Tuple(
            bytes_toclient UInt64,
            bytes_toserver UInt64,
            pkts_toclient UInt64,
            pkts_toserver UInt64
        ),
        start String,
        end String,
        age UInt64,
        emergency Bool,
        bypass LowCardinality(String),
        state LowCardinality(String),
        reason LowCardinality(String),
        alerted Bool,
        wrong_thread Bool,
        action LowCardinality(String)
    ), 
    `tcp` Tuple(
        tcp_flags String,
        tcp_flags_ts String,
        tcp_flags_tc String,
        syn Bool,
        fin Bool,
        rst Bool,
        psh Bool,
        ack Bool,
        urg Bool,
        enc Bool,
        cwr Bool,
        state LowCardinality(String),
        ts_gap Bool,
        tc_gap Bool,
        ts_max_regions UInt16,
        tc_max_regions UInt16
    ),

    INDEX tenant_id_idx app_proto TYPE set(1024) GRANULARITY 8,
    INDEX in_facle_idx in_iface TYPE set(1024) GRANULARITY 8,
    INDEX flow_id_idx flow_id TYPE bloom_filter GRANULARITY 8,
    INDEX src_ip_idx src_ip TYPE bloom_filter GRANULARITY 8,
    INDEX dest_ip_idx dest_ip TYPE bloom_filter GRANULARITY 8,
    INDEX src_port_idx src_port TYPE bloom_filter GRANULARITY 8,
    INDEX dest_port_idx dest_port TYPE bloom_filter GRANULARITY 8,
    INDEX proto_idx proto TYPE set(1024) GRANULARITY 8,
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
    groupUniqArray(8)(proto) AS service_proto,
    groupUniqArray(16)(dest_port) AS service_port,
    min(flow.start) AS service_active_earliest,
    max(flow.start) AS service_active_latest
FROM suricata.eveflow
WHERE (flow.pkts_toclient > 0) AND (flow.state != 'new')
GROUP BY dest_ip
ORDER BY service_active_latest DESC;
