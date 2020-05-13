# Cloudflare IPWhitelist
Whitelist CloudFlare's IPs on port your selection of ports <br />
This script supports Fedora, RHEL, CentOS, Debian,and Ubuntu. <br>
`bash <(curl -sSL https://raw.githubusercontent.com/tommytran732/Cloudflare-IPWhitelist/master/cloudflare.sh)`

# Notes
Before you run the script, makes sure you have not opened those ports to all IPs as it will make this script useless. <br />
If you run SSHD on a port different from 22, make sure you have it opened or just change the command `ufw allow 22` to your appropriate port.
