package { 'augeas':
	ensure => latest,
}
package { 'ruby-augeas':
	ensure => latest,
}

augeas { "yum-x86_64" :
  context => "/files/etc/yum.conf",
  changes => "set exclude *.i?86",
}
