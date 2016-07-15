#!/bin/bash

if [ "$1" = "-w" ] && [ $(echo "$2 > 0" | bc) -eq 1 ] && [ "$3" = "-c" ] && [ $(echo "$4 > 0" | b
c) -eq 1 ]; then
    # Gets the total disk usages and disk total in kilobytes
    memory=$(rados df -p swift.buckets | awk '/total used/ {used=$3} ; /total space/ {space=$3} ;
 END {print used " " space}')
    
    diskUsed=$(echo $memory | awk '{print $1}')
    diskTotal=$(echo $memory | awk '{print $2}')

    # Convert from KB to GB dividing by 1024*1024
    diskUsed=$(echo "$diskUsed / 1048576" | bc)
    diskTotal=$(echo "$diskTotal / 1048576" | bc)
    diskUsedPrc=$(echo "scale=6; $diskUsed * 100 / $diskTotal" | bc | awk '{printf "%08f\n", $0}'
)

    if [ $(echo "$diskUsedPrc >= $4" | bc) -eq 1 ]; then
        echo "Rados Filesytem: CRITICAL Total: $diskTotal GB - Used: $diskUsed GB - $diskUsedPrc%
 used!|TOTAL=$diskTotal;;;; USED=$diskUsed;;;;"
        exit 2
    elif [ $(echo "$diskUsedPrc >= $2" | bc) -eq 1 ]; then
        echo "Memory: WARNING Total: $diskTotal GB - Used: $diskUsed GB - $diskUsedPrc% used!|TOT
AL=$diskTotal;;;; USED=$diskUsed;;;;"
        exit 1
    else
        echo "Memory: OK Total: $diskTotal GB - Used: $diskUsed GB - $diskUsedPrc% used|TOTAL=$di
skTotal;;;; USED=$diskUsed;;;;"
        exit 0
    fi
else            # If inputs are not as expected, print help. 
    sName="`echo $0|awk -F '/' '{print $NF}'`"
    echo -e "\n\n\t\t### $sName Version 1.0###\n"
    echo -e "# Usage:\t$sName -w <warnlevel> -c <critlevel>"
    echo -e "\t\t= warnlevel and critlevel is percentage value without %\n"
    echo "# EXAMPLE:\t/usr/lib64/nagios/plugins/$sName -w 80 -c 90"
    echo -e "\nCopyright (C) 2016 Fernando López (fernando.lopezaguilar@telefonica.com)\n\n"
    exit
fi
