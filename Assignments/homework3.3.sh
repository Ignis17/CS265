#!/bin/bash

# Author: Joel Turbi
# Course: CS265
# Assignment: Homework#3.3
# Created: 10/1/2018

echo "**********************************************"
echo "**               Homework#3.3               **"
echo "**********************************************"
echo
read -p "Find the average of 4 numbers: " num1 num2 num3 num4 
echo "**********************************************"
echo "The average of numbers entered are: " 
echo "$((($num1+$num2+$num3+$num4)/4))"
