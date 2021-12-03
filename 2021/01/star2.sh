#!/bin/bash

compare() {
	group=$1
	letter=$2
	
	if [[ $group -gt $prev ]]; then
		echo "$letter: $group (increased)"
                measure=$((measure+1))
        elif [[ $group -lt $prev ]]; then
        	echo "$letter: $group (decreased)"
        elif [[ $group -eq $prev ]]; then
                echo "$letter: $group (no change)"
        fi	
}

measure=0
run=1
for i in $(cat ./input.txt); do
	if ! (( $run % 3 )); then
		groupA=$((groupA+i))
		if [[ -z $prev ]]; then
			echo "A: $groupA (N/A - no previous sum)"
		else
			compare $groupA "A"
		fi
		A=1
		prev=$groupA
		groupA=0
	else
		groupA=$((groupA+i))
	fi

	if ! (( (( $run - 1  )) % 3 )); then
		if [[ $A -eq 1 ]]; then
			groupB=$((groupB+i))
			compare $groupB "B"
			A=0
			B=1
			prev=$groupB
			groupB=0
		fi
	else
		groupB=$((groupB+i))
	fi

	if ! (( (( $run - 2 )) % 3 )); then
		if [[ $B -eq 1 ]]; then
			groupC=$((groupC+i))
			compare $groupC "C"
			B=0
			prev=$groupC
			groupC=0
		fi
	else
		if [[ $run -ne 1 ]]; then
			groupC=$((groupC+i))
		fi
	fi

	run=$((run+1))
done

echo "increased $measure"
