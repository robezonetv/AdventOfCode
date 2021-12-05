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

	if [[ $x1 -eq $x2 ]] || [[ $y1 -eq $y2 ]]; then
		echo "PROCESS [$x1,$y1 -> $x2,$y2]"
	else
		continue
	fi

	if [[ $x1 -gt $x2 ]]; then
		#echo "FIRST"
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
	fi

	if [[ $x1 -lt $x2 ]]; then
		#echo "SECOND"
		run=0
                for i in $(seq $x1 $x2); do
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
	fi

	if [[ $x1 -eq $x2 ]]; then
		if [[ $y1 -gt $y2 ]]; then
			for i in $(seq $y2 $y1); do
				write "$x1-$i"
			done
		fi
		if [[ $y1 -lt $y2 ]]; then
			for i in $(seq $y1 $y2); do
				write "$x1-$i"
			done
		fi
		if [[ $y1 -eq $y2 ]]; then
			write "$x1-$y1"
		fi
        fi

	#echo "###"

done <<<"$(cat ./input)"

echo "PROCESSING DONE"

#max=0i
#imax_sum=0

sum=$(ls -lah /tmp/board | grep -v "\." | grep -v "total" | tr -s " " | cut -d" " -f5,9| sort -k1 -n | grep -v "^2 " | wc -l)

#for file in $(ls -1 ./board*); do
#	count=$(wc -l ./board/$file | awk '{print$1}')
#        if [[ $count -ge 2 ]]; then
#	        sum=$((sum+1))
#        fi
#done

#for j in $(seq 0 $board); do
#	for i in $(seq 0 $board); do
#		if [[ ! -e ./board/$i-$j ]]; then
#			echo -ne "."
#			continue
#		fi
#		count=$(wc -l ./board/$i-$j| awk '{print$1}')
#		echo -ne "$count"
#	done
#	echo -ne "\n"
#done

echo "crossed lines count[$sum]"
