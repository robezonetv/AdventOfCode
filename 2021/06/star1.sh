#!/bin/bash

declare fish=()

for i in $(cat ./input | tr "," "\n"); do
	fish[${#fish[@]}]=$i	
done

for day in $(seq 1 80); do
	echo -ne "Day $day: "
	for i in $(seq 0 $((${#fish[@]}-1))); do
		#echo -ne "${fish[$i]} "
		if [[ ${fish[$i]} -eq 0 ]]; then
			fish[${#fish[@]}]=8
			fish[$i]=6	
		else
			fish[$i]=$(( ${fish[$i]} - 1 ))
		fi
	done
	echo ""
done

echo ${#fish[@]}
