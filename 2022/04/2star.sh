#!/bin/bash

not_overlap=0
overlaps=0
while read line; do
    read -r set1 set2 <<<$(echo $line | tr ',' ' ')
    read -r f1 f2 <<<$(echo $set1 | tr '-' ' ')
    read -r s1 s2 <<<$(echo $set2 | tr '-' ' ')

    if [[ $f1 -gt $s2 ]]; then
        not_overlap=$(( not_overlap + 1 ))
    fi

    if [[ $s1 -gt $f2 ]]; then
        not_overlap=$(( not_overlap + 1 ))
    fi   

    overlaps=$(( overlaps + 1 ))

done <<<$(cat input.txt)
echo $(( overlaps - not_overlap ))
