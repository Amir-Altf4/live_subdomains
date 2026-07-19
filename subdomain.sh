#!/bin/bash
# subdomain enumeration script
# Usage: ./ subenum.sh <domain>

domain="$1"

if [ -z "$domain" ]; then
    echo "Usage: ./ subenum.sh <domain>"
    exit 1
fi

wordlist="/usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"

mkdir -p results

echo "[+] starting subdomain enumeration on $domain..."

while read -r word; do
    ( 
        candidate="$word.$domain"
        result=$(host "$candidate")
        if [[ "$result" == *"NXDOMAIN"* ]]; then
           echo "not found"
        else 
           echo "$candidate" >> results/live_subdomains.txt
           echo "found, live subdomains saved on results/live_subdomains.txt, running curl..."
           code=$(curl -o /dev/null -s -L -w "%{http_code}" "http://$candidate")
           if [[ "$code" == "000" ]]; then
             echo "no web server"
          else
             echo "web servers found: $code"
             echo "$candidate - $code" >> results/web_subdomains.txt
      
          fi 

        fi
    ) &  
    done < "$wordlist"
    wait
