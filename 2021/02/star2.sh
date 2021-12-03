#!/bin/bash

position=0
depth=0
aim=0

while read line; do
	action=$(echo "$line" | cut -d" " -f1)
	value=$(echo "$line" | cut -d" " -f2)

	case $action in
		"forward")
			position=$((position+value))
			depth=$((depth+((value*aim))))
			;;
		"down")
			#depth=$((depth+value))
			aim=$((aim+value))
			;;
		"up")
			#depth=$((depth-value))
			aim=$((aim-value))
			;;
	esac

done <<<$(cat ./input.txt)

echo "depth [$depth] | position [$position]"
echo "multiplex [$(($depth * $position))]"
