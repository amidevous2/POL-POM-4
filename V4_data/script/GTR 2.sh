#!/bin/bash
# Date : (2010-12-26 17-20)
# Last revision : (2010-12-26 17-20)
# Wine version used : 1.3.10
# Distribution used to test : Ubuntu 10.10
# Author : thib25
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GTR 2"
PREFIX="GTR2"
WORKING_WINE_VERSION="1.3.10"

if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_CD="Version CD"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?\n(minimum pour ce jeu : 64)" 
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 64Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="What version do you have?"
LNG_CD="CD Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory does your graphics board have?\n(minimum for this game : 64)" 
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 64Mo of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi

#starting the script
cd $REPERTOIRE/tmp
rm *.jpg
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "SimBin" "http://www.simbin.se/games/gtr2.htm" "thib25" "$PREFIX"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

#Choose between CD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "Actions" "$LNG_CD~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_CD" ]; then
	GAME_MEDIAVERSION="CD"	
else
	GAME_MEDIAVERSION="DD"
fi

#downloading specific Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"
 
#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES
 
if [ "$GAME_MEDIAVERSION" == "CD" ]; then
	#asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$LNG_INSERT_MEDIA"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	wine start /unix "$CDROM/setup.exe"
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

#asking about memory size of graphic card
POL_SetupWindow_menu_list "$LNG_GAME_VMS" "$TITLE" "128-256-320-384-512-640-768-896-1024-1792-2048" "-" "64"
VMS="$APP_ANSWER"

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg
if [ "$VMS" -lt "64" ]; then
	POL_SetupWindow_message "$LNG_VMS_ERROR" "$TITLE"
fi

#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "GTR2.exe" "$TITLE" "" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEMACgkQ5TH6yaoTykdsjgCgi0MwppobWe40Q4YCt/0/CxE8
pl8AoJm521lILNSZvVtoCvZqu4HS96gt
=KWmd
-----END PGP SIGNATURE-----
