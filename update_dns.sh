#!/bin/bash
#
# DynDNS for iwantmyname
# including check between external IP and existing DNS entries in the internet
#

# Enviornment variables that are required
# DOMAIN
# SUBDOMAIN
# USERNAME
# PASSWORD

# get external IP
GETEXTIP=$(curl ipecho.net/plain ; echo | awk '{print $6}' | cut -f 1 -d "<")

# get external IP from DNS
GETDNSIP=$(dig +short $SUBDOMAIN.$DOMAIN @8.8.8.8)

# DEBUG COMMANDS
#echo "EXT: "$GETEXTIP
#echo "DNS: "$GETDNSIP

# Update DNS entry

if [ "$GETDNSIP" != "$GETEXTIP" ]; then
	 curl -0 --silent -u "$USERNAME:$PASSWORD" "https://iwantmyname.com/basicauth/ddns?hostname=$SUBDOMAIN.$DOMAIN&myip=$GETEXTIP" > /dev/null
fi

