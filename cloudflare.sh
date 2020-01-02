#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [ "$lsb_dist" =  "ubuntu" ] || [ "$lsb_dist" =  "debian" ]; then
     apt -y install ufw
     # Opening Port 22 just in case so that we do not lose the internet connection when the rules are applied.
     ufw allow 22
     ufw allow from 173.245.48.0/20 to any proto tcp port 80
     ufw allow from 103.21.244.0/22 to any proto tcp port 80
     ufw allow from 103.22.200.0/22 to any proto tcp port 80
     ufw allow from 103.31.4.0/22 to any proto tcp port 80
     
elif [ "$lsb_dist" =  "fedora" ] || [ "$lsb_dist" =  "rhel" ] || [ "$lsb_dist" =  "centos" ]; then
     yum -y install firewalld
else 
     output "Unsupported distribution. This script only supports Fedora, RHEL, CentOS, Ubuntu, and Debian."
fi 
