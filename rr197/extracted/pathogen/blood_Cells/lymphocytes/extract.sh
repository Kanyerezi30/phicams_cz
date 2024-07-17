#!/usr/bin/env bash

for i in $(cat yesno)
do
	grep -wf $i ../../known_pathogen.csv > ${i}.csv
done
