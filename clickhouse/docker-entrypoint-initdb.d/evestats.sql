SET allow_experimental_object_type = 1;

CREATE TABLE IF NOT EXISTS suricata.evestats
(
    `timestamp` DateTime64(9, 'Asia/Shanghai'),
    `event_type` LowCardinality(String),
    `stats` JSON
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(timestamp)
PRIMARY KEY timestamp
ORDER BY timestamp
TTL toDateTime(timestamp) + INTERVAL 7 DAY;
