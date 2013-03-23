node 'basenode' {
  include epel
  include atomic
  include repoforge

  file { '/etc/hosts':
    ensure => present,
    content => '',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  host { 'localhost4':
    ensure       => present,
    ip           => '127.0.0.1',
    host_aliases => ['localhost.localdomain', 'localhost4', 'localhost4.localdomain4'],
    subscribe => File['/etc/hosts'],
  }
  host { 'localhost6':
    ensure       => present,
    ip           => '::1',
    host_aliases => ['localhost.localdomain', 'localhost6', 'localhost6.localdomain6'],
    subscribe => File['/etc/hosts'],
  }

  host { 'hostname':
    ensure       => present,
    name         => $hostname,
    ip           => $ipaddress_eth1,
    subscribe => File['/etc/hosts'],
  }

}

node 'lb' inherits basenode {
  class { 'haproxy': }
}

node /^web.*/ inherits basenode {

  class { 'apache':
    default_mods => false,
  }

  class { 'apache::mod::php': }
  class { 'apache::mod::status': }
  class { 'mysql::php': }

  apache::mod { 'authz_host': }
  apache::mod { 'dir': }
  apache::mod { 'mime': }
  apache::mod { 'log_config': }
  apache::mod { 'alias': }
  apache::mod { 'autoindex': }
  apache::mod { 'negotiation': }
  apache::mod { 'setenvif': }
  apache::mod { 'proxy': }

  apache::vhost { 'default':
    port            => '80',
    docroot         => '/vagrant/web/',
    configure_firewall => true,
    ssl => false,
  }

  class { 'corosync': }
  class { 'cman': }
  class { 'pacemaker': }
}

node 'db' inherits basenode {
  class { 'mysql': }

  class { 'mysql::server':
    config_hash => {
      'root_password' => 'zaqwsx',
      'bind_address' => '0.0.0.0',
    }
  }

  mysql::db { 'app_db':
    user     => 'user',
    password => 'password',
    host     => '%',
    grant    => ['Select_priv', 'Insert_priv', 'Update_priv', 'Delete_priv'],
  }

  database_user { 'migration_user@localhost':
    password_hash => mysql_password('password')
  }

  database_grant { 'migration_user@localhost/app_db':
    privileges => ['all'] ,
  }
}
