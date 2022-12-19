#!/usr/bin/bash

verbose=0
regex="string:.*$"

if [ "$3" == "--verbose" ] || [ "$3" == "-v" ]; then
    verbose=1
fi

if ! [[ ( -e "$1" ) && ( -e "$2" )]]; then
    if [ $verbose == 1 ]; then
        echo "error: invalid filename"
    fi
    exit 1
fi

match_line=$(grep -En "$regex" "$1" | tail -1 | cut -d":" -f1)
one=$(sed -n "$match_line,\$p" "$1")

match_line=$(grep -En "$regex" "$2" | tail -1 | cut -d":" -f1)
two=$(sed -n "$match_line,\$p" "$2")

if [ $verbose == 1 ]; then
    printf "%s: %s\n%s: %s\n" "$1" "$one" "$2" "$two"
fi

if [ "$one" == "$two" ]; then
    if [ "$one" == "" ]; then
        if [ $verbose == 1 ]; then
            echo "substrings not found in files"
        fi
        exit 1
    fi
    if [ $verbose == 1 ]; then
        echo "substrings in $1 and $2 are equal"
    fi
    exit 0
else
    if [ "$verbose" == 1 ]; then
        echo "substrings in $1 and $2 are not equal"
    fi
    exit 1
fi
