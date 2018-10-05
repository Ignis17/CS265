#!/bin/bash

# Author: Joel Turbi
# Course: CS265
# Assignment: Homework#3
# Created: 10/1/2018

echo "**********************************************"
echo "**               Homework#3.1               **"
echo "**********************************************"
echo "1) Display current directory."
echo "2) Display home directory."
echo "3) List items in current directory."
echo "4) Exit program."
read -p "Enter your choice: " reply
case $reply in
	"1") echo "Current directory is: "
		pwd ;;
	"2") echo "Home directory is: "
		echo $HOME ;;
	"3") echo "Item(s) in current directory is/are: "
		ls ;;
	"4") echo "Exiting program: "
	       echo
	       for i in {10..1}
	       do
		       echo $i
	       done
	       echo "Blast Off!" ;;
	*) echo "Invalid choice!"; exit 1;;
esac
