#!/bin/bash

echo "$(for i in $(cat ./input  | cut -d"|" -f2 | tr -s " " | sed "s/^ //g" | tr " " "\n"); do echo "$i"| wc -c; done | sort -n | uniq -c | grep " 3\| 4\| 5\| 8" | tr -s " " | awk '{ print $1 }' | tr "\n" "+" | sed 's/+$//g')" | bc
