#!/bin/bash

rm -rf ./bingo
rm -rf ./bingo2

row=0
bingo=0
while read line; do
	if [[ $row -eq 0 ]]; then
		echo "$line" | tr "," "\n" > draw
		row=$((row+1))
		continue
	fi

	if [[ -z "$line" ]]; then
		bingo=$((bingo+1))
		mkdir -p ./bingo
		>./bingo/$bingo-row
		continue
	fi

	echo "$line" | tr -s " " >> ./bingo/$bingo-row
	row=$((row+1))
done <<<"$(cat ./input)"

for row in $(ls -1 ./bingo/*); do
	for i in $(seq 1 5); do
		cat ./$row | tr -s " " | cut -d" " -f$i | tr "\n" " " >> ./$row-column
		echo "" >>./$row-column
	done
done

mkdir -p ./bingo2/
for file in $(ls -1 ./bingo/*); do
	run=0
	while read line; do
		file2=$(echo $file | cut -d"/" -f3)
		echo "$line" > ./bingo2/$file2-$run
		run=$((run+1))
	done <<<$(cat $file)
done
