#!/bin/bash
# Date : (2010-05-11 21-00)
# Last revision : (2010-02-12 21-00)
# Wine version used : 1.3.5
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Star Wars Knights of the Old Republic"
GAME_CONFIG="SWKotor - Configuration"
PREFIX="SWKotor"
WORKING_WINE_VERSION="1.3.5"

if [ "$POL_LANG" == "fr" ]; then
LNG_GAME_UPDATE_WELCOME="Bienvenue dans le script d'installation du\npatch 1.03 pour $TITLE"
LNG_STEAM="Steam a son propre système de mise à jour automatique."
LNG_PATCH_METHOD="Choisissez votre méthode de patch"
LNG_HAVE_PATCH="Patcher le jeu depuis un fichier local"
LNG_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_GAME_UPDATE_DL="Patientez pendant le téléchargement du patch...\nCette opération peut prendre quelques minutes selon la vitesse de votre connexion."
LNG_PATCH_DONE="Le patch pour $TITLE à été\ninstallé avec succès."
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch 1.03 Installation script\nfor $TITLE"
LNG_STEAM="Steam have is own automatic update system."
LNG_PATCH_METHOD="Choose your patch method"
LNG_HAVE_PATCH="Patch from local file"
LNG_DL_PATCH="Download then use last patch"
LNG_LOCAL_PATCH="Select patch to execute"
LNG_GAME_UPDATE_DL="Wait while the patch is downloading...\nThis operation can take time, depending of you connexion."
LNG_PATCH_DONE="Patch for $TITLE has been\ninstalled successfully."
fi

cd $REPERTOIRE/tmp
rm *.jpg
#starting the script
cd $REPERTOIRE/tmp
rm *.jpg
POL_SetupWindow_Init

POL_SetupWindow_free_presentation "$TITLE" "$LNG_GAME_UPDATE_WELCOME"

POL_SetupWindow_checkexist()
{	
	if [ ! -e "$REPERTOIRE/wineprefix/$1" ]; then
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

#Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$LNG_STEAM" "$TITLE"
	POL_SetupWindow_Close
	exit
fi

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#Using specific Wine
Use_WineVersion "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable 
POL_LoadVar_PROGRAMFILES

#asking about patch local or not
cd $HOME
POL_SetupWindow_menu "$LNG_PATCH_METHOD" "Patch" "$LNG_HAVE_PATCH~$LNG_DL_PATCH" "~"
if [ "$APP_ANSWER" == "$LNG_HAVE_PATCH" ]; then
	POL_SetupWindow_browse "$LNG_LOCAL_PATCH" "$TITLE" ""
	wine "$APP_ANSWER"
else
	POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.lucasarts.com/patches/pc/SWKotOR1_03.exe"
	wine start /unix "SWKotOR1_03.exe"
	rm "SWKotOR1_03.exe"
fi

POL_SetupWindow_message "$LNG_PATCH_DONE" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFsACgkQ5TH6yaoTykcC7QCffAnnwgmiZmYCS9c8SKnvySo9
doIAn2xUvo4EN6+glTXKDRd3vIhCETTI
=Lmj6
-----END PGP SIGNATURE-----
