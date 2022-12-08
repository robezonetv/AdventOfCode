#!/bin/bash

fs=70000000
need=30000000
used=$(cat 2star_all_dirs | head -1 | cut -d" " -f2)

free=$(( fs - used ))
missing=$(( need - free ))

for i in $(find ./data -type d); do
    sum=0
    for j in $(grep "$i/" ./1star_all_size | awk '{print $2}'); do
        sum=$(( sum + j ))
    done

    if [[ $sum -ge $missing ]]; then
        echo "$i $sum"
    fi

done | sort -k2 -n | head -1 | cut -d" " -f2
