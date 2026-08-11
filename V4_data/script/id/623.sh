#!/bin/bash
# Date : (2009-23-05 12-14)
# Last revision : See changelog
# Wine version used : 1.7.36
# Distribution used to test : Debian Squeeze (Testing)
# Author : NSWL & GNU_Raziel
# Licence : Retail
#
# CHANGELOG
# [?] (2009-23-05)
#   First script.
# [?] (2015-21-02)
#   ?
# [Dadu042] (2019-12-24)
#   Wine 1.7.36 (2015) -> 3.0.3
#   Update: POL_Shortcut, POL_Wine_SelectPrefix, arch x86.
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Need For Speed: Underground 2"
PREFIX="NFSUnderground2"
WORKING_WINE_VERSION="3.0.3"

if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_CD="Version CD"
LNG_DVD="Version DVD"
LNG_DDV="Version Digital Download"
LNG_INSERT_MEDIA_1="Veuillez insérer le disque 1 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_INSERT_MEDIA_2="Veuillez insérer le disque 2 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?\n(minimum pour ce jeu : 256)" 
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 256Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="What version do you have?"
LNG_CD="CD Version"
LNG_DVD="DVD Version"
LNG_DDV="Digital Download Version"
LNG_INSERT_MEDIA_1="Please insert disk 1 into your disk drive\nif not already done."
LNG_INSERT_MEDIA_2="Please insert disk 2 into your disk drive\nif not already done."
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory does your graphics board have?\n(minimum for this game : 256)" 
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 256Mo of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi

#starting the script
rm "$REPERTOIRE/tmp/*.jpg"
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "EA Games" "N/A" "NSLW & GNU_Raziel" "$PREFIX" 
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES
 
#Choose between CD, DVD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "Actions" "$LNG_CD~$LNG_DVD~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_CD" ]; then
	GAME_MEDIAVERSION="CD"	
elif [ "$APP_ANSWER" == "$LNG_DVD" ]; then
	GAME_MEDIAVERSION="DVD"
else
	GAME_MEDIAVERSION="DD"
fi

#Installing mandatory dependencies 
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_d3dx9

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
	POL_SetupWindow_check_cdrom "AutoRun.exe"
	POL_SetupWindow_wait_next_signal "$LNG_WAIT_CP" "$TITLE"
	cp -r $CDROM/* $TEMP
	chmod 777 $TEMP -R
	mv $TEMP/autorun.inf $TEMP/autorun-cd1.inf
	#CD-ROM 2
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_2"
	POL_SetupWindow_cdrom
	POL_SetupWindow_wait_next_signal "$LNG_WAIT_CP" "$TITLE"
	cp -r $CDROM/* $TEMP
	chmod 777 $TEMP -R
	mv $TEMP/autorun.inf $TEMP/autorun-cd2.inf
	mv $TEMP/autorun-cd1.inf $TEMP/autorun.inf
	
	wine "d:\\AutoRun.exe"
	POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
	
	#Relinking d: to $CDROM
	cd $WINEPREFIX/dosdevices
	rm ./d:
	ln -s $CDROM ./d:
elif [ "$GAME_MEDIAVERSION" == "DVD" ]; then
	#asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$LNG_INSERT_MEDIA"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "AutoRun.exe"
	wine start /unix "$CDROM/AutoRun.exe"
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

#Fix for this game
cd "$REPERTOIRE/ressources"
if [ ! -e "dinput8.zip" ]; then
wget -c "http://www.useyourbrain.co.uk/dlldownloads-files/dinput8.zip"
fi
cd "$WINEPREFIX/drive_c/windows/temp/"
unzip "$REPERTOIRE/ressources/dinput8.zip"
mv DINPUT8.DLL "$WINEPREFIX/drive_c/windows/system32/dinput8.dll"
 
echo "[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]" > "$WINEPREFIX/drive_c/windows/temp/NFSU2_Fix.reg"
echo "\"dinput8\"=\"native\"" >> "$WINEPREFIX/drive_c/windows/temp/NFSU2_Fix.reg"
regedit "$WINEPREFIX/drive_c/windows/temp/NFSU2_Fix.reg"
 
#asking about memory size of graphic card
POL_SetupWindow_menu_list "$LNG_GAME_VMS" "$TITLE" "128-256-320-384-512-640-768-896-1024-1792-2048" "-" "256"
VMS="$APP_ANSWER"
 
cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg
if [ "$VMS" -lt "256" ]; then
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
POL_Shortcut "Speed2" "$TITLE" "" "" "Game;"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgIodwAKCRDlMfrJqhPK
R98lAJ9tjpjg6PqOhSRy85B1SjcqeCMeBQCgnW5la7rD3qfSspKuHwxi7AQsZK4=
=xCIs
-----END PGP SIGNATURE-----
