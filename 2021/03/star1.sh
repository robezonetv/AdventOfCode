#!/bin/bash

bin=""
bon=""
for i in $(seq 1 12); do
	bin=$bin$(echo -ne "$(cat ./input | cut -c$i | sort | uniq -c | sort -k1 | head -1 | awk '{ print $2}')")
done

bon=$(echo $bin | tr 01 10)
echo $bin
echo $bon

echo "$((2#$bin))"
echo "$((2#$bon))"

echo "$(( 2#$bin * 2#$bon ))"
