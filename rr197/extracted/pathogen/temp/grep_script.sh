#!/bin/bash
for i in $(ls *csv | grep -Ev "orig|domain|regi")
do
	cut -f1 -d"," $i | sed 's/.*/&,/' > tis.txt 
	# Define file names
	file1="tis.txt"
	file2="orig.csv"

	# Read the lines from file1
	while IFS= read -r line
	do
    		# Grep the line in file2
    		grep -F "$line" "$file2"
	done < "$file1" | cut -f2-3 -d"," | sort -u > domain${i}
done
