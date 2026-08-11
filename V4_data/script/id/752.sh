#!/bin/bash
# Date : (2010-27-11 21-00)
# Last revision : (2010-27-11 21-00)
# Wine version used : 1.1.44
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Need For Speed Undercover"
PREFIX="NeedForSpeedUndercover"
WORKING_WINE_VERSION="1.1.44"

if [ "$POL_LANG" == "fr" ]; then
LNG_GAME_UPDATE_WELCOME="Bienvenue dans le script d'installation du patch 1.0.1.18 pour $TITLE"
LNG_PATCH_METHOD="Choisissez votre méthode de patch"
LNG_HAVE_PATCH="Patcher le jeu depuis un fichier local"
LNG_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_DL_PATCH_VERSION="Quelle version possèdez-vous ?"
LNG_DL_PATCH_EU="Européenne"
LNG_DL_PATCH_US="Américaine"
LNG_GAME_UPDATE_DL="Patientez pendant le téléchargement du patch...\nCette opération peut prendre quelques minutes selon la vitesse de votre connexion."
LNG_GAME_UPDATE_FINISHED="Le patch a été correctement installé"
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch 1.0.1.18 Installation script for $TITLE"
LNG_PATCH_METHOD="Choose your patch method"
LNG_HAVE_PATCH="Patch from local file"
LNG_DL_PATCH="Download then use last patch"
LNG_LOCAL_PATCH="Select patch to execute"
LNG_DL_PATCH_VERSION="Witch version do you have ?"
LNG_DL_PATCH_EU="European"
LNG_DL_PATCH_US="US"
LNG_GAME_UPDATE_DL="Wait while the patch is downloading...\nThis operation can take time, depending of you connexion."
LNG_GAME_UPDATE_FINISHED="Patch installed successfully"
fi

#starting the script
rm "$REPERTOIRE/tmp/*.jpg"
POL_SetupWindow_Init
POL_SetupWindow_free_presentation "$TITLE" "$LNG_GAME_UPDATE_WELCOME"

POL_SetupWindow_checkexist()
{	
	if [ ! -e $REPERTOIRE/wineprefix/$1 ]; then
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
 
select_prefixe "$REPERTOIRE/wineprefix/$PREFIX"

#Using specific Wine
Use_WineVersion "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES

#asking about patch local or not
cd $HOME
POL_SetupWindow_menu "$LNG_PATCH_METHOD" "$TITLE" "$LNG_HAVE_PATCH~$LNG_DL_PATCH" "~"
if [ "$APP_ANSWER" == "$LNG_HAVE_PATCH" ]; then
	POL_SetupWindow_browse "$LNG_LOCAL_PATCH" "$TITLE" ""
	wine "$APP_ANSWER"
else
	POL_SetupWindow_menu "$LNG_DL_PATCH_VERSION" "$TITLE" "$LNG_DL_PATCH_EU~$LNG_DL_PATCH_US" "~"
	SELECTED_VERSION="$APP_ANSWER"
	cd $REPERTOIRE/tmp
	if [ "$SELECTED_VERSION" == "$LNG_DL_PATCH_EU" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "http://www.nfs-mania.com/downloads/undercover/patchs/nfs-mania_nfsuc_patch_1.0.1.18_fr-it-de_fix.zip"
		unzip "nfs-mania_nfsuc_patch_1.0.1.18_fr-it-de_fix.zip"
		wine start /unix "NFSU_v1.0.1.18_frgeritalEU_fix.exe"
		rm "nfs-mania_nfsuc_patch_1.0.1.18_fr-it-de_fix.zip"
		rm "Readme.txt"
		rm "NFSU_v1.0.1.18_frgeritalEU_fix.exe"
	else
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "http://www.nfs-mania.com/downloads/undercover/patchs/nfs-mania_nfsuc_patch_1.0.1.18_en-fr-mex_fix.zip"
		unzip "nfs-mania_nfsuc_patch_1.0.1.18_en-fr-mex_fix.zip"
		wine start /unix "NFSU_v1.0.1.18_enUS_fix.exe"
		rm "nfs-mania_nfsuc_patch_1.0.1.18_en-fr-mex_fix.zip"
		rm "Readme.txt"
		rm "NFSU_v1.0.1.18_enUS_fix.exe"
	fi
fi
 
POL_SetupWindow_message "$LNG_GAME_UPDATE_FINISHED" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF0ACgkQ5TH6yaoTyke5mACfZV19i2n6TowU/uJgh3d8BEhK
ye0AoJE0jJx+xgICDOVfVIOK1ukzz5gY
=XTG/
-----END PGP SIGNATURE-----
