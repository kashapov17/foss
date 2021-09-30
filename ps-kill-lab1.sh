#!/bin/bash

usage() {
    echo "Usage: $0 <seconds> <file>"
    exit
}

pkill() {
    local CLK_TCK=$(getconf CLK_TCK)

    while true; 
    do
        	
	PIDS=$(ps -e -o pid h | head -n -2)

 	echo "Found $(echo $PIDS | wc -w) processes"
    
 	for P in $PIDS
 	do
	    if [[ $(echo "$(cat /proc/$P/stat | awk '{print $14}') / $CLK_TCK" | bc) -gt $1 ]]; then
		kill $P

		$F <<< echo "$(date +%s) $P was killed\n" > $2
	    fi
 	done
    done
}

if [ -z $1 ]; then
    usage
fi

pkill
