#!/bin/bash

./1star.sh | sort -n -k3 | tail -3 | cut -d"=" -f2 | awk '{s+=$1} END {print s}'
