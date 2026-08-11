#!/bin/bash
# Date : (2009-12-02 15-30)
# Last revision : (2010-12-12 22-00)
# Wine version used : 1.3.9
# Distribution used to test : Debian Squeeze (Testing)
# Author : NSLW & GNU_Raziel
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Age Of Empires III : The WarChiefs"
PREFIX="AOE3"
WORKING_WINE_VERSION="1.3.9"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_CD="Version CD"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?\n(minimum pour ce jeu : 128)" 
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 128Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="What version do you have?"
LNG_CD="CD Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory does your graphics board have?\n(minimum for this game : 128)" 
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 128Mo of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi

#starting the script
cd $REPERTOIRE/tmp
rm *.jpg
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Ensemble Studios" "www.ageofempires3.com" "NSLW & GNU_Raziel" "$PREFIX" 

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

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#downloading specific Wine
Use_WineVersion "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES

#Choose between CD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "Actions" "$LNG_CD~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_CD" ]; then
	GAME_MEDIAVERSION="CD"	
else
	GAME_MEDIAVERSION="DD"
fi

if [ "$GAME_MEDIAVERSION" == "CD" ]; then
	#asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$LNG_INSERT_MEDIA"
	POL_SetupWindow_cdrom
	#POL_SetupWindow_check_cdrom "Age of Empires III - The WarChiefs.msi"
	CHECK=$(find "$CDROM" -iname setup.exe)
 	if [ "$CHECK" == "" ]; then
		wine start /unix "$CDROM/instalar.exe"
	else
		wine start /unix "$CDROM/setup.exe"
	fi
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
POL_SetupWindow_menu_list "$LNG_GAME_VMS" "$TITLE" "128-256-320-384-512-640-768-896-1024-1792-2048" "-" "128"
VMS="$APP_ANSWER"
 
cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg
if [ "$VMS" -lt "128" ]; then
	POL_SetupWindow_message "$LNG_VMS_ERROR" "$TITLE"
fi

## PlayOnMac Section
[ "$PLAYONMAC" == "" ] && Set_SoundDriver "alsa"
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section

#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi
 
#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "age3x.exe" "$TITLE" "" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJE8ACgkQ5TH6yaoTyken1gCghKwH3i2JNWPVVi1pNMzyG586
/ggAmwYJR5mUme3EfdzhSAdG8wqUfck0
=R8dt
-----END PGP SIGNATURE-----
