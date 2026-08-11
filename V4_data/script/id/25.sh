#!/bin/bash
# Date : (2010-16-09 21-00)
# Last revision : (2011-08-07 21-00)
# Wine version used : 1.2, 1.2.3
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Max Payne 2 : The Fall of Max Payne"
PREFIX="MaxPayne2"
WORKING_WINE_VERSION="1.2.3"
PVERSION="1.01"

if [ "$POL_LANG" == "fr" ]; then
LNG_GAME_UPDATE_WELCOME="Bienvenue dans le script d'installation du patch $PVERSION pour $TITLE"
LNG_GAME_UPDATE_INFO="Ce patch ajoute 2 niveaux supplémentaires\n disponibles dans le mode \"Dead Man Walking\"."
LNG_PATCH_METHOD="Choisissez votre méthode de patch"
LNG_HAVE_PATCH="Patcher le jeu depuis un fichier local"
LNG_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_GAME_UPDATE_DL="Patientez pendant le téléchargement du patch...\nCette opération peut prendre quelques minutes selon la vitesse de votre connexion."
LNG_GAME_UPDATE_FINISHED="Le patch a été correctement installé"
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch $PVERSION Installation script for $TITLE"
LNG_GAME_UPDATE_INFO="This patch add two new levels for the \"Dead Man Walking\" Mode."
LNG_PATCH_METHOD="Choose your patch method"
LNG_HAVE_PATCH="Patch from local file"
LNG_DL_PATCH="Download then use last patch"
LNG_LOCAL_PATCH="Select patch to execute"
LNG_GAME_UPDATE_DL="Wait while the patch is downloading...\nThis operation can take time, depending of you connexion."
LNG_GAME_UPDATE_FINISHED="Patch installed successfully"
fi

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/top.jpg" "http://files.playonlinux.com/resources/setups/maxpayne2/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages
POL_SetupWindow_free_presentation "$TITLE" "$LNG_GAME_UPDATE_WELCOME"

POL_SetupWindow_message "$LNG_GAME_UPDATE_INFO" "$TITLE"

POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		if [ "$POL_LANG" == "fr" ]; then
			LNG_PREFIX_NOT_EXIST="Le jeu n'est pas installé."
		else
			LNG_PREFIX_NOT_EXIST="Game is not installed."
		fi
		POL_SetupWindow_message "$LNG_PREFIX_NOT_EXIST" "$TITLE"
		POL_SetupWindow_Close
		exit
	fi
}
 
POL_SetupWindow_checkexist "$PREFIX"

select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"

# Using specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
	WORKING_WINE_VERSION="$WORKING_WINE_VERSION-64b"
fi
Use_WineVersion "$WORKING_WINE_VERSION"

#asking about patch local or not
cd "$HOME"
POL_SetupWindow_menu "$LNG_PATCH_METHOD" "Patch" "$LNG_HAVE_PATCH~$LNG_DL_PATCH" "~"
if [ "$APP_ANSWER" == "$LNG_HAVE_PATCH" ]; then
	POL_SetupWindow_browse "$LNG_LOCAL_PATCH" "$TITLE" ""
	wine start /unix "$APP_ANSWER"
else
	cd "$POL_USER_ROOT"/tmp
	POL_SetupWindow_download "$LNG_MP2_UPDATE_DL" "$TITLE" "http://www.rockstargames.com/maxpayne2/downloads/MaxPayne2BonusChapters.zip"
 	unzip MaxPayne2BonusChapters.zip
	wine start /unix "MaxPayne2BonusChapters.exe"
	rm "MaxPayne2BonusChapters.*"
	rm "readme.txt"
fi
 
POL_SetupWindow_message "$LNG_GAME_UPDATE_FINISHED" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4XQEkACgkQ5TH6yaoTykd33wCgg1rrOsextC7qh+AoMc5R8F/X
i6YAn2HmQkfcs7LCqN5IKDnVy6CCGyZx
=iEmN
-----END PGP SIGNATURE-----
