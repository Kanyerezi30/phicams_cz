#!/usr/bin/env bash

for i in $(ls *csv | grep -Ev "domain|orig|basophilspresabs")
do
	seg=$(echo $i | cut -f1 -d".")
	cat $i | cut -f1 -d"," | awk -v var=$seg '{print $0","var}'
done > basophilspresabs.csv


for i in $(ls *csv | grep "basophilspresabs")
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
