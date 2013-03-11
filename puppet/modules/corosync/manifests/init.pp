class corosync {
  package { 'corosync':
    ensure => installed,
  }

  # corosync should not be started by init.d pacemaker handles that
  service { 'corosync':
    enable    => false,
  }

  ## this is not needed as this will be managed by cman
  # file { '/etc/corosync/corosync.conf':
  #   ensure  => present,
  #   mode    => '0644',
  #   owner  => 'root',
  #   group  => 'root',
  #   source  => 'puppet:///modules/corosync/corosync.conf',
  #   notify  => Service['corosync'],
  #   require => Package['corosync'],
  # }
  # file { '/etc/corosync/service.d/pacemaker':
  #   ensure  => present,
  #   mode    => '0644',
  #   owner  => 'root',
  #   group  => 'root',
  #   source  => 'puppet:///modules/corosync/service.d/pacemaker',
  #   notify  => Service['corosync'],
  #   require => Package['corosync'],
  # }

  ## TODO: enable firewall rule
  ## iptables -I INPUT -p udp -m state --state NEW -m multiport --dports 5404,5405 -j ACCEPT
  # firewall { '100 corosync send':
  #   proto   => 'udp',
  #   dport   => '5404',
  #   state   => ['NEW'],
  #   action  => 'accept',
  # }
  # firewall { '100 corosync receive':
  #   proto   => 'udp',
  #   dport   => '5405',
  #   state   => ['NEW'],
  #   action  => 'accept',
  # }
}
