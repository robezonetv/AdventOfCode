#!/bin/bash

declare -A pos=()

pos[1]="BSVZGPW"
pos[2]="JVBCZF"
pos[3]="VLMHNZDC"
pos[4]="LDMZPFJB"
pos[5]="VFCGJBQH"
pos[6]="GFQTSLB"
pos[7]="LGCZV"
pos[8]="NLG"
pos[9]="JFHC"

while read line; do
    read count from to <<<${line//[^0-9]/ }
    list=$(echo "${pos[$from]: -$count}")
    pos[$to]="${pos[$to]}$list"
    pos[$from]="${pos[$from]::-$count}"
done <<<$(cat input_moves.txt)

for i in $(seq 1 9); do
    echo -ne "${pos[$i]: -1}"
done

echo
