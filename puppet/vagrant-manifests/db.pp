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
