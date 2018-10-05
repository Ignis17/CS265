#!/bin/bash

# Author: Joel Turbi
# Course: CS265
# Assignment: Homework#3.2
# Created: 10/1/2018

echo "**********************************************"
echo "**               Homework#3.2               **"
echo "**********************************************"
read -p "Enter 3 numbers: " num1 num2 num3
if [[ "$num1" -gt "$num2" && "$num1" -gt "$num3" ]]; then
	echo "$num1 is the biggest number."
elif [[ "$num2" -gt "$num1" && "$num2" -gt "$num3" ]]; then
	echo "$num2 is the biggest number."
else
	echo "$num3 is the biggest number."
fi

