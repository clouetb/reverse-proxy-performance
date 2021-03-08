#!/bin/bash
sudo yum update -y
sudo yum install -y java-11-openjdk-headless.x86_64
wget https://downloads.apache.org/kafka/2.7.0/kafka_2.13-2.7.0.tgz
tar xvfz kafka_2.13-2.7.0.tgz