# configuration using the crm tool
# see http://clusterlabs.org/quickstart-redhat.html
exec { "disable stonith":
  command => "crm configure property stonith-enabled=false",
}
exec { "configure quorum policy":
  command => "crm configure property no-quorum-policy=ignore",
}
exec { "configure migration-threshold":
  command => "crm configure property migration-threshold=1",
}
exec { "configure resource stickiness":
  command => "pcs resource rsc defaults resource-stickiness=100",
}

exec { "configure vip":
# crm configure primitive web_ip ocf:heartbeat:IPaddr2 params ip=192.168.122.101 cidr_netmask=32 op monitor interval=1s
  command => "pcs resource create web_ip ocf:heartbeat:IPaddr2 params ip=33.33.33.50 cidr_netmask=32 op monitor interval=1s",
}

exec { "configure apache":
# crm configure primitive web_apache ocf:heartbeat:apache params \
# configfile="/etc/httpd/conf/httpd.conf" \
# port="80" \
# statusurl="http://127.0.0.1/server-status" \
# op start interval="0s" timeout="60s" \
# op monitor interval="10s" timeout="20s" \
# op stop interval="0s" timeout="60s"
  command => "pcs resource create web_apache ocf:heartbeat:apache params configfile='/etc/httpd/conf/httpd.conf' statusurl='http://127.0.0.1/server-status' port='80' op start interval=0s timeout=30s op stop interval=0s timeout=30s op monitor interval=5s timeout=10s",
}

exec { "apache on vip server":
# crm configure colocation apache-vip INFINITY: web_apache web_ip
  command => "pcs constraint colocation add web_apache web_ip",
}

exec { "apache after vip":
  command => "pcs constraint order add web_ip web_apache symmetrical",
}
