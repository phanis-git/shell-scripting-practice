#!/bin/bash

start_time=$(date +%s)

echo "Hi I am calculating difference between start and end time of script"
end_time=$(date +%s)

total_time=$(($start_time-$end_time))
echo "Total time ${total_time}"

