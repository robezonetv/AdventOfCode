#!/bin/bash


for i in $(cat ./draw); do
	echo "Remove $i..."
	sed -e "s/ $i / /g" -i ./bingo2/*
	sed -e "s/^$i / /g" -i ./bingo2/*
	sed -e "s/ $i$/ /g" -i ./bingo2/*

	count=$(grep -v '[0-9]' ./bingo2/* | wc -l)
	if [[ $count -ge 1 ]]; then
		echo "winner is:"
		grep -v '[0-9]' ./bingo2/*
		exit
	fi
done
