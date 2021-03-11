# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [
    {
        :name => "kafka_vm",
        :eth1 => "192.168.205.10",
        :mem => "4096",
        :cpu => "1"
    },
    {
        :name => "druid_vm",
        :eth1 => "192.168.205.11",
        :mem => "16381",
        :cpu => "4"
    },
    {
        :name => "superset_vm",
        :eth1 => "192.168.205.12",
        :mem => "2048",
        :cpu => "2"
    },
    {
        :name => "webapp_vm",
        :eth1 => "192.168.205.12",
        :mem => "1536",
        :cpu => "1"
    }
]

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-8"

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.provider "vmware_fusion" do |v|
        v.vmx["memsize"] = opts[:mem]
        v.vmx["numvcpus"] = opts[:cpu]
      end
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = "vv"
    ansible.limit = "all"
    ansible.groups = {
      "webapp"   => ["webapp_vm"],
      "kafka"    => ["kafka_vm"],
      "druid"    => ["druid_vm"],
      "superset" => ["superset_vm"]
    } 
  end
end
