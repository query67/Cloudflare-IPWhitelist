#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [ -r /etc/os-release ]; then
    lsb_dist="$(. /etc/os-release && echo "$ID")"
fi

if [ "$lsb_dist" =  "ubuntu" ] || [ "$lsb_dist" =  "debian" ]; then
     apt -y install ufw wget
     # Opening Port 22 just in case so that we do not lose the internet connection when the rules are applied.
     ufw allow 22
     wget https://www.cloudflare.com/ips-v4
     wget https://www.cloudflare.com/ips-v6
     
     yes | ufw enable
elif [ "$lsb_dist" =  "fedora" ] || [ "$lsb_dist" =  "rhel" ] || [ "$lsb_dist" =  "centos" ]; then
     yum -y install firewalld wget
     wget https://www.cloudflare.com/ips-v4
     wget https://www.cloudflare.com/ips-v6
     
     firewall-cmd --reload
else 
     output "Unsupported distribution. This script only supports Fedora, RHEL, CentOS, Ubuntu, and Debian."
fi 
