#!/usr/bin/bash

chmod 755 comparator.sh

for i in {1..1}; do
    printf ">>>Running test %i:\n" "$i"
    ./comparator.sh "tests/${i}_1.txt" "tests/${i}_2.txt"
    printf "Program exited with code (%i)\n\n" $?
    echo "Verbose: "
    ./comparator.sh "tests/${i}_1.txt" "tests/${i}_2.txt" -v
    printf "Program exited with code (%i)\n\n" $?
done