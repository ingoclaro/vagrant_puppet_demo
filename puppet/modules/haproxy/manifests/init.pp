# I tried the official (from puppetlabs) haproxy first, but didn't work well out of the box,
# as this is just an example I created the static file I needed and I'm copying to the server.
class haproxy {
  package { 'haproxy':
    ensure => installed,
    name   => 'haproxy',
  }

  service { 'haproxy':
    ensure    => true,
    name      => 'haproxy',
    enable    => true,
    subscribe => Package['haproxy'],
  }

  file { '/etc/haproxy/haproxy.cfg':
    ensure  => present,
    mode    => '0644',
    owner  => 'root',
    group  => 'root',
    source  => 'puppet:///modules/haproxy/haproxy.cfg',
    notify  => Service['haproxy'],
    require => Package['haproxy'],
  }
}
