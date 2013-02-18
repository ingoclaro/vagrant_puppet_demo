class { 'nginx': }

nginx::resource::upstream { 'web':
  ensure  => present,
  members => [
    '33.33.33.51:80',
    '33.33.33.52:80',
  ],
}

nginx::resource::vhost { 'web-test.local':
  ensure   => present,
  proxy  => 'http://web',
}
