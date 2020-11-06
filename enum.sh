#!/bin/bash
printf "\n"
echo "------------------------"
echo "------ quick_enum ------"
echo "-- ./enum.sh <subnet> --"
echo "------------------------"
echo "------- @bagels --------"
printf "\n"

## Take Subnet Arg
echo "------------------------"
printf "Subnet: ${1} \n"
echo "------------------------"
printf "\n"

## Ping Sweep
echo "------------------------"
printf "Performing Ping Sweep..\n"
echo `nmap -PE -sn -n $1 -oG - | awk '/Up$/{print $2}' >> alive_hosts.txt`
printf "Saved to alive_hosts.txt \n"
echo "------------------------"

## Quick Service Detection
printf "\n"
echo "------------------------"
printf "Performing Quick Service Detection..\n"
echo `nmap -sT -O -sV --version-all -Pn -n --iL alive_hosts.txt -oN service_enum.txt`
printf "Saved to service_enum.txt \n"
echo "------------------------"
printf "\n"

## Scan for DNS Servers
printf "\n"
echo "------------------------"
printf "Scanning for DNS Servers..\n"
echo `nmap -sS -sU -p 53 -Pn -n --iL alive_hosts.txt --open -oN dns_servers.txt`
printf "Saved to dns_servers.txt \n"
echo "------------------------"
printf "\n"

## Scan for SMTP Servers
printf "\n"
echo "------------------------"
printf "Scanning for SMTP Servers..\n"
echo `nmap -sS -p 25 -Pn -n --iL alive_hosts.txt --open -oN smtp_servers.txt`
printf "Saved to smtp_servers.txt \n"
echo "------------------------"
printf "\n"

## Scan for SMB/Samba Servers
printf "\n"
echo "------------------------"
printf "Scanning for SMB/Samba Servers..\n"
echo `nmap -sS -p 445 -Pn -n --iL alive_hosts.txt --open -oN smb_servers.txt`
printf "Saved to smb_servers.txt \n"
echo "------------------------"
printf "\n"

## Scan for NFS Servers
printf "\n"
echo "------------------------"
printf "Scanning for NFS Servers..\n"
echo `nmap -sS -p 111 -Pn -n --iL alive_hosts.txt --open -oN nfs_servers.txt`
printf "Saved to nfs_servers.txt \n"
echo "------------------------"
printf "\n"

## Scan for FTP Servers
printf "\n"
echo "------------------------"
printf "Scanning for FTP Servers..\n"
echo `nmap -sS -p 21 -Pn -n --iL alive_hosts.txt --open -oN ftp_servers.txt`
printf "Saved to ftp_servers.txt \n"
echo "------------------------"
printf "\n"

## Scan for HTTP/S Servers
printf "\n"
echo "------------------------"
printf "Scanning for HTTP Servers..\n"
echo `nmap -sS -p 80,443,8080,8081,8802 -Pn -n --iL alive_hosts.txt --open -oN http_servers.txt`
printf "Saved to http_servers.txt \n"
echo "------------------------"
printf "\n"

## Vuln Scan For Alive Hosts
printf "\n"
echo "------------------------"
printf "Running Vuln Scan for Alive Hosts..\n"
echo `nmap -sV --script=./scripts/NSE/vulscan.nse --iL alive_hosts.txt --open -oN vuln_scan.txt`
printf "Saved to vuln_scan.txt \n"
echo "------------------------"
printf "\n"




