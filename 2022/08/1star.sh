#!/bin/bash

declare -A m

read_matrix() {
    local i=0
    local line
    local j
    while read -r line; do
        j=0
        for v in $(echo $line | fold -w1); do
            m[$i,$j]="$v"
            j=$((j+1))
        done
        i=$((i+1))
    done
    rows=$((j-1))
    cols=$((i-1))
}

read_matrix < input.txt

trees=0
for i in $(seq 0 $rows); do
    for j in $(seq 0 $cols); do
        if [[ $i -eq 0 ]] || [[ $i -eq $rows ]] || [[ $j -eq 0 ]] || [[ $j -eq $cols ]]; then
            #echo -ne "!"
            trees=$((trees+1))
            continue
        else
            visible=4

            # UP
            for up in $(seq $((i-1)) -1 0); do
                if [[ ${m[$i,$j]} -le ${m[$up,$j]} ]]; then
                    visible=$((visible-1))
                    break
                fi
            done

            # DOWN
            for down in $(seq $((i+1)) $rows); do
                if [[ ${m[$i,$j]} -le ${m[$down,$j]} ]]; then
                    visible=$((visible-1))
                    break
                fi
            done

            # RIGHT
            for right in $(seq $((j+1)) $cols); do
                if [[ ${m[$i,$j]} -le ${m[$i,$right]} ]]; then
                    visible=$((visible-1))
                    break
                fi
            done

            # LEFT
            for left in $(seq $((j-1)) -1 0); do
                if [[ ${m[$i,$j]} -le ${m[$i,$left]} ]]; then
                    visible=$((visible-1))
                    break
                fi
            done
            
            if [[ $visible -gt 0 ]]; then
                #echo -ne ${m[$i,$j]}
                trees=$((trees+1))
            #else
            #    echo -ne "X"
            fi
        fi
    done
    #echo
done

echo "Visible trees: $trees"
