node 'basenode' {
  include epel
  include atomic
  include repoforge
}

node 'lb' inherits basenode {
  class { 'haproxy': }
}

node /^web.*/ inherits basenode {
  class { 'apache':
    default_mods => false,
  }

  class { 'apache::mod::php': }
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
  apache::mod { 'status': }

  apache::vhost { 'default':
    port            => '80',
    docroot         => '/vagrant/web/',
    configure_firewall => true,
    ssl => false,
  }

  class { 'corosync': }

  package { "pacemaker":
    ensure => "installed"
  }

  # enable firewall rule
  # iptables -I INPUT -p udp -m state --state NEW -m multiport --dports 5404,5405 -j ACCEPT

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
