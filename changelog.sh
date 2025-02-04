#!/bin/sh

# Exports

KERNELDIR=`readlink -f .`;
BK=build/META-INF/com/google/android/aroma

export Changelog=Changelog.txt

if [ -f $Changelog ];
then
	rm -f $Changelog
fi

touch $Changelog

# Print something to build output
echo ${bldppl}"Generating changelog..."${txtrst}

for i in $(seq 5);
do
export After_Date=`date --date="$i days ago" +%m-%d-%Y`
k=$(expr $i - 1)
	export Until_Date=`date --date="$k days ago" +%m-%d-%Y`

	# Line with after --- until was too long for a small ListView
	echo '====================' >> $Changelog;
	echo  "     "$Until_Date       >> $Changelog;
	echo '===================='	>> $Changelog;
	echo >> $Changelog;

	# Cycle through every repo to find commits between 2 dates
	git log --oneline --after=$After_Date --until=$Until_Date >> $Changelog
	echo >> $Changelog;
done

sed -i 's/project/   */g' $Changelog

cp $Changelog $KERNELDIR/$BK/zionchangelog.txt
rm $Changelog

