#!/bin/bash

## VARIABLES
### Your channels go here. add more channels as you want
numberofchannels=2
declare -a a0=("tvg-id-channel1" "Name Channel 1" "Program Tittle" "Creative Program Description")
declare -a a1=("tvg-id-channel1" "Name Channel 1" "Program Tittle" "Creative Program Description")

starttimes=("000000" "010000" "020000" "030000" "040000" "050000" "060000" "070000" "080000" "090000" "100000" "110000" "120000" "130000" "140000" "150000" "160000" "170000" "180000" "190000" "200000" "210000" "220000" "230000")
endtimes=("010000" "020000" "030000" "040000" "050000" "060000" "070000" "080000" "090000" "100000" "110000" "120000" "130000" "140000" "150000" "160000" "170000" "180000" "190000" "200000" "210000" "220000" "230000" "235900")
BASEPATH="/your/folder/path"
DUMMYFILENAME=dummy.xml

		offset=$(TZ=EST date +%z)
		today=$(date +%Y%m%d)
		tomorrow=$(date --date="+1 day" +%Y%m%d)
		nextday=$(date --date="+2 day" +%Y%m%d)
		# tomorrow=$(date -v+1d +%Y%m%d)  ## if running on MAC or BSD
		echo '<?xml version="1.0" encoding="ISO-8859-1"?>' > $BASEPATH/$DUMMYFILENAME
		echo '<tv generator-info-name="mydummy" generator-info-url="https://null.null/">' >> $BASEPATH/$DUMMYFILENAME
        numberofiterations=$(($numberofchannels - 1))
        echo "Creating Dummy Epg ..."


		for i in $(seq 0 $numberofiterations); do # Number of Dummys -1 
			tvgid=a$i[0]
			name=a$i[1]
			echo '    <channel id="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
			echo '        <display-name lang="en">'${!name}'</display-name>' >> $BASEPATH/$DUMMYFILENAME
			echo '    </channel>' >> $BASEPATH/$DUMMYFILENAME
		done

		for i in $(seq 0 $numberofiterations) ;do
			tvgid=a$i[0]
			title=a$i[2]
			desc=a$i[3]
			for j in {0..23}; do
					echo '    <programme start="'$today${starttimes[$j]}' '$offset'" stop="'$today${endtimes[$j]}' '$offset'" channel="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
					echo '        <title lang="en">'${!title}'</title>' >> $BASEPATH/$DUMMYFILENAME
					echo '        <desc lang="en">'${!desc}'</desc>' >> $BASEPATH/$DUMMYFILENAME
					echo '    </programme>' >> $BASEPATH/$DUMMYFILENAME
			done
			for j in {0..23}; do
					echo '    <programme start="'$tomorrow${starttimes[$j]}' '$offset'" stop="'$tomorrow${endtimes[$j]}' '$offset'" channel="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
					echo '        <title lang="en">'${!title}'</title>' >> $BASEPATH/$DUMMYFILENAME
					echo '        <desc lang="en">'${!desc}'</desc>' >> $BASEPATH/$DUMMYFILENAME
					echo '    </programme>' >> $BASEPATH/$DUMMYFILENAME
			done
		        for j in {0..23}; do
					echo '    <programme start="'$nextday${starttimes[$j]}' '$offset'" stop="'$nextday${endtimes[$j]}' '$offset'" channel="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
					echo '        <title lang="en">'${!title}'</title>' >> $BASEPATH/$DUMMYFILENAME
					echo '        <desc lang="en">'${!desc}'</desc>' >> $BASEPATH/$DUMMYFILENAME
					echo '    </programme>' >> $BASEPATH/$DUMMYFILENAME
			done
		done

		echo '</tv>' >> $BASEPATH/$DUMMYFILENAME

echo "Done!"
sleep 2
