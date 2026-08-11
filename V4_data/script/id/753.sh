#!/bin/bash
# Date : (2010-27-11 21-00)
# Last revision : (2010-27-11 21-00)
# Wine version used : 1.3.1
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Need For Speed Underground"
PREFIX="NFSUnderground"
WORKING_WINE_VERSION="1.3.1"

if [ "$POL_LANG" == "fr" ]; then
LNG_GAME_UPDATE_WELCOME="Bienvenue dans le script d'installation du patch 4.16 pour $TITLE"
LNG_PATCH_METHOD="Choisissez votre méthode de patch"
LNG_HAVE_PATCH="Patcher le jeu depuis un fichier local"
LNG_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_DL_PATCH_VERSION="Quelle version possèdez-vous ?"
LNG_DL_PATCH_EU="Européenne"
LNG_DL_PATCH_US="Américaine"
LNG_DL_PATCH_KOR="Coréenne"
LNG_DL_PATCH_CH="Chinoise"
LNG_GAME_UPDATE_DL="Patientez pendant le téléchargement du patch...\nCette opération peut prendre quelques minutes selon la vitesse de votre connexion."
LNG_GAME_UPDATE_FINISHED="Le patch a été correctement installé"
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch 4.16 Installation script for $TITLE"
LNG_PATCH_METHOD="Choose your patch method"
LNG_HAVE_PATCH="Patch from local file"
LNG_DL_PATCH="Download then use last patch"
LNG_LOCAL_PATCH="Select patch to execute"
LNG_DL_PATCH_VERSION="Witch version do you have ?"
LNG_DL_PATCH_EU="European"
LNG_DL_PATCH_US="US"
LNG_DL_PATCH_KOR="Korean"
LNG_DL_PATCH_CH="Chinese"
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
	POL_SetupWindow_menu "$LNG_DL_PATCH_VERSION" "$TITLE" "$LNG_DL_PATCH_EU~$LNG_DL_PATCH_US~$LNG_DL_PATCH_KOR~$LNG_DL_PATCH_CH" "~"
	SELECTED_VERSION="$APP_ANSWER"
	cd $REPERTOIRE/tmp
	if [ "$SELECTED_VERSION" == "$LNG_DL_PATCH_EU" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfs-underground/pc/en-uk/NFSU_EUROPE_PATCH_4.exe"
		wine start /unix "NFSU_EUROPE_PATCH_4.exe"
		rm "NFSU_EUROPE_PATCH_4.exe"
	elif [ "$SELECTED_VERSION" == "$LNG_DL_PATCH_KOR" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfs-underground/pc/korea/NFSU_KOREA_PATCH_4.exe"
		wine start /unix "NFSU_KOREA_PATCH_4.exe"
		rm "NFSU_KOREA_PATCH_4.exe"
	elif [ "$SELECTED_VERSION" == "$LNG_DL_PATCH_CH" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfs-underground/pc/taiwan/NFSU_CHINESE_PATCH_4.exe"
		wine start /unix "NFSU_CHINESE_PATCH_4.exe"
		rm "NFSU_CHINESE_PATCH_4.exe"
	else
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfs-underground/pc/en-us/NFSU_US_PATCH_4.exe"
		wine start /unix "NFSU_US_PATCH_4.exe"
		rm "NFSU_US_PATCH_4.exe"
	fi
fi
 
POL_SetupWindow_message "$LNG_GAME_UPDATE_FINISHED" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFwACgkQ5TH6yaoTykc7yACdFmAPGcXi8k4TsW1XLi8WXZ06
NikAmQHGERKZyt8AsFNn51xu3TAdB/ca
=N+Sh
-----END PGP SIGNATURE-----
