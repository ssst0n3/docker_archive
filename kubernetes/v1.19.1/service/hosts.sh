#!/bin/bash
HOSTNAME="kubernetes-1-19-1"

IP=$(ip -4 addr show eth1 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1 | head -n1)
if [ -z "$IP" ]; then
  IP=$(ip -4 addr show eth0 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1 | head -n1)
fi
if [ -z "$IP" ]; then
  echo "Error: Failed to get IP from either eth1 or eth0" >&2
  exit 1
fi
sed -i "/[[:space:]]${HOSTNAME}$/d" /etc/hosts
echo "$IP ${HOSTNAME}" >> /etc/hosts
echo "setup-hosts.sh: Successfully mapped second IP $IP to $HOSTNAME in /etc/hosts"