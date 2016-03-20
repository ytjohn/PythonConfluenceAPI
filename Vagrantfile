# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://developer.atlassian.com/docs/developer-tools/working-with-the-sdk/command-reference/atlas-run-standalone

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box='atlassiandev/connect'

  config.vm.network "forwarded_port", guest: 1990, host: 1990
  config.vm.provision "shell", path: "tests/start-confluence.sh"

  config.vm.provider "virtualbox" do |v|
    host = RbConfig::CONFIG['host_os']

    cpus = 2
    mem = 2048

    v.customize ["modifyvm", :id, "--memory", mem]
    v.customize ["modifyvm", :id, "--cpus", cpus]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

end
