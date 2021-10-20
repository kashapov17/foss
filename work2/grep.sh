#!/bin/bash

if [[ -z $1 ]]; then
    journalctl | grep -P 'kernel:.*(?:Freeing).*(:?memory):.[1-9]\d{3,}'
else
    if [[ -f ${0%/*}/$1 ]]; then
	grep -P 'kernel:.*(?:Freeing).*(:?memory):.[1-9]\d{3,}' $1
    else
	echo "file $1 doesn't exist"
    fi
fi
