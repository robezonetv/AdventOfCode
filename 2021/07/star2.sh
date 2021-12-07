#!/bin/bash

declare crab=()

for i in $(cat ./input | tr "," "\n"); do
	crab[${#crab[@]}]=$i	
done

align=$(echo "$(cat input | tr "," "\n" | sort -n | tr "\n" "+" | sed 's/+$//g')" | bc)
align=${align::-3}
fuel=0
for i in $(seq 0 $((${#crab[@]}-1))); do
	if [[ ${crab[$i]} -ge $align ]]; then
		cost=$(( ${crab[$i]} - $align ))
		for i in $(seq 1 $cost); do
			fuel=$(( fuel + $i )); 
		done
	elif [[ ${crab[$i]} -lt $align ]]; then
		cost=$(( $align - ${crab[$i]} ))
		for i in $(seq 1 $cost); do
			fuel=$(( fuel + $i ))
		done
	fi
done
echo $fuel

