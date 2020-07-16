#!/bin/bash

# A basic iptables rule set script

# Flushing all rules.
echo "Flushing all the rules..."
/usr/sbin/iptables -F
/usr/sbin/iptables -X

echo "Set us up the bomb..."
# Block everything I don't need.
/usr/sbin/iptables -I FORWARD 1 -p tcp -m multiport --dports 21,22,80 -j ACCEPT # TCP ports
/usr/sbin/iptables -I FORWARD 2 -m state --state ESTABLISHED,RELATED -j ACCEPT

# This will watch for a possible bruteforce attempts by dropping any connection that attemps to make 3 or more ssh
# connections within one minute (60 seconds). (Also for ftp and can be used for other services as well.)

# SSH
# wlan0
/usr/sbin/iptables -A INPUT -i wlan0 -p tcp --dport 22 -m state --state NEW -m recent --set --name SSH
/usr/sbin/iptables -A INPUT -i wlan0 -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 3 --rttl --name SSH -j DROP
# eth0
/usr/sbin/iptables -A INPUT -i eth0 -p tcp --dport 22 -m state --state NEW -m recent --set --name SSH
/usr/sbin/iptables -A INPUT -i eth0 -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 3 --rttl --name SSH -j DROP

# FTP
# wlan0
/usr/sbin/iptables -A INPUT -i wlan0 -p tcp --dport 21 -m state --state NEW -m recent --set --name FTP
/usr/sbin/iptables -A INPUT -i wlan0 -p tcp --dport 21 -m state --state NEW -m recent --update --seconds 60 --hitcount 3 --rttl --name FTP -j DROP
# eth0
/usr/sbin/iptables -A INPUT -i eth0 -p tcp --dport 21 -m state --state NEW -m recent --set --name FTP
/usr/sbin/iptables -A INPUT -i eth0 -p tcp --dport 21 -m state --state NEW -m recent --update --seconds 60 --hitcount 3 --rttl --name FTP -j DROP

# Help Prevent DDoS
/usr/sbin/iptables -N syn-flood
/usr/sbin/iptables -A syn-flood -m limit --limit 100/second --limit-burst 150 -j RETURN
/usr/sbin/iptables -A syn-flood -j LOG --log-prefix "SYN flood: "
/usr/sbin/iptables -A syn-flood -j DROP

# Drop everything else
/usr/sbin/iptables -I FORWARD 3 -j DROP

echo "The New Rules have been set.."
