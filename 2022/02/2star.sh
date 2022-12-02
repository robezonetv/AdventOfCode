#!/bin/bash


sum=0
while read game; do
    score=0
    case $game in
        "A X")
            score=3
            ;;
        "A Y")
            score=4
            ;;
        "A Z")
            score=8
            ;;
        "B X")
            score=1
            ;;
        "B Y")
            score=5
            ;;
        "B Z")
            score=9
            ;;
        "C X")
            score=2
            ;;
        "C Y")
            score=6
            ;;
        "C Z")
            score=7
            ;;
        *)
            echo "MISTAKE"
            ;;
    esac
    sum=$(( sum + score ))
done <<<$(cat input.txt)
echo "$sum"
