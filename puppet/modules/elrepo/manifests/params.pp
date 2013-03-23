# Class elrepo::params

class elrepo::params {
	$proxy					= absent
	$ensure					= present
	$gpgcheck				= 1
	$gpgkey					= '/etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org'
	$enabled_elrepo			= 1
	$enabled_elrepo_testing	= 0
	$enabled_elrepo_kernel	= 0
	$enabled_elrepo_extras	= 0

	if $::osfamily == 'RedHat' and $::operatingsystem != 'Fedora' {
		$version=split($::operatingsystemrelease,'[.]')
		$majdistrelease=$version[0] #first component
	} else {
		fail("Unsupported OS (${::operatingsystem})")
	}
}
