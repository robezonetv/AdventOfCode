#!/bin/bash

_DIR="/tmp/stack"

rm -rf $_DIR
mkdir -p $_DIR

>output.log

while read line; do
	mkdir -p $_DIR
	for (( i=0; i<${#line}; i++ )); do
        	if [[ "(" == ${line:$i:1} ]]; then
			echo ")" > $_DIR/$i
		elif [[ "[" == ${line:$i:1} ]]; then
                        echo "]" > $_DIR/$i
		elif [[ "{" == ${line:$i:1} ]]; then
                        echo "}" > $_DIR/$i
		elif [[ "<" == ${line:$i:1} ]]; then
                        echo ">" > $_DIR/$i
		else
			name=$(ls -1 /tmp/stack | sort -n | tail -1)
			last=$(cat $_DIR/$name)
			if [[ "${line:$i:1}" == "$last" ]]; then
				rm -rf $_DIR/$name
			else
				corrupted="$corrupted ${line:$i:1}"
				rm -rf $_DIR
				break
			fi
                fi


	done
	mkdir -p $_DIR
	list=$(ls -1 $_DIR | sort -n -r)
	count=$(echo "$list" | wc -l)
	total=0
	if [[ $count -ne 0 ]]; then
		for file in $list; do
			symbol=$(cat $_DIR/$file)
			if [[ "$symbol" == ")" ]]; then
				total=$((((total*5))+1))
			elif [[ "$symbol" == "]" ]]; then
				total=$((((total*5))+2))
			elif [[ "$symbol" == "}" ]]; then
				total=$((((total*5))+3))
			elif [[ "$symbol" == ">" ]]; then
				total=$((((total*5))+4))
			fi
		done	
	fi
	if [[ $total -ne 0 ]]; then
		echo "======== star2[$total]" >> output.log
	fi
	rm -rf $_DIR
done<<<"$(cat ./input)"

sum=0
while read line; do
	count=$(echo $line | awk '{ print $1 }')
	char=$(echo $line | awk '{ print $2 }')
	if [[ "$char" == ")" ]]; then
		sum=$((sum+((count*3))))
	elif [[ "$char" == "]" ]]; then
		sum=$((sum+((count*57))))
	elif [[ "$char" == "}" ]]; then
		sum=$((sum+((count*1197))))
	elif [[ "$char" == ">" ]]; then
		sum=$((sum+((count*25137))))
	fi
done<<<"$(echo $corrupted | tr -s " " | tr " " "\n" | sort | uniq -c | tr -s " ")"

echo "star1: [$sum]"

count=$(echo "$(cat output.log | grep "star2" | cut -d"[" -f2 | cut -d"]" -f1| sort -n | wc -l)/2" | bc)

echo "star2: [$(cat output.log | grep "star2" | cut -d"[" -f2 | cut -d"]" -f1| sort -n | head -n $((count+1)) | tail -n1)]"
