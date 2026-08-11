#!/bin/bash
# Date : (2011-09-19 00:11)
# Last revision : N/A
# Wine version used : System
# Distribution used to test : Linux Mint 11 x64
# Author : Ulukyn
# Licence : OpenSource
# Only For : http://www.playonlinux.com



[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Ryzom"
PREFIX="Ryzom"
URL="http://ks3094431.kimsufi.com/ryzom_setup_644.exe"

if [ "$POL_LANG" == "fr" ]; then
LNG_NEED_DL="Voulez-vous télécharger le jeu $TITLE ?"
LNG_YES="Oui"
LNG_NO="Non merci, je l'ai déjà fait"
LNG_DOWNLOAD_RUN="Téléchargement en cours..."
LNG_CHOOSE_LOCAL="Veuillez sélectionner votre fichier d'instalation de $TITLE"
else
LNG_NEED_DL="Do you want donwload $TITLE?"
LNG_YES="Yes"
LNG_NO="No thanks, I already have it"
LNG_DOWNLOAD_RUN="Downloading..."
LNG_CHOOSE_LOCAL="Please select your $TITLE installation file"
fi

# Starting the script
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Winch Gate Property Limited" "www.ryzom.com" "Ulukyn" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Download game
POL_SetupWindow_menu "$LNG_NEED_DL" "Actions" "$LNG_YES~$LNG_NO" "~"

if [ "$APP_ANSWER" == "$LNG_YES" ]; then
	POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$TITLE" "$URL"
	SETUP_EXE="ryzom_setup_644.exe"
else
	POL_SetupWindow_browse "$LNG_CHOOSE_LOCAL" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
fi

POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"

# Cleaning temp
chmod -R 777 "$REPERTOIRE/tmp/"
rm -rf "$REPERTOIRE/tmp/*"
rm -f "ryzom_setup_644.exe"

POL_SetupWindow_auto_shortcut "$PREFIX" "client_ryzom_rd.exe" "$TITLE"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk53pNIACgkQ5TH6yaoTykcwdgCfbzO1r8vg5ka2PemvRDzo+4ce
5DQAn167U2BPQC1q1nJC1EqQhoqjFdRD
=kjJt
-----END PGP SIGNATURE-----
