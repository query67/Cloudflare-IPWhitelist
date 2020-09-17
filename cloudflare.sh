#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

get_ports(){
    read -a ports

    if [[ $ports = "" ]]; then
      output "You cannot put in an empty list of ports! Try again:"
      get_ports
    fi
}

output "Cloudflare IPWhitelist Script"
output "Copyright © 2020 Thien Tran <contact@thientran.io>."
output "Support: https://thientran.io/discord"
output ""

output "Enter the list of ports you want opened, separated by a space."
output "For example, if you want to open port 80, 443 and 8443, type: "
output "80 443 8443"

get_ports

if [ -r /etc/os-release ]; then
    lsb_dist="$(. /etc/os-release && echo "$ID")"
fi

if [ -r /etc/os-release ]; then
   lsb_dist="$(. /etc/os-release && echo "$ID")"
   dist_version="$(. /etc/os-release && echo "$VERSION_ID")"
else
   output "Unsupported Distribution! Only RHEL, CentOS, Fedora, Ubuntu, and Debian are supported!" 
   exit 1
fi

if [ "$lsb_dist" =  "ubuntu" ] || [ "$lsb_dist" =  "debian" ]; then
     apt -y install ufw wget
     # Opening Port 22 just in case so that we do not lose the internet connection when the rules are applied.
     ufw allow 22
     wget https://www.cloudflare.com/ips-v4
     wget https://www.cloudflare.com/ips-v6
     
     for ips in `cat ips-v4`;
     do
        for port in "${ports[@]}";
        do
            ufw allow from $ips to any proto tcp port $port
            ufw allow from $ips to any proto udp port $port
        done
     done
     
     for ips in `cat ips-v6`;
     do
        for port in "${ports[@]}";
        do
            ufw allow from $ips to any proto tcp port $port
            ufw allow from $ips to any proto udp port $port
        done
     done
     
     yes | ufw enable
elif [ "$lsb_dist" =  "fedora" ] || [ "$lsb_dist" =  "rhel" ] || [ "$lsb_dist" =  "centos" ]; then
     yum -y install firewalld wget
     wget https://www.cloudflare.com/ips-v4
     wget https://www.cloudflare.com/ips-v6
     for ips in `cat ips-v4`;
     do
        for port in "${ports[@]}";
        do
          firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address='"$ips"' port port='"$port"' protocol="tcp" accept'
          firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address='"$ips"' port port='"$port"' protocol="udp" accept'
        done
     done
     
     for ips in `cat ips-v6`;
     do
        for port in "${ports[@]}";
        do
          firewall-cmd --permanent --add-rich-rule='rule family="ipv6" source address='"$ips"' port port='"$port"' protocol="tcp" accept'
          firewall-cmd --permanent --add-rich-rule='rule family="ipv6" source address='"$ips"' port port='"$port"' protocol="udp" accept'
        done
     done
     firewall-cmd --reload
else 
     output "Unsupported distribution. This script only supports Fedora, RHEL, CentOS, Ubuntu, and Debian."
     exit 1
fi 

rm ips-v4
rm ips-v6

output "Cloudflare IPs have been whitelisted on your selected ports!"
