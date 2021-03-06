#!/bin/bash
mkdir -p /tmp/zabbix-install
sudo wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+focal_all.deb -O /tmp/zabbix-install/zabbix-release_5.0-1+focal_all.deb
sudo dpkg -i /tmp/zabbix-install/zabbix-release_5.0-1+focal_all.deb
sudo apt update
sudo apt install -y zabbix-agent
sudo wget https://raw.githubusercontent.com/ikifar2012/Bash-Scripts/master/www/files/zabbix-install/zabbix_agentd.conf -O /tmp/zabbix-install/zabbix_agentd.conf.tmp
export HOSTNAME=$(hostname)
read -p "Enter Zabbix Server IP:" ZABBIXSERVER
export ZABBIXSERVER=$ZABBIXSERVER
cat /tmp/zabbix-install/zabbix_agentd.conf.tmp | envsubst > /tmp/zabbix-install/zabbix_agentd.conf
sudo mv /tmp/zabbix-install/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf
sudo systemctl stop zabbix-agent
sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent
echo "Zabbix agent running with hostname: $HOSTNAME"
sudo rm -r /tmp/zabbix-install