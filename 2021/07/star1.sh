#!/bin/bash

declare crab=()

for i in $(cat ./input | tr "," "\n"); do
	crab[${#crab[@]}]=$i	
done

align=$(cat ./input | tr "," "\n" | sort -n | head -n 500 | tail -1)
fuel=0
for i in $(seq 0 $((${#crab[@]}-1))); do
	if [[ ${crab[$i]} -ge $align ]]; then
		fuel=$(( fuel + $(( ${crab[$i]} - $align )) ))
	elif [[ ${crab[$i]} -lt $align ]]; then
		fuel=$(( fuel + $(( $align - ${crab[$i]} )) ))
	fi
done
echo $fuel
