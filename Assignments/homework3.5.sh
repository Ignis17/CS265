#!/bin/bash

# Author: Joel Turbi
# Course: CS265
# Assignment: Homework#3.5
# Created: 10/1/2018

total=0

echo "**********************************************"
echo "**               Homework#3.5               **"
echo "**********************************************"
echo

echo "Enter name of file: "
read filename
count=$(grep -c ^ < "$filename")
echo "$filename has $count lines in total."
echo "**********************************************"
