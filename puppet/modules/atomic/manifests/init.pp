# Class: atomic
#
#  The class ensures atomic repo is installed
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  include atomic
class atomic inherits atomic::params {

  if $::osfamily == 'RedHat' {

    yumrepo {'atomic' :
      descr      => "CentOS / Red Hat Enterprise Linux ${::os_maj_version} - atomicrocketturtle.com",
      mirrorlist => "http://www.atomicorp.com/mirrorlist/atomic/centos-${::os_maj_version}-${::architecture}",
      enabled    => 1,
      protect    => 0,
      gpgcheck   => 1,
      gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt",
    }

    file {"/etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt" :
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/atomic/RPM-GPG-KEY.art.txt',
    }

    atomic::rpm_gpg_key { "RPM-GPG-KEY.art.txt" :
      path => "/etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt",
    }

  } else {
    notice ("Your operating system ${::operatingsystem} will not have the atomic repository applied")
  }

}
