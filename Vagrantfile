# -*- mode ruby -*-
# vi set ft=ruby 

boxes = [
    {
        :name => "kafka_vm",
        :mem => "4096",
        :cpu => "1"
    },
    {
        :name => "druid_vm",
        :mem => "16384",
        :cpu => "4"
    },
    {
        :name => "superset_vm",
        :mem => "2048",
        :cpu => "2"
    },
    {
        :name => "webapp_vm",
        :mem => "1536",
        :cpu => "1"
    }
]

# Get target vm passed on command line
# Use ARGV as first operand to preserve order of ARGV arguments
target_machines = ARGV & boxes.map {|boxes| boxes[:name]}
machines_to_process = []
# If no vm has been passed on the command line, do not touch the array of boxes
if target_machines.empty?
  machines_to_process = boxes
else
  # Build an array of machines to process ordered following the specification of the command line
  target_machines.each do |tm|
    machines_to_process += boxes.select { |x| x[:name] == tm }
  end
end

Vagrant.configure("2") do |config|
  machines_to_process.each do |opts|
    config.vm.define opts[:name] do |node|
      node.vm.box = "bento/centos-8"
      node.vm.provider "vmware_desktop" do |v|
        v.vmx["memsize"] = opts[:mem]
        v.vmx["numvcpus"] = opts[:cpu]
      end
      if opts == machines_to_process.last
        node.vm.provision "ansible" do |ansible|
          ansible.playbook = "playbook.yml"
          ansible.limit = "all"
          ansible.groups = {
            "naming"   => ["webapp_vm", "superset_vm", "kafka_vm", "druid_vm"],
            "java"     => ["kafka_vm", "druid_vm"],
            "python"   => ["webapp_vm", "superset_vm"],
            "webapp"   => ["webapp_vm"],
            "kafka"    => ["kafka_vm"],
            "druid"    => ["druid_vm"],
            "superset" => ["superset_vm"]
          }
        end
      end
    end
  end
end
