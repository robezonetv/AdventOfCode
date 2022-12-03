#!/bin/bash

sum=0
priority=0

while read line; do

    first=${line:0:${#line}/2}
    second=${line:${#line}/2}
    ascii=$(printf '%d\n' "'$(comm -12 <(echo "$first" | sed 's/./\0\n/g' | sort) <(echo "$second" | sed 's/./\0\n/g' | sort) | uniq | sed '/^$/d')")

    if [[ $ascii -ge 97 ]] && [[ $ascii -le 122 ]]; then
        priority=$(( ascii - 96 ))
    else
        priority=$(( ascii - 38 ))
    fi

    sum=$(( sum + priority))
    priority=0

done <<<$(cat input.txt)

echo $sum
