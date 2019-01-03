#!/bin/bash

# loading time 

for load in $(seq 1 100); do
    echo -ne "$load % downloded ...\r"
    sleep 1
done
echo "100"
echo "Loaded ..."

