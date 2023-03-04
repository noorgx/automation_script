#!/bin/bash
file=$1
apt install nmap
lines=$(cat $file)
for line in $lines
do  
    echo "$line TCP" | tee -a tcp.txt
    nmap $line -p- -sS -Pn | tee -a tcp.txt
    git add .
    git commit -m "$line TCP"
    git push
done

for line in $lines
do  
    echo "$line UDP"|tee -a udp.txt
    nmap $line -p- -sU -Pn | tee -a udp.txt
    git add .
    git commit -m "$line UDP"
    git push
done
