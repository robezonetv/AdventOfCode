#!/bin/bash

declare fish=(0 1 2 3 4 5 6 7 8)

for i in $(seq 0 8); do
	fish[$i]=0
done

for i in $(cat ./input | tr "," "\n"); do
	fish[$i]=$(( ${fish[$i]} + 1 ))
done

for day in $(seq 1 256); do
	helper=${fish[1]}
	fish[1]=${fish[2]}
	fish[2]=${fish[3]}
	fish[3]=${fish[4]}
	fish[4]=${fish[5]}
	fish[5]=${fish[6]}
	fish[6]=${fish[7]}
	fish[7]=${fish[8]}
	fish[8]=0
	if [[ ${fish[0]} -gt 0 ]]; then
		fish[8]=$((${fish[8]}+${fish[0]}))
		fish[6]=$((${fish[6]}+${fish[0]}))
	fi
	fish[0]=$helper
	helper=0
done

sum=0
for i in $(seq 0 8); do
	sum=$((sum+${fish[$i]}))
done

echo "Summary: [$sum]"
