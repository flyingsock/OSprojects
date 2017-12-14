#!/bin/bash

if [ -z "$1" ]; then
        echo 'No arguments providied. Use -h or --help to get manual.'
fi;
while [ $# -gt 0 ]; do
        case "$1" in
                -h|--help)
                        echo $'logAnalyzer.sh [OPTIONS]'
                        echo $'\tThis program is used to show distinct logs with "FATAL" and "ERROR" levels'
                        echo $'\nUsage: \.logAlalyzer.sh <filename or absolute path to filename>'
                        exit 0
                        ;;
                *)
                        if [ ! -f "$1" ]; then
                                echo "File $1 does not exists! Aborting..."
                                exit 0
                        else logFile="$1"
                        fi;
                        shift 1
                        ;;
        esac
done

for ip in $(grep -P '^ERROR|FATAL' "$logFile" | cut -d '|' -f 3 | sed -r -e $'s/\s+/\t/g' | sort | uniq); do
        echo "$ip"
done