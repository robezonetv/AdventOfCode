#!/bin/bash


for i in $(cat ./draw); do
	echo "Remove $i..."
	sed -e "s/ $i / /g" -i ./bingo2/*
	sed -e "s/^$i / /g" -i ./bingo2/*
	sed -e "s/ $i$/ /g" -i ./bingo2/*

	count=$(grep -v '[0-9]' ./bingo2/* | wc -l)
	if [[ $count -ge 1 ]]; then
        	name=$(ls -1 ./bingo2/* | cut -d"/" -f3 | cut -d"-" -f1 | sort | uniq)
	        bingos=$(echo "$name" | wc -l)
	        if [[ $bingos -eq 1 ]]; then
	                sum=$(echo $(cat ./bingo2/$name-row-column-* | tr "\n" " " | tr -s " " | tr " " "+" | sed 's/+$//g' | sed 's/^+//g') | bc)
	                echo "last is ready! after number:[$i] and sum[$sum] and multiplex $(( $i * $sum ))"
	                exit
	        fi

		echo "\_ removing whole bingo $i..."
		for i in $(grep -v '[0-9]' ./bingo2/*); do
			rm -rf ./bingo2/$(echo $i | cut -d"/" -f3 | cut -d"-" -f1)-*
		done
	fi
done
