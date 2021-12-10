#!/bin/bash

_DIR="/tmp/heatmap"

count=0

function check() {
	i=$1
	j=$2
	pos=$(cat $_DIR/$i-$j 2>/dev/null)
	up=$(cat $_DIR/$((i-1))-$j 2>/dev/null)
        right=$(cat $_DIR/$i-$((j+1)) 2>/dev/null)
        down=$(cat $_DIR/$((i+1))-$j 2>/dev/null)
        left=$(cat $_DIR/$i-$((j-1)) 2>/dev/null)

        if [[ -z $up ]]; then
                up=$((pos+1))
        fi

        if [[ -z $left ]]; then
                left=$((pos+1))
        fi

        if [[ -z $right ]]; then
                right=$((pos+1))
        fi

        if [[ -z $down ]]; then
                down=$((pos+1))
        fi

        if [[ $up -gt $pos ]] && [[ $up -ne 9 ]]; then
		if [[ -e $_DIR/$((i-1))-$j ]]; then
			echo "$((i-1))-$j" | tee -a ./count.log
		fi
	fi

        if [[ $right -gt $pos ]] && [[ $right -ne 9 ]]; then
		if [[ -e $_DIR/$i-$((j+1)) ]]; then
			echo "$i-$((j+1))" | tee -a ./count.log
		fi
        fi

        if [[ $down -gt $pos ]] && [[ $down -ne 9 ]]; then
		if [[ -e $_DIR/$((i+1))-$j ]]; then
			echo "$((i+1))-$j" | tee -a ./count.log
		fi
	fi

        if [[ $left -gt $pos ]] && [[ $left -ne 9 ]]; then
		if [[ -e $_DIR/$i-$((j-1)) ]]; then
			echo "$i-$((j-1))" | tee -a ./count.log
		fi
	fi
}

function recursive() {
	for file in $1; do
		i=$(echo "$file" | cut -d"-" -f1)
		j=$(echo "$file" | cut -d"-" -f2)
		recursive "$(check $i $j)"
	done
}

for i in $(cat ./low-pos); do
	echo $i > ./count.log
	recursive "$i"
	echo "=== count[$(cat ./count.log | sort | uniq | wc -l)]"
done
