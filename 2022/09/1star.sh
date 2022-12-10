#!/bin/bash

declare -A m

checkTail() {
    local Hr=$1
    local Hc=$2
    local Tr=$3
    local Tc=$4

    if [[ $Tc -ge $((Hc-1)) ]] && [[ $Tc -le $((Hc+1)) ]]; then
        if [[ $Tr -ge $((Hr-1)) ]] && [[ $Tr -le $((Hr+1)) ]]; then
            return 1
        fi
    fi
    return 0
}

# start
Hr=10000
Hc=10000

Tr=10000
Tc=10000

echo "$Tr $Tc" > tail.log
while read line; do
    read -r action count <<<$(echo $line)

    if [[ $action == "U" ]]; then
        for u in $(seq 1 $count); do
            Hr=$((Hr-1))
            if checkTail $Hr $Hc $Tr $Tc; then
                Tr=$((Hr+1))
                Tc=$Hc
                echo "$Tr $Tc" >> tail.log
            fi
        done       
    elif [[ $action == "R" ]]; then
        for r in $(seq 1 $count); do
            Hc=$((Hc+1))
            if checkTail $Hr $Hc $Tr $Tc; then
                Tr=$Hr
                Tc=$((Hc-1))
                echo "$Tr $Tc" >> tail.log
            fi
        done
    elif [[ $action == "D" ]]; then
        for d in $(seq 1 $count); do
            Hr=$((Hr+1))
            if checkTail $Hr $Hc $Tr $Tc; then
                Tr=$((Hr-1))
                Tc=$Hc
                echo "$Tr $Tc" >> tail.log
            fi
        done 
    elif [[ $action == "L" ]]; then
        for l in $(seq 1 $count); do
            Hc=$((Hc-1))
            if checkTail $Hr $Hc $Tr $Tc; then
                Tr=$Hr
                Tc=$((Hc+1))
                echo "$Tr $Tc" >> tail.log
            fi
        done
    fi
done <<<$(cat input_small.txt)

cat tail.log | sort | uniq | wc -l
