SELECT
    timestamp AS ts,
    sum(stats.app_layer.flow.dcerpc_tcp_delta + stats.app_layer.flow.dcerpc_udp_delta) AS dcerpc, 
    sum(stats.app_layer.flow.dhcp_delta) AS dhcp, 
    sum(stats.app_layer.flow.dns_tcp_delta + stats.app_layer.flow.dns_udp_delta) AS dns, 
    sum(stats.app_layer.flow.failed_tcp_delta + stats.app_layer.flow.failed_udp_delta) AS failed, 
    sum("stats.app_layer.flow.ftp-data_delta" + stats.app_layer.flow.ftp_delta) AS ftp,
    sum(stats.app_layer.flow.http_delta) AS http, 
    sum(stats.app_layer.flow.ikev2_delta) AS ikev2, 
    sum(stats.app_layer.flow.imap_delta) AS imap, 
    sum(stats.app_layer.flow.krb5_tcp_delta + stats.app_layer.flow.krb5_udp_delta) AS krb5, 
    sum(stats.app_layer.flow.mqtt_delta) AS mqtt, 
    sum(stats.app_layer.flow.nfs_tcp_delta + stats.app_layer.flow.nfs_udp_delta) AS nfs, 
    sum(stats.app_layer.flow.ntp_delta) AS ntp, 
    sum(stats.app_layer.flow.rdp_delta) AS rdp, 
    sum(stats.app_layer.flow.rfb_delta) AS rfb, 
    sum(stats.app_layer.flow.sip_delta) AS sip, 
    sum(stats.app_layer.flow.smb_delta) AS smb, 
    sum(stats.app_layer.flow.smtp_delta) AS smtp, 
    sum(stats.app_layer.flow.snmp_delta) AS snmp, 
    sum(stats.app_layer.flow.ssh_delta) AS ssh,  
    sum(stats.app_layer.flow.tftp_delta) AS tftp, 
    sum(stats.app_layer.flow.tls_delta) AS tls
FROM suricata.evestats
GROUP BY ts
ORDER BY ts DESC
