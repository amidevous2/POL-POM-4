#!/bin/bash
# Date : (2010-05-11 21-00)
# Last revision : (2010-05-11 21-00)
# Wine version used : 1.0.1
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Sonic Adventure DX"
PREFIX="SonicAdventureDX"
WORKING_WINE_VERSION="1.0.1"

if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_CD="Version CD"
LNG_DVD="Version DVD"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_WAIT_CP="Patientez pendant la préparation de l'installation..."
LNG_INSERT_MEDIA_1="Veuillez insérer le disque 1 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_INSERT_MEDIA_2="Veuillez insérer le disque 2 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?\n(minimum pour ce jeu : 128)" 
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 128Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="What version do you have?"
LNG_CD="CD Version"
LNG_DVD="DVD Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_WAIT_CP="Wait while the installation is prepared..."
LNG_INSERT_MEDIA_1="Please insert disk 1 into your disk drive\nif not already done."
LNG_INSERT_MEDIA_2="Please insert disk 2 into your disk drive\nif not already done."
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_GAME_VMS="How much memory does your graphics board have?\n(minimum for this game : 128)" 
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 128Mo of memory."
LNG_INSTALL_ON="Installation in progress..."
LNG_SUCCES="$TITLE has been installed successfully."
fi
 
cd $REPERTOIRE/tmp
rm *.jpg
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Sega" "http://www.sonic-dx.com/" "GNU_Raziel" "$PREFIX"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#downloading specific Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES

#Choose between CD, DVD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_CD~$LNG_DVD~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_CD" ]; then
	GAME_MEDIAVERSION="CD"	
elif [ "$APP_ANSWER" == "$LNG_DVD" ]; then
	GAME_MEDIAVERSION="DVD"
else
	GAME_MEDIAVERSION="DD"
fi

#Installing mandatory components
POL_Call POL_Install_d3dx9
POL_Call POL_Install_xact
POL_Call POL_Install_wmp9
POL_Call POL_Install_wmpcodecs

Set_OS "winxp"

if [ "$GAME_MEDIAVERSION" == "CD" ]; then
	#Copy content of CDs to HDD
	TEMP="$REPERTOIRE/tmp/$PREFIX"
	chmod -R 777 $TEMP
	rm -R $TEMP
	mkdir -p $TEMP
	cd $WINEPREFIX/dosdevices
	ln -s $TEMP d:
	#asking for CDROM and checking if it's correct one
	#CD-ROM 1
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_1"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	POL_SetupWindow_wait_next_signal "$LNG_WAIT_CP" "$TITLE"
	cp -r $CDROM/* $TEMP
	chmod 777 $TEMP -R
	#CD-ROM 2
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_2"
	POL_SetupWindow_cdrom
	POL_SetupWindow_wait_next_signal "$LNG_WAIT_CP" "$TITLE"
	cp -r $CDROM/* $TEMP
	chmod 777 $TEMP -R
	
	wine "d:\\setup.exe"
	POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
	
	#Relinking d: to $CDROM
	cd $WINEPREFIX/dosdevices
	rm ./d:
	ln -s $CDROM ./d:
elif [ "$GAME_MEDIAVERSION" == "DVD" ]; then
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
[ "$PLAYONMAC" == "" ] && Set_Managed "On"
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section
Set_DXGrab "On"
 
#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi

#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "autorun.exe" "$TITLE" "$PREFIX.xpm" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJD0ACgkQ5TH6yaoTykcFJQCdGGyOsklPdIjGv5o/CaI37hiz
1MgAoJnOuA2Uu12xHn9rns4X/Ze5BBSr
=KrH/
-----END PGP SIGNATURE-----
