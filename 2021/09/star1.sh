#!/bin/bash

_DIR="/tmp/heatmap"

rm -rf $_DIR
rm -rf ./low-pos
mkdir -p $_DIR

i=0
while read line; do
	for (( j=0; j<${#line}; j++ )); do	
		echo ${line:$j:1} > $_DIR/$i-$j
	done
	i=$((i+1))
done<<<"$(cat ./input)"

sum=""

for file in $(ls -1 $_DIR); do
	i=$(echo "$file" | cut -d"-" -f1)
	j=$(echo "$file" | cut -d"-" -f2)

	pos=$(cat $_DIR/$file)

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

	if [[ $up -gt $pos ]] && [[ $left -gt $pos ]] && [[ $right -gt $pos ]] && [[ $down -gt $pos ]]; then
		sum="$sum$((pos+1))+"
	else
		continue
	fi

	echo "$file" >> ./low-pos
	#echo "$file"	
	#echo " $up "
	#echo "$left$pos$right"
	#echo " $down"
	#echo 
done

echo $sum | sed "s/+$//g" | bc
