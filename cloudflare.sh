#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Cloudflare IPWhitelist Script"
output "Copyright © 2020 Thien Tran <contact@thientran.io>."
output "Support: https://thientran.io/discord"
output ""

if [ -r /etc/os-release ]; then
    lsb_dist="$(. /etc/os-release && echo "$ID")"
fi

if [ "$lsb_dist" =  "ubuntu" ] || [ "$lsb_dist" =  "debian" ]; then
     apt -y install ufw wget
     # Opening Port 22 just in case so that we do not lose the internet connection when the rules are applied.
     ufw allow 22
     wget https://www.cloudflare.com/ips-v4
     wget https://www.cloudflare.com/ips-v6
     
     for ips in `cat ips-v4`;
     do
        ufw allow from $ips to any proto tcp port 80
        ufw allow from $ips to any proto tcp port 443
     done
     
     for ips in `cat ips-v6`;
     do
        ufw allow from $ips to any proto tcp port 80
        ufw allow from $ips to any proto tcp port 443
     done
     
     yes | ufw enable
elif [ "$lsb_dist" =  "fedora" ] || [ "$lsb_dist" =  "rhel" ] || [ "$lsb_dist" =  "centos" ]; then
     yum -y install firewalld wget
     wget https://www.cloudflare.com/ips-v4
     wget https://www.cloudflare.com/ips-v6
     for ips in `cat ips-v4`;
     do
        firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="$ips" port port="80" protocol="tcp" accept'
        firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="$ips" port port="443" protocol="tcp" accept'
     done
     
     for ips in `cat ips-v6`;
     do
        firewall-cmd --permanent --add-rich-rule='rule family="ipv6" source address="$ips" port port="80" protocol="tcp" accept'
        firewall-cmd --permanent --add-rich-rule='rule family="ipv6" source address="$ips" port port="443" protocol="tcp" accept'
     done
     firewall-cmd --reload
else 
     output "Unsupported distribution. This script only supports Fedora, RHEL, CentOS, Ubuntu, and Debian."
     exit 1
fi 

rm ips-v4
rm ips-v6

output "Cloudflare IPs have been whitelisted on port 80 and 443!"
