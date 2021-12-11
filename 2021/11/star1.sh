#!/bin/bash

declare -A map

flash=0

x=0
while read line; do
	for ((y=0; y<${#line}; y++)); do
		val=${line:$y:1}
		map[$x,$y]=$val
	done
	x=$((x+1))
done<<<$(cat ./input)

function whoFlashes() {
	for ((i=0; i<$x; i++)); do
        	for ((j=0; j<$y; j++)); do
			if [[ ${map[$i,$j]} -eq -1 ]]; then
				echo -ne "$(tput setaf 1)0$(tput sgr0)"
			else
				echo -ne ${map[$i,$j]}
			fi
		done
		echo ""
	done
	echo ""
}	

function plusOne() {
	for ((i=0; i<$x; i++)); do
		for ((j=0; j<$y; j++)); do
			(( map[$i,$j]++ ))
		done
	done
}

function goFlash() {
	for ((i=0; i<$x; i++)); do
		for ((j=0; j<$y; j++)); do
			if [[ ${map[$i,$j]} -gt 9 ]]; then
				#echo "processing [$i,$j]"
				#top
				if [[ $i -ne 0 ]]; then
					if [[ ${map[$((i-1)),$j]} -ne -1 ]]; then
						#echo "\_ top"
						(( map[$((i-1)),$j]++ )) #top
					fi
				fi
				if [[ $i -ne 0 && $j -le $((y-1)) ]]; then
					if [[ ${map[$((i-1)),$((j+1))]} -ne -1 ]]; then
						#echo "\_ top right"
						(( map[$((i-1)),$((j+1))]++ )) #top right
					fi
				fi
				if [[ $j -le $((y-1)) ]]; then
					if [[ ${map[$i,$((j+1))]} -ne -1 ]]; then
						#echo "\_ right"
						(( map[$i,$((j+1))]++ )) #right
					fi
				fi
				if [[ $i -le $((x-1)) && $j -le $((y-1)) ]]; then
					if [[ ${map[$((i+1)),$((j+1))]} -ne -1 ]]; then
						#echo "\_ bottom right"
						(( map[$((i+1)),$((j+1))]++ )) #bottom right
					fi
				fi
				if [[ $i -le $((x-1)) ]]; then
					if [[ ${map[$((i+1)),$j]} -ne -1 ]]; then
						#echo "\_ bottom"
					       (( map[$((i+1)),$j]++ )) #bottom
					fi
				fi
				if [[ $i -le $((x-1)) && $j -ne 0 ]]; then
					if [[ ${map[$((i+1)),$((j-1))]} -ne -1 ]]; then
						#echo "\_ bottom left"
					       (( map[$((i+1)),$((j-1))]++ )) #bottom left
					fi
				fi
				if [[ $j -ne 0 ]]; then
					if [[ ${map[$i,$((j-1))]} -ne -1 ]]; then
						#echo "\_ left"
						(( map[$i,$((j-1))]++ )) #left
					fi
				fi
				if [[ $i -le $((x-1)) && $j -le $((y-1)) ]]; then
                                        if [[ ${map[$((i-1)),$((j-1))]} -ne -1 ]]; then
                                                #echo "\_ top left"
                                               (( map[$((i-1)),$((j-1))]++ )) #top left
                                        fi
                                fi
				map[$i,$j]=-1
			fi
		done
	done
}

function countFlashes() {
	countFlash=0
	for ((i=0; i<$x; i++)); do
                for ((j=0; j<$y; j++)); do
                        if [[ ${map[$i,$j]} -eq -1 ]]; then
				(( map[$i,$j]++ ))
				(( flash++ ))
                        fi
                done
        done
}

flash=0
for run in $(seq 1 100); do
	plusOne
	while [ 1 ]; do
		count=0
	        for ((i=0; i<$x; i++)); do
	                for ((j=0; j<$y; j++)); do
	                        if [[ ${map[$i,$j]} -gt 9 ]]; then
	                                goFlash
	                                ((count+=1))
	                        fi
	                done
	        done
		if [[ $count -eq 0 ]]; then
			break
		fi
	done
	countFlashes
done
echo "$flash"
