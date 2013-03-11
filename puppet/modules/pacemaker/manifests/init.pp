# http://clusterlabs.org/quickstart-redhat.html
# http://clusterlabs.org/doc/en-US/Pacemaker/1.1-plugin/html/Clusters_from_Scratch/index.html

Class['cman'] -> Class['pacemaker']

class pacemaker {
  include pacemaker::pcs

  package { ["pacemaker", "pcs"]:
    ensure => installed,
  }

  # package { "crmsh":
  #   ensure => installed,
  #   source => "http://download.opensuse.org/repositories/network:/ha-clustering/CentOS_CentOS-6/x86_64/crmsh-1.2.5-55.2.x86_64.rpm"
  # }

  service { 'pacemaker':
    ensure    => running,
    name      => 'pacemaker',
    enable    => true,
    subscribe => [ Package['pacemaker'], Package['cman'], File['/etc/cluster/cluster.conf'] ],
  }
}
