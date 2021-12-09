#!/bin/bash

declare pos=()
declare dot=()

function segment() {

        dot[0]="."   #  aaaa
	dot[1]="."   # b    c
	dot[2]="."   # b    c
	dot[3]="."   #  dddd
	dot[4]="."   # e    f
	dot[5]="."   # e    f
	dot[6]="."   #  gggg

	word=$1

	for (( i=0; i<${#word}; i++ )); do
		for j in $(seq 0 6); do
			if [[ ${word:$i:1} == "${pos[$j]}" ]]; then
				dot[$j]=${pos[$j]}
			fi
		done
	done

#        echo " ${dot[0]}${dot[0]}${dot[0]}${dot[0]} "
#        echo "${dot[1]}    ${dot[2]}"
#        echo "${dot[1]}    ${dot[2]}"
#        echo " ${dot[3]}${dot[3]}${dot[3]}${dot[3]} "
#        echo "${dot[4]}    ${dot[5]}"
#        echo "${dot[4]}    ${dot[5]}"
#        echo " ${dot[6]}${dot[6]}${dot[6]}${dot[6]} "
#	echo ""

	number=$(IFS=''; echo "${dot[*]}")
	#echo "$number"
	if [[ ${#word} -eq 2 ]]; then
		echo -ne "1"
	elif [[ ${#word} -eq 3 ]]; then
		echo -ne "7"
	elif [[ ${#word} -eq 4 ]]; then
		echo -ne "4"
	elif [[ ${#word} -eq 7 ]]; then
		echo -ne "8"
	elif [[ $(echo $number | grep ".\....\..") ]]; then
	       echo -ne "2"
	elif [[ $(echo $number | grep ".\...\...") ]]; then
	       echo -ne "3"
	elif [[ $(echo $number | grep "..\..\...") ]]; then
	       echo -ne "5"
	elif [[ $(echo $number | grep "..\.....") ]]; then
	       echo -ne "6"
	elif [[ $(echo $number | grep "...\....") ]]; then
	       echo -ne "0"
	elif [[ $(echo $number | grep "....\...") ]]; then
		echo -ne "9"
	else
		echo "F*CK"
      	fi	       
}

sum=0

while read line; do
	pos[0]="."   #  aaaa
	pos[1]="."   # b    c
	pos[2]="."   # b    c
	pos[3]="."   #  dddd
	pos[4]="."   # e    f
	pos[5]="."   # e    f
	pos[6]="."   #  gggg

	input=$(echo "$line" | cut -d"|" -f1 | tr -s " " | sed 's/^ //g' | sed 's/ $//g' | cut -d"|" -f1 | tr -s " " | sed "s/^ //g" | tr " " "\n" | awk '{ print length(), $0 | "sort -n" }' | grep -v "0 " | cut -d" " -f2)
	output=$(echo "$line" | cut -d"|" -f2 | tr -s " " | sed 's/^ //g' | sed 's/ $//g')

	for word in $input; do
		case ${#word} in
			2)
				pos[2]=${word:0:1}
				pos[5]=${word:1:1}
				;;
			3)
				pos[0]=$(echo "$word" | sed "s/${pos[2]}//g" | sed "s/${pos[5]}//g")
				;;
			4)
				part=$(echo "$word" | sed "s/${pos[2]}//g" | sed "s/${pos[5]}//g" | sed "s/${pos[0]}//g")
				pos[1]=${part:0:1}
				pos[3]=${part:1:1}
				;;
			5)
				part=$(echo "$word" | sed "s/${pos[0]}//g" | sed "s/${pos[1]}//g" | sed "s/${pos[2]}//g" | sed "s/${pos[3]}//g" | sed "s/${pos[5]}//g")
				if [[ $(echo "$part" | awk '{ print length() }') -eq 1 ]]; then
					if [[ ${pos[6]} == "." ]]; then
						pos[6]=$part
					else
						if [[ ${pos[6]} != $part ]]; then
							temp=${pos[6]}
							pos[6]=$part
							pos[4]=$temp
						fi
					fi
				else
					if [[ ${pos[6]} == "." ]]; then
						pos[4]=${part:0:1}
						pos[6]=${part:1:1}
					else
						part=$(echo "$word" | sed "s/${pos[0]}//g" | sed "s/${pos[1]}//g" | sed "s/${pos[2]}//g" | sed "s/${pos[3]}//g" | sed "s/${pos[5]}//g" | sed "s/${pos[6]}//g")
						pos[4]=$part
					fi
					pos2=$(echo "$word" | sed "s/${pos[0]}//g" | sed "s/${pos[1]}//g" | sed "s/${pos[3]}//g" | sed "s/${pos[4]}//g" | sed "s/${pos[6]}//g" | sed "s/${pos[5]}//g")
					if [[ $(echo $pos2 | awk '{ print length() }') -eq 0 ]]; then
						temp=${pos[2]}
						pos[2]=${pos[5]}
						pos[5]=$temp
					fi
				fi
				;;
			6)
                        	part=$(echo "$word" | sed "s/${pos[0]}//g" | sed "s/${pos[1]}//g" | sed "s/${pos[2]}//g" | sed "s/${pos[4]}//g" | sed "s/${pos[5]}//g" | sed "s/${pos[6]}//g")
                                if [[ $(echo "$part" | awk '{ print length() }') -ne 0 ]]; then
					part=$(echo "$word" | sed "s/${pos[0]}//g" | sed "s/${pos[2]}//g" | sed "s/${pos[3]}//g" | sed "s/${pos[4]}//g" | sed "s/${pos[5]}//g" | sed "s/${pos[6]}//g")
					if [[ $(echo "$part" | awk '{ print length() }') -eq 0 ]]; then
						temp=${pos[1]}
						pos[1]=${pos[3]}
						pos[3]=$temp
					fi
                                fi
				;;
			7)
                        	part=$(echo "$word" | sed "s/${pos[0]}//g" | sed "s/${pos[1]}//g" | sed "s/${pos[2]}//g" | sed "s/${pos[3]}//g" | sed "s/${pos[4]}//g" | sed "s/${pos[5]}//g" | sed "s/${pos[6]}//g")
				if [[ $(echo "$part" | awk '{ print length() }') -ne 0 ]]; then
					echo "F*CK"
					echo "0:${pos[0]} 1:${pos[1]} 2:${pos[2]} 3:${pos[3]} 4:${pos[4]} 5:${pos[5]} 6:${pos[6]}"
				fi
				;;
			*)
				echo "F*CK"
				;;
		esac
		#segment $word
	done

	number=""
	for word in $output; do
		number="$number$(segment $word)"
	done

	sum="$sum+$number"

done <<<"$(cat ./input)";

echo "summary [$(echo "$sum" | bc)]"
