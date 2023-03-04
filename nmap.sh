#!/bin/bash
file=$1
lines=$(cat $file)
for line in $lines
do  
    echo "$line TCP" | tee -a nmaptcp.txt
    start=535
    nmap $line -p "1-$start" -sS -Pn | tee -a nmaptcp.txt
    while true
    do
        end=$(($start+5000))
        echo "$start-$end"
        nmap $line -p "$start-$end" -sS -Pn | tee -a nmaptcp.txt
        start=$(($start+5000))
        if [ $start == 65535 ]; then
            break
        fi
    done
done

for line in $lines
do  
    echo "$line UDP"|tee -a nmapudp.txt
    start=535
    nmap $line -p "1-$start" -sU -Pn | tee -a nmapudp.txt
    while true
    do   
        end=$(($start+5000))
        echo "$start-$end"
        nmap $line -p "$start-$end" -sU -Pn | tee -a nmapudp.txt
        start=$(($start+5000))
        if [ $start == 65535 ]; then
            break
        fi
    done
done