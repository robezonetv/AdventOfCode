#!/bin/bash

var=$(cat ./input.txt)

chars=$(echo "$var" | wc -c)

size=14

for i in $(seq 0 $chars); do
    val=$(echo "${var:$i:$size}" | fold -w1 | sort | uniq | wc -l)
    if [[ $val -eq $size ]]; then
        echo $(( i + $size ))
        break
    fi
done
