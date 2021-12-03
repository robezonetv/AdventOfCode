#!/bin/bash

measure=0

for i in $(cat ./input.txt); do
	if [[ -z $prev ]]; then
		echo "$i (N/A - no previous measurement)"
		prev=$i
		continue
	fi

	if [[ $i -gt $prev ]]; then
		measure=$((measure+1))
		echo "$i (increased)"
	else
		echo "$i (decreased)"
	fi

	prev=$i	
done

echo "Total increased: $measure"
