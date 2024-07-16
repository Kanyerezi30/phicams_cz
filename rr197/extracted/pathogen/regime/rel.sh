#!/usr/bin/env bash
for i in $(ls *csv | grep -Ev "orig|domain|allregime|all")
do
	regime=$(echo $i | cut -f1 -d".")
	cat $(cat $i  | cut -f2 -d"," | sort -u | sed 's;.*;../../&.csv;' | sed -z 's/\n/ /g; s/ $/\n/') | awk -F"," '$10 == 1' | cut -f2 -d"," | awk -v var="$regime" '{print var","$0}' | grep -v "name"
done > allregime.csv


# create allregimes uniquely

cat allregime.csv | sort -u -k1,1 -k2,2 | awk -F"," '{print $2","$1}' > allpresenceabs.csv
