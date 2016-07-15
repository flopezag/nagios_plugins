#!/bin/bash

if [ "$1" = "-H" ] && [ "$(ipcalc -c $2 && echo valid_ip || echo invalid_ip)" = "valid_ip" ]; the
n
    # Gets the status of the swift in port 8080
    status=$(/usr/bin/curl -s http://$2:8080/healthcheck)

    if [ "${status}" == "OK" ]; then
        echo "Swift Healthcheck status: OK - Swift Proxy healthcheck is reporting ${status}|Respo
nse=$status;;;;"
        exit 0

    else
        echo "Swift Healthcheck status: CRITICAL - Swift Proxy healthcheck is reporting ${status}
|Response=$status;;;;"
        exit 2
    fi

else
    # Print help information 
    sName="`echo $0|awk -F '/' '{print $NF}'`"
    echo -e "\n\n\t\t### $sName Version 1.0###\n"
    echo -e "# Usage:\t$sName"
    echo -e "\t\t= check the health status of the swift in the port 8080\n"
    echo "# EXAMPLE:\t/usr/lib64/nagios/plugins/$sName"
    echo -e "\nCopyright (C) 2016 Fernando López (fernando.lopezaguilar@telefonica.com)\n\n"
    exit
fi
