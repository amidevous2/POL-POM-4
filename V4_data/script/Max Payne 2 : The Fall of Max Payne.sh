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

if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_CD="Version CD"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_WAIT_CP="Patientez pendant la préparation de l'installation..."
LNG_INSERT_MEDIA_1="Veuillez insérer le disque 1 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_INSERT_MEDIA_2="Veuillez insérer le disque 2 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_INSERT_MEDIA_3="Veuillez insérer le disque 3 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="What version do you have?"
LNG_CD="CD Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_WAIT_CP="Wait while the installation is prepared..."
LNG_INSERT_MEDIA_1="Please insert disk 1 into your disk drive\nif not already done."
LNG_INSERT_MEDIA_2="Please insert disk 2 into your disk drive\nif not already done."
LNG_INSERT_MEDIA_3="Please insert disk 3 into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_SUCCES="$TITLE has been installed successfully."
fi
 
# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/top.jpg" "http://files.playonlinux.com/resources/setups/maxpayne2/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages

POL_SetupWindow_presentation "$TITLE" "Take 2 Interactive" "http://www.rockstargames.com/maxpayne2" "GNU_Raziel" "$PREFIX"

select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"

#Choose between CD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "Actions" "$LNG_CD~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_CD" ]; then
	GAME_MEDIAVERSION="CD"	
else
	GAME_MEDIAVERSION="DD"
fi

# Downloading specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
	POL_Call POL_Install_wine64b
else
	POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
fi
Use_WineVersion "$WORKING_WINE_VERSION"

# Creating prefix 
POL_SetupWindow_prefixcreate

if [ "$GAME_MEDIAVERSION" == "CD" ]; then
	#Copy content of CDs to HDD
	TEMP="$POL_USER_ROOT/tmp/$PREFIX"
	chmod -R 777 "$TEMP"
	rm -R "$TEMP"
	mkdir -p "$TEMP"
	cd "$WINEPREFIX"/dosdevices
	ln -s "$TEMP" d:
	#asking for CDROM and checking if it's correct one
	#CD-ROM 1
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_1"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	POL_SetupWindow_wait_next_signal "$LNG_WAIT_CP" "$TITLE"
	cp -r "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	mv "$TEMP"/autorun.inf "$TEMP"/autorun-cd1.inf
	#CD-ROM 2
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_2"
	POL_SetupWindow_cdrom
	POL_SetupWindow_wait_next_signal "$LNG_WAIT_CP" "$TITLE"
	cp -r "$CDROM"/* $TEMP
	chmod -R 777 "$TEMP"
	#CD-ROM 3
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_3"
	POL_SetupWindow_cdrom
	POL_SetupWindow_wait_next_signal "$LNG_WAIT_CP" "$TITLE"
	cp -r "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	
	wine "d:\\setup.exe"
	POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
	
	#Relinking d: to $CDROM
	cd "$WINEPREFIX"/dosdevices
	rm ./d:
	ln -s "$CDROM" d:
else
	#Asking then installing DDV of the game
	cd "$HOME"
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
 
## PlayOnMac Section
[ "$PLAYONMAC" == "" ] && Set_Managed "On"
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section
Set_DXGrab "On"
 
#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi

#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "MaxPayne2.exe" "$TITLE" "$PREFIX.xpm" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4XQLQACgkQ5TH6yaoTykeU/QCeLLTGvqLTmCyAwogkgd8YqI8C
nkoAnAhOefoEavi5AI0W7MQ7lpNo5qjd
=kuJN
-----END PGP SIGNATURE-----
