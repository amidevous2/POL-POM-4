#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi

source "$PLAYONLINUX/lib/sources"
cfg_check

#Declaration des variables
PREFIXNAME="RedneckRampage"
REALNAME="Redneck Rampage"
REPINSTALL="RR"
EDITEUR="Interplay"
WEBSITE="http://www.interplay.com/"
SCRIPTEUR="Djabal"


if [ "$POL_LANG" == "fr_FR.UTF-8" ]; then
	LNG_DL="Téléchargement du jeu."
	LNG_INSTALL="Installation"
	LNG_INSTALL_MSG="N'oubliez pas d'activer les bruitages et la musique dans 'Sound Setup'."
else
	LNG_DL="Download of the game."
	LNG_INSTALL="Install"
	LNG_INSTALL_MSG="Don't forget to activate the sound effects and music in  'Sound Setup'."
fi 

presentation "$REALNAME" "$EDITEUR" "$WEBSITE" "$SCRIPTEUR" "$PREFIXNAME"
select_prefixe "$REPERTOIRE/wineprefix/$PREFIXNAME/"
dosprefixcreate

cd "$DOSPREFIX/drive_c/"
mkdir "$REPINSTALL"
cd "$REPINSTALL"

telecharger "$LNG_DL" "http://www.abandonware-utopia.com/pages/telechargement/jeux/Redneck%20Rampage.zip"
unzip -u "Redneck%20Rampage.zip"
rm "Redneck%20Rampage.zip"

message "$LNG_INSTALL_MSG" "$LNG_INSTALL"

start_dos "SETUP.EXE"

creer_lanceur_dos "$PREFIXNAME" "$REPINSTALL" "RR.EXE" "" "$REALNAME"
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEUACgkQ5TH6yaoTykdGbgCdHU9YvrolF3JmHyxXsDujWGuS
TJIAniiDL5pWm4kcBtalIFwicMrPGDZG
=m/5m
-----END PGP SIGNATURE-----
