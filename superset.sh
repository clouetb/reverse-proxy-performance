#!/bin/bash
sudo yum update -y
sudo yum install -y python38-psycopg2 python38-pip python3-virtualenv python38-devel gcc gcc-c++
virtualenv -p /usr/bin/python3.8 env

PATH=/home/vagrant/env/bin:$PATH
PYTHONPATH=$PYTHONPATH:/home/vagrant
FLASK_APP=superset
export PATH PYTHONPATH FLASK_APP

pip3 install apache-superset
superset db upgrade
superset fab create-admin --username admin --password admin

if [ -f /vagrant/superset_config.py ]
then
    cp /vagrant/superset_config.py .
fi

