#!/bin/bash


sum=0
while read game; do
    score=0
    case $game in
        "A X")
            score=4
            ;;
        "A Y")
            score=8
            ;;
        "A Z")
            score=3
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
            score=7
            ;;
        "C Y")
            score=2
            ;;
        "C Z")
            score=6
            ;;
        *)
            echo "MISTAKE"
            ;;
    esac
    sum=$(( sum + score ))
done <<<$(cat input.txt)
echo "$sum"
