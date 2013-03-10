class keepalived {
  package { 'keepalived':
    ensure => installed,
    name   => 'keepalived',
    source => 'http://svn.riviera.org.uk/repo/RPMS/keepalived/RPMS/x86_64/keepalived-1.2.1-5.el5.x86_64.rpm',
    provider => rpm,
  }

  service { 'keepalived':
    ensure    => true,
    name      => 'keepalived',
    enable    => true,
    subscribe => Package['keepalived'],
  }

  file { '/etc/keepalived/keepalived.conf':
    ensure  => present,
    mode    => '0644',
    owner  => 'root',
    group  => 'root',
    source  => 'puppet:///modules/keepalived/keepalived.conf',
    notify  => Service['keepalived'],
    require => Package['keepalived'],
  }

  file { '/etc/keepalived/bypass_ipvs.sh':
    ensure  => present,
    mode    => '0755',
    owner  => 'root',
    group  => 'root',
    source  => 'puppet:///modules/keepalived/bypass_ipvs.sh',
    notify  => Service['keepalived'],
    require => Package['keepalived'],
  }

}
