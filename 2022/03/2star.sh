#!/bin/bash

sum=0
priority=0

function compareList {
    comm -12 <(echo "$1" | sed 's/./\0\n/g' | sort) <(echo "$2" | sed 's/./\0\n/g' | sort) | uniq | sed '/^$/d'
}

unset first
unset second
unset third

while read line; do
    
    if [[ -z $first ]]; then
        first=$line
        continue
    fi

    if [[ -z $second ]]; then
        second=$line
        continue
    fi
    
    if [[ -z $third ]]; then
        third=$line
    fi
    
    output=$(compareList "$first" "$second")
    final=$(compareList "$output" "$third")

    ascii=$(printf '%d\n' "'$final")

    if [[ $ascii -ge 97 ]] && [[ $ascii -le 122 ]]; then
        priority=$(( ascii - 96 ))
    else
        priority=$(( ascii - 38 ))
    fi

    sum=$(( sum + priority))
    priority=0

    unset first
    unset second
    unset third

done <<<$(cat input.txt)

echo $sum
