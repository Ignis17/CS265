#!/bin/bash
echo "Enter a filename: "
read filename
if [ ! -r "$filename" ]; then
	echo "File is not read-able"
exit 1
fi
