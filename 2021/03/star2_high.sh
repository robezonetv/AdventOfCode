#!/bin/bash

function part2() {
	countOut=$(cat ./input$1 | cut -c$2 | sort | uniq -c | sort -k2)
	count0=$(echo "$countOut" | head -1 | awk '{ print $1 }')
	count1=$(echo "$countOut" | tail -1 | awk '{ print $1 }')
	if [[ $count0 -gt $count1 ]]; then
		count="$count0 0"
	fi
	if [[ $count0 -lt $count1 ]]; then
		count="$count1 1"
	fi
	if [[ $count0 -eq $count1 ]]; then
		count="$count1 1"
	fi
	echo "$count"
	bit=$(echo "$count" | awk '{ print $2 }')
	number=$(echo "$count" | awk '{ print $1 }')
	dots=""
	for dot in $(seq 2 $2); do
		dots=$dots$(echo -ne ".")
	done
	if [[ $number -eq $1 ]]; then
		exit
	else
		grep "^$dots$bit" ./input$1 &> ./input$number
	fi
}
data=$(part2 1000 1)
for i in $(seq 2 12); do
	echo "Sekvence $((i-1)): #$data#"
	data=$(part2 "$(echo $data | awk '{ print $1 }')" $i)
done
echo "Sekvence 12: $data"
