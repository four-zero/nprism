CREATE TABLE IF NOT EXISTS suricata.asset
(
    `server` String,
    `client` String,
    `proto` LowCardinality(String),
    `port` UInt16,
    `app_proto` LowCardinality(String),
    `pkts_toserver` UInt64,
    `pkts_toclient` UInt64,
    `bytes_toserver` UInt64,
    `bytes_toclient` UInt64,
    `flow_count` UInt64,
    `active_earliest` DateTime64(9, 'Asia/Shanghai'),
    `active_latest` DateTime64(9, 'Asia/Shanghai')
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(active_latest)
PRIMARY KEY active_latest
ORDER BY active_latest;

CREATE MATERIALIZED VIEW suricata.asset_mv TO suricata.asset AS
SELECT
    dest_ip AS server,
    src_ip AS client,
    proto AS proto,
    dest_port AS port,
    app_proto AS app_proto,
    sum(tupleElement(flow, 'pkts_toserver')) AS pkts_toserver,
    sum(tupleElement(flow, 'pkts_toclient')) AS pkts_toclient,
    sum(tupleElement(flow, 'bytes_toserver')) AS bytes_toserver,
    sum(tupleElement(flow, 'bytes_toclient')) AS bytes_toclient,
    count(flow_id) AS flow_count,
    min(tupleElement(flow, 'start')) AS active_earliest,
    max(tupleElement(flow, 'start')) AS active_latest
FROM suricata.eveflow
WHERE (tupleElement(flow, 'state') = 'established') OR (bitAnd(reinterpretAsUInt16(reverse(unhex(tupleElement(tcp, 'tcp_flags_tc')))), 2) > 0) OR (bitAnd(reinterpretAsUInt16(reverse(unhex(tupleElement(tcp, 'tcp_flags_tc')))), 8) > 0)
GROUP BY
    server,
    client,
    proto,
    port,
    app_proto
ORDER BY active_latest DESC;
