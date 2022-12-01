#!/bin/bash

elf=1
calories=0
while read carry; do
    if [[ -z $carry ]]; then
        echo "elf[$elf] = $calories"
        elf=$(( elf + 1 ))
        calories=0
    else
        calories=$(( calories + carry ))
    fi
done <<<$(cat input.txt)
