SELECT
    timestamp AS ts,
    sum(stats.capture.kernel_packets_delta) AS capture,
    sum(stats.capture.kernel_drops_delta) AS drop,
    sum(stats.capture.errors_delta) AS error
FROM suricata.evestats
GROUP BY ts
ORDER BY ts DESC
