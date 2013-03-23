# Class elrepo
#
# This class imports public GPG signing keys and configures
# ELRepo Yum repository for Red Hat like systems.
#
# Parameters:
#   ['majdistrelease']         - distribution major version
#   ['ensure']                 - present (default) / absent
#   ['proxy']                  - HTTP proxy: absent (default) or URL
#   ['gpgcheck']               - Check signatures: 1 (default) / 0 
#   ['gpgkey']                 - GPG key path
#   ['enabled_elrepo']         - enable ELRepo: 1 (default) / 0
#   ['enabled_elrepo_testing'] - enable ELRepo testing: 1 / 0 (default)
#   ['enabled_elrepo_kernel']  - enable ELRepo kernel: 1 / 0 (default)
#   ['enabled_elrepo_extras']  - enable ELRepo extras: 1 / 0 (default)
#
# Requires:
#   You should be on RHEL variant (CentOS, RHEL, Scientific etc.)
#
# Sample Usage:
#   include elrepo
#
class elrepo (
	$majdistrelease			= $elrepo::params::majdistrelease,
	$ensure					= $elrepo::params::ensure,
	$proxy					= $elrepo::params::proxy,
	$gpgcheck				= $elrepo::params::gpgcheck,
	$gpgkey					= $elrepo::params::gpgkey,
	$enabled_elrepo			= $elrepo::params::enabled_elrepo,
	$enabled_elrepo_testing	= $elrepo::params::enabled_elrepo_testing,
	$enabled_elrepo_kernel	= $elrepo::params::enabled_elrepo_kernel,
	$enabled_elrepo_extras	= $elrepo::params::enabled_elrepo_extras
) inherits elrepo::params {

	yum::gpgkey {
		"${gpgkey}":
			ensure	=> $ensure,
			source	=> 'puppet:///modules/elrepo/RPM-GPG-KEY-elrepo.org',
	}

	Yumrepo {
		proxy		=> $proxy,
		gpgcheck	=> $gpgcheck,
		gpgkey		=> "file://${gpgkey}",
		require		=> Yum::Gpgkey["${gpgkey}"],
	}

	yumrepo {
		'elrepo':
			descr		=> "ELRepo.org Community Enterprise Linux Repository - el${majdistrelease}",
			baseurl		=> "http://elrepo.org/linux/elrepo/el${majdistrelease}/\$basearch/",
			mirrorlist	=> "http://elrepo.org/mirrors-elrepo.el${majdistrelease}",
			enabled		=> $enabled_elrepo,
			protect		=> 0;
		'elrepo-testing':
			descr		=> "ELRepo.org Community Enterprise Linux Testing Repository - el${majdistrelease}",
			baseurl		=> "http://elrepo.org/linux/testing/el${majdistrelease}/\$basearch/",
			mirrorlist	=> "http://elrepo.org/mirrors-elrepo-testing.el${majdistrelease}",
			enabled		=> $enabled_elrepo_testing,
			protect		=> 0;
		'elrepo-kernel':
			descr		=> "ELRepo.org Community Enterprise Linux Kernel Repository - el${majdistrelease}",
			baseurl		=> "http://elrepo.org/linux/kernel/el${majdistrelease}/\$basearch/",
			mirrorlist	=> "http://elrepo.org/mirrors-elrepo-kernel.el${majdistrelease}",
			enabled		=> $enabled_elrepo_kernel,
			protect		=> 0;
		'elrepo-extras':
			descr		=> "ELRepo.org Community Enterprise Linux Extras Repository - el${majdistrelease}",
			baseurl		=> "http://elrepo.org/linux/extras/el${majdistrelease}/\$basearch/",
			mirrorlist	=> "http://elrepo.org/mirrors-elrepo-extras.el${majdistrelease}",
			enabled		=> $enabledc_elrepo_extras,
			protect		=> 0;
	}
}
