#!/bin/bash

	### Creation du fichier texte contenant la liste :
: 'Chaque page contient 2500 paquets
https://aur.archlinux.org/packages?O=0&SeB=nd&K=&outdated=on&SB=p&SO=d&PP=2500&submit=Go
On veut incrementer                  ^   cette valeur de 2500 pour changer de "page" et faire le tour de tous les paquets

On va wget chaque incrementation et la wc, quand 2 incrementations auront le meme nombre de mots (inferieur a 1000, ce qui correspond a une page vide de paquets), on effacera ces deux dernieres et on concateinera les autres.
Ensuite, il faudra extraire les noms des paquets et leurs versions du code html (parsing).


A NE PAS OUBLIER :
Vider le repertoire utilise pour que l utilisation de pacshweep ne laisse pas de paquet la ou on le lance ou dans bin ou il est installe
Proposer une option pour effacer pacswheep a la fin de la maj
Voir le format de sortie des paquets pacman :
pacman --native (install DB) (-Qn)
pacman --foreign (install externe) (-Qm)
format output :
nom_paquet version

noter version des commandes que j utilise
prevoir de garder les fichiers telecharges et les update quand ça fait + de 1 jour que ça a pas été update
'


### wget et concatenation des codes html des pages avec des paquets

#On commence a 5000 paquets dans la boucle parce que on a deja DL deux pages avant pour entrer dans la boucle et passer le wc sans erreur
	INCREM=5000
#On met le CAT a 0 pour la partie concatenation car les deux paquets DL avant la boucle et les deux paquets RM apres s equilibrent
	CAT=0
#On commence avec NB=1 car le dernier paquet DL a l entree de la boucle est page1
	NB=1 
#Nombre BIS correspond au nommage des fichiers telecharges
	NBBIS=2

	wget -q -o /dev/null -O page0.html 'https://aur.archlinux.org/packages?O=0&SeB=nd&K=&outdated=on&SB=p&SO=d&PP=2500&submit=Go'
	wget -q -o /dev/null -O page1.html 'https://aur.archlinux.org/packages?O=2500&SeB=nd&K=&outdated=on&SB=p&SO=d&PP=2500&submit=Go'

#Boucle aquisition tous les paquets
	until [[ $(wc -w < page"$NB".html) -lt 1000 ]] && [[ $(wc -w < page"$((NB-1 ))".html) -eq $(wc -w < page"$NB".html) ]]
	do
	wget -q -o /dev/null -O page$NBBIS.html 'https://aur.archlinux.org/packages?O='$INCREM'&SeB=nd&K=&outdated=on&SB=p&SO=d&PP=2500&submit=Go'
	INCREM=$((INCREM+2500))
	((CAT++))
	((NB++))
	((NBBIS++))
	done

#On vide les paquets vides
	rm page"$NB".html page"$((NB-1))".html

#On concatene les paquets pleins
	for (( i=0; i < CAT; i++ ))
	do
	cat page"$i".html >> raw_list.html
	done

#On vide le repertoire courant
	for (( j=0; j < CAT; j++ ))
	do
	rm page"$j".html
	done


### Parsing du code HTML
#La version est sur la meme ligne que la class flagged et le nom du paquet est sous la ligne contenant la class /packages/...
sed -rn 's/.*flagged[^A-Za-z0-9]*([A-Za-z0-9._:.+-]+).*/\1/p' raw_list.html > list.txt
sed -rn 's/.*href="\/packages\/[^A-Za-z0-9]*([A-Za-z0-9._:.+-]+).*/\1/p' raw_list.html > list2.txt
paste -d " " list2.txt list.txt > listF.txt
rm list.txt list2.txt


### Creation liste pacman :
#pacman -Qn > paclist.txt
#pacman -Qm >> paclist.txt

rm raw_list.html
