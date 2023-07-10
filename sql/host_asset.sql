## host维度
SELECT
    arrayJoin([dest_ip, src_ip]) AS host,
    count(flow_id) AS flow_count,
    floor(avg(flow.age), 2) AS flow_avg_age,
    min(flow.age) AS flow_min_age,
    max(flow.age) AS flow_max_age,
    sum(tupleElement(flow, 'pkts_toserver') + tupleElement(flow, 'pkts_toclient')) AS pkts,
    sum(tupleElement(flow, 'bytes_toserver') + tupleElement(flow, 'bytes_toclient')) AS bytes
FROM suricata.eveflow
WHERE isIPv4String(host) AND (isIPAddressInRange(host, '10.0.0.0/8') OR isIPAddressInRange(host, '172.16.0.0/12') OR isIPAddressInRange(host, '192.168.0.0/16'))
GROUP BY
    host
ORDER BY flow_count DESC;

SELECT
    arrayJoin([dest_ip, src_ip]) AS host,
    proto AS proto,
    count(flow_id) AS flow_count,
    floor(avg(flow.age), 2) AS flow_avg_age,
    min(flow.age) AS flow_min_age,
    max(flow.age) AS flow_max_age,
    sum(tupleElement(flow, 'pkts_toserver')) AS pkts_toserver,
    sum(tupleElement(flow, 'pkts_toclient')) AS pkts_toclient,
    sum(tupleElement(flow, 'bytes_toserver')) AS bytes_toserver,
    sum(tupleElement(flow, 'bytes_toclient')) AS bytes_toclient
FROM suricata.eveflow
WHERE isIPv4String(host) AND (isIPAddressInRange(host, '10.0.0.0/8') OR isIPAddressInRange(host, '172.16.0.0/12') OR isIPAddressInRange(host, '192.168.0.0/16'))
GROUP BY
    host,
    proto
ORDER BY flow_count DESC;

## server维度
SELECT
    dest_ip AS server,
    proto AS proto,
    count(flow_id) AS flow_count,
    floor(avg(flow.age), 2) AS flow_avg_age,
    min(flow.age) AS flow_min_age,
    max(flow.age) AS flow_max_age,
    sum(tupleElement(flow, 'pkts_toserver')) AS pkts_toserver,
    sum(tupleElement(flow, 'pkts_toclient')) AS pkts_toclient,
    sum(tupleElement(flow, 'bytes_toserver')) AS bytes_toserver,
    sum(tupleElement(flow, 'bytes_toclient')) AS bytes_toclient
FROM suricata.eveflow
WHERE isIPv4String(server) AND (isIPAddressInRange(server, '10.0.0.0/8') OR isIPAddressInRange(server, '172.16.0.0/12') OR isIPAddressInRange(server, '192.168.0.0/16'))
GROUP BY
    server,
    proto
ORDER BY flow_count DESC;

## client维度
SELECT
    src_ip AS client,
    proto AS proto,
    count(flow_id) AS flow_count,
    floor(avg(flow.age), 2) AS flow_avg_age,
    min(flow.age) AS flow_min_age,
    max(flow.age) AS flow_max_age,
    sum(tupleElement(flow, 'pkts_toserver')) AS pkts_toserver,
    sum(tupleElement(flow, 'pkts_toclient')) AS pkts_toclient,
    sum(tupleElement(flow, 'bytes_toserver')) AS bytes_toserver,
    sum(tupleElement(flow, 'bytes_toclient')) AS bytes_toclient
FROM suricata.eveflow
WHERE isIPv4String(client) AND (isIPAddressInRange(client, '10.0.0.0/8') OR isIPAddressInRange(client, '172.16.0.0/12') OR isIPAddressInRange(client, '192.168.0.0/16'))
GROUP BY
    client,
    proto
ORDER BY flow_count DESC;
