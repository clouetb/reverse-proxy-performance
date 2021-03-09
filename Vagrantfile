# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-8"
  config.vm.provider "vmware_desktop" do |v|
    v.vmx["memsize"] = "4096"
    v.vmx["numvcpus"] = "2"
  end

  ["kafka_vm", "druid_vm", "superset_vm", "webapp_vm"].each do |machine|
    config.vm.define "#{machine}"
    config.vm.synced_folder ".", "/vagrant"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = "vv"
    ansible.groups = {
      "webapp"   => ["webapp_vm"],
      "kafka"    => ["kafka_vm"],
      "druid"    => ["druid_vm"],
      "superset" => ["superset_vm"]
    } 
  end
end
