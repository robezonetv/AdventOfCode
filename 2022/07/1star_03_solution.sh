#!/bin/bash

> ./2star_all_dirs

final=0
for i in $(find ./data -type d); do
    sum=0
    for j in $(grep "$i/" ./1star_all_size | awk '{print $2}'); do
        sum=$(( sum + j ))
    done

    echo "$i $sum" >> ./2star_all_dirs

    if [[ $sum -le 100000 ]]; then
        final=$(( final + sum ))
    fi
done
echo "$final"
