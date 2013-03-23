class apache::mod::status {
  include apache::params
  apache::mod { 'status': }
  file { "${apache::params::vdir}/status.conf":
    ensure  => present,
    content => template('apache/mod/status.conf.erb'),
  }
}
