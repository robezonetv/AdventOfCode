#!/bin/bash

for i in $(find ./data -type f); do
    echo "$i $(stat -c %s $i)"
done > 1star_all_size #| sort -k1 > 1star_all_size
