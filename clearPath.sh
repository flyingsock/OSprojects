#!/bin/bash
while [ $# -gt 0 ]; do
        case "$1" in
                -h|--help)
                        echo $'\nUsage: clearPath.sh [OPTIONS]'
                        echo $'\tThis program is used to retrieve valid value of PATH enviroment variable.'
                        echo $'\tValid means \"Containing only paths, owning executable files\".'
                        echo $'\nUsage: ${scriptname} [OPTIONS]'
                        echo $'\t\t\t[OPTIONS]:'
                        echo $'\tp- or --paths [directory:directory:...]'
                        echo $'\tThis program works with other directories.'
                        exit 0
                        ;;
                -p|--paths)
                        paths="$2"
                        shift 2
                        ;;
                *)
                        echo "Wrong 1st argument: use -h or --help to get manual."
                        exit 0
                        ;;
        esac
done

if [ -z "$paths" ]; then
        paths=$PATH
fi

# remove duplicates
paths=$(echo "$paths" | tr ':' '\n' | sort | uniq | tr '\n' ':')

cleanPath=""
first=1
for d in $(echo "$paths" | sed 's/:/ /g'); do # shellcheck issue about ${"$paths"//:/ } does not work :(
        if [ -d "$d" ]; then
                r=$(find "$d" -type f -executable | wc -l)
                if [ "$r" -ne 0 ]; then
                        if [ $first -eq 1 ]; then
                                cleanPath="$cleanPath$d"
                                first=0
                        else cleanPath="$cleanPath:$d"
                        fi
                fi
        fi;
done

echo $cleanPath
