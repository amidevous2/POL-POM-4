#!/bin/bash
# Date : (2010-05-11 21-00)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Debian Squeeze (Testing)
# Author : NSWL & GNU_Raziel
# Licence : Retail
#
# CHANGELOG
# [Dadu042] (2020-01-15 22:50)
#   Initial script.
# [Dadu042] (2020-01-16 20:50)
#   Wine 1.3.4 -> 3.0.3.
#   Cleanup script.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Sims 3 Ambitions"
PREFIX="TheSims3"
WORKING_WINE_VERSION="3.0.3"

if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_DVD="Version DVD"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="What version do you have?"
LNG_DVD="DVD Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_SUCCES="$TITLE has been installed successfully."
fi
 
# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/sims3/top.jpg" "http://files.playonlinux.com/resources/setups/sims3/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "Electronic Arts Inc." "thesims3.ea.com" "NSWL & GNU_Raziel" "$PREFIX"

POL_SetupWindow_checkexist()
{	
	if [ ! -e "$REPERTOIRE/wineprefix/$1" ]; then
		if [ "$POL_LANG" == "fr" ]; then
			LNG_PREFIX_NOT_EXIST="Le jeu n'est pas installé."
		else
			LNG_PREFIX_NOT_EXIST="Game is not installed."
		fi
		POL_SetupWindow_message "$LNG_PREFIX_NOT_EXIST" "Game Checker"
		POL_SetupWindow_Close
		exit
	fi
}

POL_SetupWindow_checkexist "$PREFIX" 
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

# Downloading specific Wine
Use_WineVersion "$WORKING_WINE_VERSION"

# Fetching PROGRAMFILES environmental variable 
POL_LoadVar_PROGRAMFILES
 
# Choose between DVD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_DVD~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_DVD" ]; then
	GAME_MEDIAVERSION="DVD"	
else
	GAME_MEDIAVERSION="DD"
fi
 
if [ "$GAME_MEDIAVERSION" == "DVD" ]; then
	#asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$LNG_INSERT_MEDIA"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "Sims3EP02Setup.exe"
	wine start /unix "$CDROM/Sims3EP02Setup.exe"
	POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
else
	#Asking then installing DDV of the game
	cd $HOME
	POL_SetupWindow_browse "$LNG_CHOOSE_DDV" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
	wine start /unix "$SETUP_EXE"
	INSTALL_ON="1"
	until [ "$INSTALL_ON" == "" ]; do
	sleep 5
	INSTALL_ON=`ps aux | grep "wineserver" | grep -v "grep"`
	done
	POL_SetupWindow_detect_exit
fi
 
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi
 
# Making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "TS3EP02.exe" "$TITLE" "" "Game;"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiC3ygAKCRDlMfrJqhPK
R/OEAJ9VaT0eJeYfevTR85Cb8ViNAxSkbACgkw5RylidUVvs29dFELkhKGkOSsw=
=l/1d
-----END PGP SIGNATURE-----
