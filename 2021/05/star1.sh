#!/bin/bash

rm -rf /tmp/board
mkdir -p /tmp/board

function write() {
	#echo "$1"
	echo "." >> /tmp/board/$1
}

while read line; do
	x1=$(echo "$line" | cut -d"," -f1)
	y1=$(echo "$line" | cut -d"," -f2 | cut -d" " -f1)
	x2=$(echo "$line" | cut -d"," -f2 | cut -d" " -f3)
	y2=$(echo "$line" | cut -d"," -f3)

	# DISABLE DIAGONAL BLOCK
	if [[ $x1 -eq $x2 ]] || [[ $y1 -eq $y2 ]]; then
		echo "PROCESS [$x1,$y1 -> $x2,$y2]" &>/dev/null
	else
		continue
	fi
	# DISABLE DIAGONAL BLOCK

	if [[ $x1 -gt $x2 ]]; then
	#	echo "FIRST"
		run=0
		for i in $(seq $x2 $x1); do
			if [[ $y1 -gt $y2 ]]; then
				write "$i-$((y2+run))"
			fi
			if [[ $y2 -gt $y1 ]]; then
				write "$i-$((y2-run))"
			fi
			if [[ $y1 -eq $y2 ]]; then
				write "$i-$y1"
			fi
			run=$((run+1))
		done
	elif [[ $x1 -lt $x2 ]]; then
	#	echo "SECOND"
		run=0
                for i in $(seq $x1 $x2); do
                        if [[ $y1 -gt $y2 ]]; then
                                write "$i-$((y1-run))"
                        fi
                        if [[ $y2 -gt $y1 ]]; then
                                write "$i-$((y1+run))"
                        fi
			if [[ $y1 -eq $y2 ]]; then
				write "$i-$y1"
			fi
                        run=$((run+1))
                done
        elif [[ $x1 -eq $x2 ]]; then
	#	echo "THIRD"
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
	#	echo "FOUR"
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

	#echo "NEXT"

done <<<"$(cat ./input)"

echo "PROCESSING DONE"

sum=$(ls -lah /tmp/board | grep -v "\." | grep -v "total" | tr -s " " | cut -d" " -f5,9| sort -k1 -n | grep -v "^2 " | wc -l)

echo "crossed lines count[$sum]"
