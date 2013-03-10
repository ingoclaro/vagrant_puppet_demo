class corosync {
  package { 'corosync':
    ensure => installed,
    name   => 'corosync',
  }

  service { 'corosync':
    ensure    => true,
    name      => 'corosync',
    enable    => true,
    subscribe => Package['corosync'],
  }

  file { '/etc/corosync/corosync.conf':
    ensure  => present,
    mode    => '0644',
    owner  => 'root',
    group  => 'root',
    source  => 'puppet:///modules/corosync/corosync.conf',
    notify  => Service['corosync'],
    require => Package['corosync'],
  }
  file { '/etc/corosync/service.d/pacemaker':
    ensure  => present,
    mode    => '0644',
    owner  => 'root',
    group  => 'root',
    source  => 'puppet:///modules/corosync/service.d/pacemaker',
    notify  => Service['corosync'],
    require => Package['corosync'],
  }

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
