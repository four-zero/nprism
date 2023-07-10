# 应用维度
## 分析资产的连接数量、连接时长、上下行数据量
SELECT
    dest_ip AS server,
    proto AS proto,
    dest_port AS port,
    count(flow_id) AS flow_count,
    floor(avg(flow.age), 2) AS flow_avg_age,
    min(flow.age) AS flow_min_age,
    max(flow.age) AS flow_max_age,
    sum(tupleElement(flow, 'pkts_toserver')) AS pkts_toserver,
    sum(tupleElement(flow, 'pkts_toclient')) AS pkts_toclient,
    sum(tupleElement(flow, 'bytes_toserver')) AS bytes_toserver,
    sum(tupleElement(flow, 'bytes_toclient')) AS bytes_toclient,
    toYYYYMMDD(min(tupleElement(flow, 'start'))) AS active_earliest,
    toYYYYMMDD(max(tupleElement(flow, 'start'))) AS active_latest
FROM suricata.eveflow
WHERE isIPv4String(dest_ip) AND (isIPAddressInRange(dest_ip, '10.0.0.0/8') OR isIPAddressInRange(dest_ip, '172.16.0.0/12') OR isIPAddressInRange(dest_ip, '192.168.0.0/16')) AND ((tupleElement(flow, 'state') = 'established') OR (bitAnd(reinterpretAsUInt16(reverse(unhex(tupleElement(tcp, 'tcp_flags_tc')))), 2) > 0) OR (bitAnd(reinterpretAsUInt16(reverse(unhex(tupleElement(tcp, 'tcp_flags_tc')))), 8) > 0))
GROUP BY
    server,
    proto,
    port
ORDER BY flow_count DESC;
