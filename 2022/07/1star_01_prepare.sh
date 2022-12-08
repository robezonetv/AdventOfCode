#!/bin/bash

root=$(pwd)
base="./data"
re='^[0-9]+$'

while read line; do
    read -r one two three four <<<$(echo $line)
    if [[ $one == "\$" ]]; then
        if [[ $two == "cd" ]]; then
            if [[ $three == "/" ]]; then
                cd $base
            elif [[ $three == ".." ]]; then
                cd ..
            else
                cd $three
            fi
        fi
    elif [[ $one == "dir" ]]; then
        mkdir $two
    elif [[ $one =~ $re ]]; then
        if [[ -e $two ]]; then
            echo "FATAL!"
        fi
        fallocate -l $one $two
    else
        echo "FUCK UP |$one|$two|$three|$four|"
    fi
done <<<$(cat input.txt)
