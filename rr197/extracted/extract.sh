for i in $(ls *csv); do         id=$(echo $i | cut -f1 -d".");         awk -F"," '$10 == 1' $i | awk -F"," -v var=$id '{print $2","var}'; done > pathogen/known_pathogen.csv
