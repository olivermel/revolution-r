# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

 # create revolutionr node (change this to new project)

  config.vm.define :revolutionr do |revolutionr_config|
      revolutionr_config.vm.box = "bento/centos-6.7"
      revolutionr_config.vm.hostname = "revolutionr"
      revolutionr_config.vm.network :private_network, ip: "192.168.1.19"
      revolutionr_config.vm.provider "virtualbox" do |vb|
      end 
      revolutionr_config.vm.provision :shell, path: "bootstrap.sh", privileged: false
  end 

end
