#!/bin/bash

rm -rf /tmp/board
mkdir -p /tmp/board
> compare.log

function write() {
	echo "$1"
	echo "." >> /tmp/board/$1
}

while read line; do
	x1=$(echo "$line" | cut -d"," -f1 | tr -d " ")
	y1=$(echo "$line" | cut -d"," -f2 | cut -d" " -f1 | tr -d " ")
	x2=$(echo "$line" | cut -d"," -f2 | cut -d" " -f3 | tr -d " ")
	y2=$(echo "$line" | cut -d"," -f3 | tr -d " ")

	if [[ $x1 -eq $x2 ]] || [[ $y1 -eq $y2 ]]; then
		echo "$x1,$y1 -> $x2,$y2" #>> ./compare.log
	else
		continue
	fi

	if [[ $x1 -eq $x2 ]]; then
		if [[ $y1 -ge $y2 ]]; then
			for i in $(seq $y2 $y1); do
				write "$x1-$i"
			done
			continue
		else
			for i in $(seq $y1 $y2); do
				write "$x1-$i"
			done
			continue
		fi
	elif [[ $y1 -eq $y2 ]]; then
		if [[ $x1 -ge $x2 ]]; then
			for i in $(seq $x2 $x1); do
				write "$i-$y1"
			done
			continue
		else
			for i in $(seq $x1 $x2); do
				write "$i-$y1"
			done
			continue
		fi
	fi
	echo "NEXT>>>"
done <<<"$(cat ./input)"

echo "PROCESSING DONE"

sum=$(ls -lah /tmp/board | grep -v "\." | grep -v "total" | tr -s " " | cut -d" " -f5,9| sort -k1 -n | grep -v "^2 " | wc -l)

echo "crossed lines count[$sum]"
