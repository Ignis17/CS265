#!/bin/bash

Bonus=500
read -p "Enter Status: " Status
read -p "Enter shift: " Shift
if [[ "$Status" = "H" && "$Shift" = 3 ]]; then
	echo "shift $Shift gets \$$Bonus bonus."
else 
	echo "only hoursly workers in"
	echo "shift 3 get a bonus."
fi
