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
