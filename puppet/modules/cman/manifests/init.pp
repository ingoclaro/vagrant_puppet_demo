class cman {
  package { ["cman", "ccs", "resource-agents"]:
    ensure => installed,
  }

  file { '/etc/cluster/cluster.conf':
    ensure  => present,
    mode    => '0644',
    owner  => 'root',
    group  => 'root',
    source  => 'puppet:///modules/cman/cluster.conf',
    require => Package['cman'],
  }

  service { 'cman':
    enable => false,
  }

  exec { "configure cman":
    command => "sed -i 's/#CMAN_QUORUM_TIMEOUT.*/CMAN_QUORUM_TIMEOUT=0/' /etc/sysconfig/cman",
    unless => "grep '^CMAN_QUORUM_TIMEOUT' /etc/sysconfig/cman 2>/dev/null",
    notify => Service['pacemaker']
  }

}
