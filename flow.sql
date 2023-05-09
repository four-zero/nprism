CREATE TABLE evelogs
(
	    `event_type` String,
	    `timestamp` DateTime,
	    `src_port` UInt64,
	    `dest_port` UInt64,
	    INDEX src_port dest_port TYPE set(0) GRANULARITY 1
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(timestamp)
ORDER BY timestamp
TTL timestamp + toIntervalMonth(1)
SETTINGS index_granularity = 8192;
