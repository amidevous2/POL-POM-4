#!/bin/bash
# Date : (2011-03-23 10-00)
# Last revision : 
# Wine version used : 1.3.16
# Distribution used to test : Kubuntu 10.10 64bits
# Author : Benji64 & GNU_Raziel
# Licence : Retail
# Only for : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Anno 1701"
PREFIX="Anno1701"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_GAME_UPDATE_WELCOME="Bienvenue dans le script d'installation du\npatch 1.02 pour $TITLE"
LNG_VERSION_QUESTION="Sélectionner la version d'installation d'Anno :"
AUTRE="Autre"
LNG_PATCH_NOT_IN_LIST="Voulez vous utiliser un fichier local pour patcher le jeu?"
LNG_PATCH_DL="Le patch v1.02 est en cours de téléchargement..."
LNG_PATCH_INSTALL="Le patch v1.02 est en cours d'installation..."
LNG_FIN="Installation terminée !\n\n\nScript créé d'après les informations tirées du site de Wine :\nhttp://appdb.winehq.org/objectManager.php?sClass=version&iId=6822\n\nINFORMATION : vous devez contourner les protections anti-piratage pour faire fonctionner ce jeu."
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch 1.02 Installation script\nfor $TITLE"
LNG_VERSION_QUESTION="Choose the Anno installation version :"
AUTRE="Other"
LNG_PATCH_NOT_IN_LIST="Do you want to use a local file to patch the game?"
LNG_PATCH_DL="Downloading patch v1.02..."
LNG_PATCH_INSTALL="Installing patch v1.02..."
LNG_FIN="Installation complite !\n\n\nThis script has been created from Wine Website inforamtion :\nhttp://appdb.winehq.org/objectManager.php?sClass=version&iId=3775\n\nINFORMATION : you'll have to disable anti-piracy protections to run this game."
fi
 
POL_SetupWindow_Init
POL_SetupWindow_free_presentation "$TITLE" "$LNG_GAME_UPDATE_WELCOME"
 
 
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
 
# Téléchargement des fichiers nécessaires à l'installation du patch
POL_SetupWindow_menu "$LNG_VERSION_QUESTION" "$TITLE" "fra~uk~usa~ger~$AUTRE" "~"
if [ "$APP_ANSWER" == "fra" ]; then
FICHIER="anno1701_patch102_fra.exe"
elif [ "$APP_ANSWER" == "uk" ]; then
FICHIER="anno1701_patch102_uk.exe"
elif [ "$APP_ANSWER" == "ger" ]; then
FICHIER="anno1701_patch102_ger.exe"
elif [ "$APP_ANSWER" == "usa" ]; then
FICHIER="1701ad_patch102_usa.exe"
else
FICHIER=""
fi
if [ "$FICHIER" == "" ]; then
cd "$HOME"
POL_SetupWindow_question "$LNG_PATCH_NOT_IN_LIST" "$TITLE"
if [ "$APP_ANSWER" == "TRUE" ]; then
POL_SetupWindow_browse
POL_SetupWindow_wait_next_signal "$LNG_PATCH_INSTALL" "$TITLE"
wine $APP_ANSWER
POL_SetupWindow_detect_exit
else
POL_SetupWindow_Close
exit
fi
else
cd "$POL_USER_ROOT/tmp"
POL_SetupWindow_download "$LNG_PATCH_DL" "$TITLE" "http://us4.strategyinformer.com/v2/download/0a5e1a39/anno1701%2F$FICHIER" ""
# Installation du patch v1.02
POL_SetupWindow_wait_next_signal "$LNG_PATCH_INSTALL" "$TITLE"
wine anno1701%2F$FICHIER
POL_SetupWindow_detect_exit
fi
 
#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
chmod -R 777 "$POL_USER_ROOT/tmp/"
rm -rf "$POL_USER_ROOT/tmp/*"
fi
 
# Fin de l'installation
POL_SetupWindow_message "$LNG_FIN" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk2QZCIACgkQ5TH6yaoTykdZfgCdFGaq9SHEz5+jJTjembLVik/b
/lIAn3922jchFNvtA45O8EstbgLXMtl9
=g2i9
-----END PGP SIGNATURE-----
