#!/bin/bash
# Date : (2010-16-09 20-00)
# Last revision : (2011-08-07 21-00)
# Wine version used : 1.1.31, 1.2.3
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Legacy of Kain : Defiance"
PREFIX="LoK_Defiance"
WORKING_WINE_VERSION="1.2.3"

if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_CD="Version CD"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_WAIT_CP="Patientez pendant la préparation de l'installation..."
LNG_INSERT_MEDIA_1="Veuillez insérer le disque 1 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_INSERT_MEDIA_2="Veuillez insérer le disque 2 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_WARNING="Vous devez contourner les protections anti-piratage de ce jeu\npour qu'il fonctionne avec wine."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="Which version do you have?"
LNG_CD="CD Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_WAIT_CP="Wait while the installation is prepared..."
LNG_INSERT_MEDIA_1="Please insert disk 1 into your disk drive\nif not already done."
LNG_INSERT_MEDIA_2="Please insert disk 2 into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Forward\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_WARNING="You must disable anti-piracy protections of this game\nif you want to play it with wine."
LNG_SUCCES="$TITLE has been installed successfully."
fi

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/lokd/top.jpg" "http://files.playonlinux.com/resources/setups/lokd/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages
 
POL_SetupWindow_presentation "$TITLE" "Crystal Dynamics" "http://www.crystald.com/" "GNU_Raziel" "$PREFIX" 
 
select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"

# Downloading specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
	POL_Call POL_Install_wine64b
else
	POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
fi
Use_WineVersion "$WORKING_WINE_VERSION"

# Creating prefix 
POL_SetupWindow_prefixcreate

# Choose between CD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "Actions" "$LNG_CD~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_CD" ]; then
	GAME_MEDIAVERSION="CD"	
else
	GAME_MEDIAVERSION="DD"
fi

# Installing mandatory dependencies (To fix some sound issues and for Joystick support)
POL_Call POL_Install_dxfullsetup

if [ "$GAME_MEDIAVERSION" == "CD" ]; then
	# Copy content of CDs to HDD
	TEMP="$POL_USER_ROOT/tmp/$PREFIX"
	chmod -R 777 "$TEMP"
	rm -R "$TEMP"
	mkdir -p "$TEMP"
	# Asking for CDROM and checking if it's correct one
	# CD-ROM 1
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_1"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	POL_SetupWindow_wait_next_signal "$LNG_WAIT_CP" "$TITLE"
	cp -r "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	# CD-ROM 2
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_2"
	POL_SetupWindow_cdrom
	POL_SetupWindow_wait_next_signal "$LNG_WAIT_CP" "$TITLE"
	cp -r "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	cd "$WINEPREFIX"/dosdevices
	ln -s "$TEMP" d:
	
	wine "d:\\autorun.exe"
	POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
	
	# Relinking d: to $CDROM
	cd "$WINEPREFIX"/dosdevices
	rm ./d:
	ln -s "$CDROM" d:
else
	# Asking then installing DDV of the game
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

# Fix for this game
# Sound problem fix - pulseaudio related
POL_Call POL_Function_OverrideDLL "" "mmdevapi"
[ "$PLAYONMAC" == "" ] && Set_SoundDriver "alsa"
[ "$PLAYONMAC" == "" ] && Set_SoundEmulDriver "Y"
## End Fix

## Begin Common PlayOnMac Section ##
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section ##
 
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi

# Making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "defiance.exe" "$TITLE" "$TITLE.png" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"

# Game protection warning
POL_SetupWindow_message "$LNG_GAME_WARNING" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4XXIYACgkQ5TH6yaoTykdXlACfegTUxD1tA9rwXcl/PyQz4y20
cVgAoKVnGKzMQ+4L19q7jxFQ2NBNLspd
=zauf
-----END PGP SIGNATURE-----
