SET allow_experimental_object_type = 1;

CREATE TABLE IF NOT EXISTS suricata.eveapplayer
(
    `timestamp` DateTime64(9, 'Asia/Shanghai'),
    `flow_id` UInt64,
    `parent_id` UInt64,
    `sensor_id` UInt64,
    `in_iface` LowCardinality(String),
    `pcap_cnt` UInt64,
    `event_type` LowCardinality(String),
    `vlan` Array(UInt16),
    `src_ip` String,
    `dest_ip` String,
    `src_port` UInt16,
    `dest_port` UInt16,
    `proto` LowCardinality(String),
    `icmp_type` UInt8,
    `icmp_code` UInt8,
    `pkt_src` LowCardinality(String),
    `metadata` JSON,
    `ether` JSON,
    `community_id` String,
    `dpi_result` String,
    `tenant_id` UInt64,
    `tx_id` UInt64,
    `http` JSON,
    `dns` JSON,
    `tls` JSON,
    `ssh` JSON
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(timestamp)
PRIMARY KEY timestamp
ORDER BY timestamp
TTL toDateTime(timestamp) + INTERVAL 7 DAY;
