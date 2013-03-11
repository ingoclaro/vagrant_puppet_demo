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
crm configure primitive ClusterIP ocf:heartbeat:IPaddr2 params ip=192.168.122.101 cidr_netmask=32 op monitor interval=30s
  command => "pcs resource create web_ip ocf:heartbeat:IPaddr2 params ip=33.33.33.50 cidr_netmask=32 op monitor interval=1s",
}
