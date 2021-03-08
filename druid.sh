#!/bin/bash
sudo yum update -y
sudo yum install -y java-11-openjdk-headless.x86_64
wget https://downloads.apache.org/druid/0.20.1/apache-druid-0.20.1-bin.tar.gz
tar xvfz apache-druid-0.20.1-bin.tar.gz
