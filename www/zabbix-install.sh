#!/bin/bash
sudo wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+focal_all.deb -O /tmp/zabbix-install/zabbix-release_5.0-1+focal_all.deb
sudo dpkg -i /tmp/zabbix-install/zabbix-release_5.0-1+focal_all.deb
sudo apt update
sudo apt install -y zabbix-agent

sudo systemctl enable zabbix-agent
export HOSTNAME=$(hostname)
read -p "Enter Zabbix Server IP:" ZABBIXSERVER
export ZABBIXSERVER=$ZABBIXSERVER
cat /etc/zabbix/zabbix_agentd.conf | envsubst 