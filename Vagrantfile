# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-8"
  config.vm.provider "vmware_desktop" do |v|
    v.vmx["memsize"] = "4096"
    v.vmx["numvcpus"] = "2"
  end

  ["kafka", "druid", "superset", "webapp"].each do |machine|
    config.vm.define "#{machine}" do |instance|
      instance.vm.synced_folder ".", "/vagrant"
      instance.vm.provision "shell", path: "#{machine}.sh", privileged: false
    end
  end

end
