#!/bin/bash
# Date : (2010-16-12 21-00)
# Last revision : (2011-17-07 21-00)
# Wine version used : 1.3.9, 1.3.15, 1.3.23
# Distribution used to test : Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [GNU_Raziel] (2010-16-12)
#   First script.
# [Inukaze ] (2011-17-07)
#   ?
# [Dadu042] (2019-09-28)
#   Wine 1.3.23 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Super Meat Boy"
PREFIX="SMB"
WORKING_WINE_VERSION="2.22"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_STEAM="Version Steam Store"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_INSTALL_ON="Installation en cours..."
LNG_WAIT_STEAM_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu Steam\nsera terminée sous peine de devoir recommencer l'installation."
LNG_GAME_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?\n(minimum pour ce jeu : 256)" 
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 256Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="Which version do you have?"
LNG_STEAM="Steam Store Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_INSTALL_ON="Installation in progress..."
LNG_WAIT_STEAM_END="Click on \"Forward\" ONLY when Steam game installation\nwill be finished or you will have to redo the installation."
LNG_GAME_VMS="How much memory does your graphics board have?\n(minimum for this game : 256)" 
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 256Mo of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi
 
#starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/SMB/top.jpg" "http://files.playonlinux.com/resources/setups/SMB/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages

POL_SetupWindow_presentation "$TITLE" "Team Meat" "http://www.supermeatboy.com/" "GNU_Raziel" "$PREFIX" 
 
select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"

#downloading specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
	POL_Call POL_Install_wine64b
else
	POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
fi
Use_WineVersion "$WORKING_WINE_VERSION"

#Creating prefix 
POL_SetupWindow_prefixcreate

#Choose between DVD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_STEAM~$LNG_DDV" "~"

if [ "$APP_ANSWER" == "$LNG_STEAM" ]; then
	GAME_MEDIAVERSION="STEAM"	
else
	GAME_MEDIAVERSION="DD"
fi

#Installing mandatory dependencies
if [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
	POL_Call POL_Install_steam
else
	POL_Call POL_Install_vcrun2005
fi
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_dxfullsetup

if [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	wine "Steam.exe" -applaunch 40800
	POL_SetupWindow_message "$LNG_WAIT_STEAM_END" "$TITLE"
else 
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$LNG_CHOOSE_DDV" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
	wine start /unix "$SETUP_EXE"
	wineserver -w
	POL_SetupWindow_detect_exit
fi

# Asking about memory size of graphic card
POL_SetupWindow_menu_list "$LNG_GAME_VMS" "$TITLE" "128-256-320-384-512-640-768-896-1024-1536-1792-2048-3072-4096" "-" "256"
VMS="$APP_ANSWER"
 
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > vms.reg
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"VideoMemorySize"="$VMS"
EOF
regedit vms.reg
if [ "$VMS" -lt "256" ]; then
	POL_SetupWindow_message "$LNG_VMS_ERROR" "$TITLE"
fi

# Fix for this game
TEMP="$POL_USER_ROOT/tmp"
echo "[HKEY_CURRENT_USER\Software\Wine\Direct3D]" > "$TEMP/SMB_Fix.reg"
echo "\"DirectDrawRenderer\"=\"opengl\"" >> "$TEMP/SMB_Fix.reg"
regedit "$TEMP/SMB_Fix.reg"

## Begin GNU/Linux fix ##
# don't work with OSX since 'lspci' command do not exist
if [ "$PLAYONMAC" == "" ]; then
	VGA_ID1=`lspci | grep VGA | awk '{ print $1 }' | head -n 1`
	VGA_ID2=`lspci -n | grep $VGA_ID1 | awk '{ print $3 }'`
	VendorID=`echo $VGA_ID2 | awk -F: '{ print $1 }'`
	DeviceID=`echo $VGA_ID2 | awk -F: '{ print $2 }'`
	cd "$WINEPREFIX/drive_c/windows/temp/"
	if [ "$VendorID" == "10de" ]; then
		drvID="nv4_disp.dll"
	elif [ "$VendorID" == "1002" ]; then
		drvID="ati2dvag.dll"
	elif [ "$VendorID" == "8086" ]; then
		drvID="ig4icd32.dll"
	else
		drvID="vga.dll"
	fi
cat << EOF > "$POL_USER_ROOT/tmp/VGA_ID_fix.reg"
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"VideoPCIVendorID"="dword:0000$VendorID"
"VideoPCIDeviceID"="dword:0000$DeviceID"
"VideoDriver"="$drvID"
EOF
	regedit "$POL_USER_ROOT/tmp/VGA_ID_fix.reg"
fi
## End GNU/Linux fix ##

POL_Call POL_Function_OverrideDLL "" "mmdevapi"

# Sound problem fix - pulseaudio related
[ "$PLAYONMAC" == "" ] && Set_SoundDriver "alsa"
[ "$PLAYONMAC" == "" ] && Set_SoundEmulDriver "Y"
## End Fix

### PlayOnMac Section
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi

# Making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "SuperMeatBoy.exe" "$TITLE" "$TITLE.png" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXezTgwAKCRDlMfrJqhPK
R854AJ9X659IE0V6xFiyAQG2f4DUriJg5wCeIgRtvzOHuIdnTjscjI5q7w6pLoQ=
=b2TI
-----END PGP SIGNATURE-----
