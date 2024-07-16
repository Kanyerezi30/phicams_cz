#!/usr/bin/env bash
echo "Blood_cell,Status,Domain,Count" > summarize.csv
for i in $(ls */domain*yes.csv)
do
	cell=$(echo $i | cut -f1 -d"/")
	status=$(echo $i | cut -f1 -d"_" | cut -f2 -d"/")
	cut -f2 -d"," $i | sort | uniq -c | awk '{print $2","$1}' | sed "s/.*/$cell,$status,&/" | sed 's/domain//'
done >> summarize.csv
