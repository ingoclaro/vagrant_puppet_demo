# use this file for configuring the services with pcs (new tool)
# use crm for better support
Class['pacemaker'] -> Class['pacemaker::pcs']

class pacemaker::pcs {

  exec { "disable stonith":
    command => "pcs property set stonith-enabled=false",
    unless => "pcs property | grep stonith-enabled 2>/dev/null"
  }
  exec { "configure quorum policy":
    command => "pcs property set no-quorum-policy=ignore",
    unless => "pcs property | grep no-quorum-policy 2>/dev/null"
  }
  exec { "configure migration-threshold":
    command => "pcs property set migration-threshold=1",
    unless => "pcs property | grep migration-threshold 2>/dev/null"
  }
  exec { "configure resource stickiness":
    command => "pcs resource rsc defaults resource-stickiness=100",
    unless => "pcs resource rsc defaults | grep resource-stickiness 2>/dev/null"
  }

  exec { "configure vip":
    command => "pcs resource create web_ip ocf:heartbeat:IPaddr2 params ip=33.33.33.50 cidr_netmask=32 op monitor interval=1s",
    unless => "pcs resource | grep web_ip 2>/dev/null"
  }
}
