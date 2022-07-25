#!/bin/bash

	### Creation of the file containing the database(s) :

### wget et concatenation des codes html des pages avec des paquets

# We start from the 5000th package in the loop because we already downloaded two pages before in order to enter the loop and go through wc without error
	INCREM=5000
# We set CAT var to 0 for the concatenation part because the two downloaded files before the loop and the two removed files "balance" themselves
	CAT=0
# We start with NB=1 because the last downloaded file when entering the loop is page1
	NB=1 
# Number BIS corresponding to the naming of downloaded files
	NBBIS=2

	wget -q -o /dev/null -O page0.html 'https://aur.archlinux.org/packages?O=0&SeB=nd&K=&outdated=on&SB=p&SO=d&PP=2500&submit=Go'
	wget -q -o /dev/null -O page1.html 'https://aur.archlinux.org/packages?O=2500&SeB=nd&K=&outdated=on&SB=p&SO=d&PP=2500&submit=Go'

# Loop to download all the required database(s)
	until [[ $(wc -w < page"$NB".html) -lt 1000 ]] && [[ $(wc -w < page"$((NB-1 ))".html) -eq $(wc -w < page"$NB".html) ]]
	do
	wget -q -o /dev/null -O page$NBBIS.html 'https://aur.archlinux.org/packages?O='$INCREM'&SeB=nd&K=&outdated=on&SB=p&SO=d&PP=2500&submit=Go'
	INCREM=$((INCREM+2500))
	((CAT++))
	((NB++))
	((NBBIS++))
	done

# We clear empty files
	rm page"$NB".html page"$((NB-1))".html

# We concatenate the full files
	for (( i=0; i < CAT; i++ ))
	do
	cat page"$i".html >> raw_list.html
	done

# We clear the working directory
	for (( j=0; j < CAT; j++ ))
	do
	rm page"$j".html
	done


	### Parsing HTML
# The package version is on the same line as the flagged class and the package name is under the lines containing the /packages/ class.
sed -rn 's/.*flagged[^A-Za-z0-9]*([A-Za-z0-9._:.+-]+).*/\1/p' raw_list.html > list.txt
sed -rn 's/.*href="\/packages\/[^A-Za-z0-9]*([A-Za-z0-9._:.+-]+).*/\1/p' raw_list.html > list2.txt
paste -d " " list2.txt list.txt > listF.txt
rm list.txt list2.txt raw_list.html

	### Pacman list generation :
pacman -Qn > paclist.txt
pacman -Qm >> paclist.txt

	### Comparing and printing :
sort -d listF.txt > listF_sorted.txt
sort -d paclist.txt > paclist_sorted.txt
comm -12 paclist_sorted.txt listF_sorted.txt

	### Cleaning :
rm paclist.txt paclist_sorted.txt listF.txt
mv listF_sorted.txt db_aur.pacshweep
