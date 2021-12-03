#!/bin/bash

position=0
depth=0

while read line; do
	action=$(echo "$line" | cut -d" " -f1)
	value=$(echo "$line" | cut -d" " -f2)

	case $action in
		"forward")
			position=$((position+value))
			;;
		"down")
			depth=$((depth+value))
			;;
		"up")
			depth=$((depth-value))
			;;
	esac

done <<<$(cat ./input.txt)
echo "depth [$depth] | position [$position]"
echo "multiplex [$(($depth * $position))]"
