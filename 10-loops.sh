#!/bin/bash

for i in {1..10}
do 
echo "$i"
done

for i in {"phani","kumar"}
do 
echo "$i"
done


for package in $@
do 
echo "Packages :: $package"
done