# -*- mode: ruby -*-
# vi: set ft=ruby :

nodes = [
  { :hostname => 'kerberos', :ip => '192.168.56.100', :box => 'ubuntu/trusty64', :ram => 512 },
  { :hostname => 'ldap', :ip => '192.168.56.102', :box => 'ubuntu/trusty64', :ram => 512 },
  { :hostname => 'nis',  :ip => '192.168.56.101', :box => 'chef/centos-6.5-i386'}
]

Vagrant.configure("2") do |config|

  # puppet
  config.librarian_puppet.puppetfile_dir = "puppet"
  config.librarian_puppet.placeholder_filename = ".MYPLACEHOLDER"
  config.librarian_puppet.use_v1_api = '1'
  config.librarian_puppet.destruct = false

  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".test.local"
      nodeconfig.vm.network :private_network, ip: node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--memory", memory.to_s]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", 'on']
      end
    end
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "security_services.pp"
    puppet.module_path = "puppet/modules"
  end
end