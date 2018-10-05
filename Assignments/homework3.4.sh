#!/bin/bash

# Author: Joel Turbi
# Course: CS265
# Assignment: Homework#3.4
# Created: 10/1/2018

echo "**********************************************"
echo "**               Homework#3.4               **"
echo "**********************************************"
echo
echo "Enter two integers: "
read num1
read num2 
echo "**********************************************"
echo "Enter choice: "
echo "1) + " 
echo "2) - "
echo "3) * "
echo "4) / "
read choice
echo "***********************"
case $choice in
	1)result=`echo $num1 + $num2 | bc`;;
	2)result=`echo $num1 - $num2 | bc`;;
	3)result=`echo $num1 \* $num2 | bc`;;
	4)result=`echo "scale=2; $num1 / $num2" | bc`;;
esac
echo "- The result is: $result"
echo "***********************"
