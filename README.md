# Cloudflare IPWhitelist
Whitelist CloudFlare's IPs on port 80/443 <br />
This script supports Fedora, RHEL, CentOS, Debian,and Ubuntu. <br>
`curl -sSL https://raw.githubusercontent.com/tommytran732/Cloudflare-IPWhitelist/master/cloudflare.sh | sudo bash`

# Notes
Before you run the script, makes sure you have not opened port 80/443 to all IPs as it will make this script useless. <br />
If you run SSHD on a port different from 22, make sure you have it opened or just change the command `ufw allow 22` to your appropriate port.
