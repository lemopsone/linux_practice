#!/usr/bin/bash

verbose=0
regex="(?<=^|\s)[+-]?(((\d*\.)?\d+)|(\d+\.))(?=$|\s)"
if [ "$3" == "--verbose" ] || [ "$3" == "-v" ]; then
    verbose=1
fi

if ! [[ ( -e "$1" ) && ( -e "$2" ) ]]; then
    if [ $verbose == 1 ]; then
        echo "error: invalid filename"
    fi
    exit 1
fi

one=$(grep -Po "$regex" "$1")
two=$(grep -Po "$regex" "$2")

if [ $verbose == 1 ]; then
    printf "%s\t%s\n" "$1" "$2"
    paste <(echo "$one") <(echo "$two")
fi

if [ "$one" == "$two" ]; then
    if [ $verbose == 1 ]; then
        echo "float sequences in $1 and $2 are equal"
    fi
    exit 0
else
    if [ $verbose == 1 ]; then
        echo "float sequences in $1 and $2 are not equal"
    fi
    exit 1
fi