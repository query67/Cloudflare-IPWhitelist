#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [ -r /etc/os-release ]; then
    lsb_dist="$(. /etc/os-release && echo "$ID")"
fi

if [ "$lsb_dist" =  "ubuntu" ] || [ "$lsb_dist" =  "debian" ]; then
     apt -y install ufw
     # Opening Port 22 just in case so that we do not lose the internet connection when the rules are applied.
     ufw allow 22
     ufw allow from 173.245.48.0/20 to any proto tcp port 80
     ufw allow from 103.21.244.0/22 to any proto tcp port 80
     ufw allow from 103.22.200.0/22 to any proto tcp port 80
     ufw allow from 103.31.4.0/22 to any proto tcp port 80
     ufw allow from 141.101.64.0/18 to any proto tcp port 80
     ufw allow from 108.162.192.0/18 to any proto tcp port 80
     ufw allow from 190.93.240.0/20 to any proto tcp port 80
     ufw allow from 188.114.96.0/20 to any proto tcp port 80
     ufw allow from 197.234.240.0/22 to any proto tcp port 80
     ufw allow from 198.41.128.0/17 to any proto tcp port 80
     ufw allow from 162.158.0.0/15 to any proto tcp port 80
     ufw allow from 104.16.0.0/12 to any proto tcp port 80
     ufw allow from 172.64.0.0/13 to any proto tcp port 80
     ufw allow from 131.0.72.0/22 to any proto tcp port 80
     ufw allow from 2400:cb00::/32 to any proto tcp port 80
     ufw allow from 2606:4700::/32 to any proto tcp port 80
     ufw allow from 2803:f800::/32 to any proto tcp port 80
     ufw allow from 2405:b500::/32 to any proto tcp port 80
     ufw allow from 2405:8100::/32 to any proto tcp port 80
     ufw allow from 2a06:98c0::/29 to any proto tcp port 80
     ufw allow from 2c0f:f248::/32 to any proto tcp port 80
     ufw allow from 173.245.48.0/20 to any proto tcp port 443
     ufw allow from 103.21.244.0/22 to any proto tcp port 443
     ufw allow from 103.22.200.0/22 to any proto tcp port 443
     ufw allow from 103.31.4.0/22 to any proto tcp port 443
     ufw allow from 141.101.64.0/18 to any proto tcp port 443
     ufw allow from 108.162.192.0/18 to any proto tcp port 443
     ufw allow from 190.93.240.0/20 to any proto tcp port 443
     ufw allow from 188.114.96.0/20 to any proto tcp port 443
     ufw allow from 197.234.240.0/22 to any proto tcp port 443
     ufw allow from 198.41.128.0/17 to any proto tcp port 443
     ufw allow from 162.158.0.0/15 to any proto tcp port 443
     ufw allow from 104.16.0.0/12 to any proto tcp port 443
     ufw allow from 172.64.0.0/13 to any proto tcp port 443
     ufw allow from 131.0.72.0/22 to any proto tcp port 443
     ufw allow from 2400:cb00::/32 to any proto tcp port 443
     ufw allow from 2606:4700::/32 to any proto tcp port 443
     ufw allow from 2803:f800::/32 to any proto tcp port 443
     ufw allow from 2405:b500::/32 to any proto tcp port 443
     ufw allow from 2405:8100::/32 to any proto tcp port 443
     ufw allow from 2a06:98c0::/29 to any proto tcp port 443
     ufw allow from 2c0f:f248::/32 to any proto tcp port 443
     yes | ufw enable
elif [ "$lsb_dist" =  "fedora" ] || [ "$lsb_dist" =  "rhel" ] || [ "$lsb_dist" =  "centos" ]; then
     yum -y install firewalld
else 
     output "Unsupported distribution. This script only supports Fedora, RHEL, CentOS, Ubuntu, and Debian."
fi 
