#!/bin/bash
echo "script to make files private"
echo "Select file to protect: "

select FILENAME in *
do
	echo "You picked $FILENAME ($REPLY)"
	chmod go-wrx "$FILENAME"
	echo "it is now private"
done
