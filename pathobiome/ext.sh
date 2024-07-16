#for i in $(cat COMBO.txt | cut -f1)
#do
#	id=$(grep $i COMBO.txt | cut -f2)
#	echo $id | sed 's/,/\n/g'  | grep -f - GIDS.tab  | sed 's/\t/,/' | sed "s/.*/&,$i/"
#done





for i in $(cat COMBO.txt | cut -f1)
do
        id=$(grep $i COMBO.txt | cut -f2)
        echo $id | sed 's/,/\n/g'  | grep -f - AIDS.tab  | sed 's/\t/,/' | sed "s/.*/&,$i/"
done
