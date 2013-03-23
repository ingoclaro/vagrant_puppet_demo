import 'nodes'

filebucket { main: server => puppet }

# global defaults
File { backup => main }
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }


# Always persist firewall rules
exec { 'persist-firewall':
  command     => $operatingsystem ? {
    'debian'          => '/sbin/iptables-save > /etc/iptables/rules.v4',
    /(RedHat|CentOS)/ => '/sbin/iptables-save > /etc/sysconfig/iptables',
  },
  refreshonly => true,
}

Firewall {
  notify  => Exec["persist-firewall"],
  before  => Class['my_fw::post'],
  require => Class['my_fw::pre'],
}
Firewallchain {
  notify  => Exec['persist-firewall'],
}

# Purge unmanaged firewall resources
#
# This will clear any existing rules, and make sure that only rules
# defined in puppet exist on the machine
resources { "firewall":
  purge => true
}

# firewall { '100 accept ssh access':
#   proto   => 'tcp',
#   dport   => '22',
#   state   => ['NEW'],
#   action  => 'accept',
# }
