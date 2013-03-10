# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |vagrant_config|

  vagrant_config.vm.box_url = 'http://dl.dropbox.com/u/9227672/centos-5.6-x86_64-netinstall-4.1.6.box'
  vagrant_config.vm.box  = 'centos56'

  vagrant_config.vm.provision  :puppet do |puppet|
    puppet.manifests_path = 'puppet/vagrant-manifests'
    puppet.manifest_file = 'site.pp'
    puppet.module_path  = 'puppet/modules'
  end

  vagrant_config.vm.define :lb do |config|
    config.vm.customize ['modifyvm', :id, '--name', 'lb', '--memory', 256]
    config.vm.network :hostonly, '33.33.33.10'
    config.vm.host_name = 'lb'
    config.vm.forward_port 80, 8080 #haproxy
  end

  vagrant_config.vm.define :web1 do |config|
    config.vm.box_url = 'https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box'
    config.vm.box  = 'centos63'
    config.vm.customize ['modifyvm', :id, '--name', 'web1', '--memory', 256]
    config.vm.network :hostonly, '33.33.33.51'
    config.vm.host_name = 'web1'
    config.vm.forward_port 80, 8081, :auto => true #apache
  end

  vagrant_config.vm.define :web2 do |config|
    config.vm.box_url = 'https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box'
    config.vm.box  = 'centos63'
    config.vm.customize ['modifyvm', :id, '--name', 'web2', '--memory', 256]
    config.vm.network :hostonly, '33.33.33.52'
    config.vm.host_name = 'web2'
    config.vm.forward_port 80, 8082, :auto => true #apache
  end

  vagrant_config.vm.define :db do |config|
    config.vm.customize ['modifyvm', :id, '--name', 'db', '--memory', 512]
    config.vm.network :hostonly, '33.33.33.100'
    config.vm.host_name = 'db'
    config.vm.forward_port 3306, 3307 #mysql
  end
end
