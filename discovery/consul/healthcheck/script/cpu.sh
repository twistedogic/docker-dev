#!/bin/bash

if [ "$1" = "-w" ] && [ "$2" -gt "0" ] && [ "$3" = "-c" ] && [ "$4" -gt "0" ]; then
        loading=$[100-$(vmstat|tail -1|awk '{print $15}')]

        if [ $loading -ge $4 ]; then
                echo "Critical: $loading %"  
                $(exit 2)
        elif [ $loading -ge $2 ]; then
                echo "Warning: $loading %" 
                $(exit 1)
        else
                echo "CPU: $loading %" 
                $(exit 0)
        fi

fi

