#!/bin/bash

declare -A r
declare -A c

# ROPES
list="
H
1
"
# INIT
for i in $list; do
    echo $i
    r[$i]=0
    c[$i]=0
done

rekurze() {
    local move=$1
    local a=$2
    local b=$3

    if [[ $move == "U" ]]; then
        r[$a]=$((r[$a]-1))
    elif [[ $move == "R" ]]; then
        c[$a]=$((c[$a]+1))
    elif [[ $move == "D" ]]; then
        r[$a]=$((r[$a]+1))
    elif [[ $move == "L" ]]; then
        c[$a]=$((c[$a]-1))
    fi
    
    if [[ ${c[$b]} -ge $((c[$a]-1)) ]] && [[ ${c[$b]} -le $((c[$a]+1)) ]]; then
        if [[ ${r[$b]} -ge $((r[$a]-1)) ]] && [[ ${r[$b]} -le $((r[$a]+1)) ]]; then
            return 0
        fi
    fi
    
    if [[ $((b+1)) -ge 1 ]]; then
        return 0
    fi
    rekurze N $b $((b+1)) 
}

echo "${r[1]} ${c[1]}" > tail.log
while read line; do
    read -r action count <<<$(echo $line)

    for u in $(seq 1 $count); do
        rekurze $action H 1
    done
done <<<$(cat input_small.txt)

cat tail.log | sort | uniq | wc -l
