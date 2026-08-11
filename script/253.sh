#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
cfg_check 
if [ "$POL_LANG" == "fr_FR.UTF-8" ]; then
LNG_DISC_DL="Acquisition du jeu complet... (légalement)"
LNG_DISC_UNTAR="Décompression du jeu..."
LNG_DISC_GAME_TITRE="Notez bien"
LNG_DISC_GAME="¤ Le menu du jeu s'obtient en appuyant sur F1 et non sur la touche Échap.

¤ Pour quitter le jeu, appuyer à n'importe quel moment sur CTRL + F9.

¤ ALT + Entrée : Passer en mode plein écran."
LNG_DISC_BADDL="Le jeu n'a pu être téléchargé en entier! L'installation est donc annulée."
else
LNG_DISC_DL="Getting the full game... (legally)"
LNG_DISC_UNTAR="Uncompressing the game..."
LNG_DISC_GAME_TITRE="Nota bene"
LNG_DISC_GAME="¤ Press F1 instead of the Escape key to get the in-game menu.

¤ To quit the game, press CTRL + F9 at every moment.

¤ ALT + Enter : Full-screen mode."
LNG_DISC_BADDL="The game is not well downloaded! The installation is aborted."
fi
presentation "Discworld" "TWG & Perfect 10" "http://www.lspace.org/games/discworld/index.html" "Bugage" "Discworld" 1 4
telecharger "$LNG_DISC_DL" "http://mulx.playonlinux.com/files/Discworld.tar.bz2" "" 2 4 1 "" 0 0
wget http://mulx.playonlinux.com/files/md5discworld
md5sum -c md5discworld
if [ $? ]; then
erreur "$LNG_DISC_BADDL"
rm Discworld.tar.bz2
rm md5discworld
exit 0
fi
rm md5discworld
select_prefixe "$REPERTOIRE/wineprefix/Discworld"
dosprefixcreate
cd $WINEPREFIX/drive_c/
attendre "$LNG_DISC_UNTAR" "tar -jxvf ../../../Discworld.tar.bz2" "" 3 4 0 "" 1
mv Discworld.xpm $REPERTOIRE/../.local/share/icons
export CDROM="$WINEPREFIX/drive_c"
cd discwld
if [ "$POL_LANG" == "fr_FR.UTF-8" ]; then
cp french.txt french.bak
elif [ "$POL_LANG" == "it_IT.UTF-8" ]; then
mv french.txt french.bak && mv italian.txt french.txt
elif [ "$POL_LANG" == "de_DE.UTF-8" ]; then
mv french.txt french.bak && mv german.txt french.txt
elif [ "$POL_LANG" == "es_ES.UTF-8" ]; then
mv french.txt french.bak && mv spanish.txt french.txt
else
mv french.txt french.bak && mv english.txt french.txt
fi
rm ../../../../Discworld.tar.bz2
message "$LNG_DISC_GAME" "$LNG_DISC_GAME_TITRE" 4 4 0 "" "" 
creer_lanceur_dos "Discworld" "" "disc.bat" "$REPERTOIRE/../.local/share/icons/Discworld.xpm" "Discworld"
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEYACgkQ5TH6yaoTykdrywCgoQBhBkHjaoJ+WGlPkj0P2M2+
0fMAn1WLNRO/pFiQamefzBVWD+GDH3MM
=nzuK
-----END PGP SIGNATURE-----
