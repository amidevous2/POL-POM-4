#!/bin/bash
# Date : (2009-12-22 21-00)
# Last revision : (2009-12-22 21-00)
# Wine version used : Fedora 12
# Distribution used to test : 1.1.35
# Author : NSLW
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

TITLE="Tomb Raider III Adventures of Lara Croft"
PREFIX="TRIII"
WORKINGWINEVERSION="1.1.35"

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

#procedure for patching TombRaider III
patch_trIII()
{
POL_SetupWindow_browse "Select patch file" "$TITLE" ""
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
wine "$APP_ANSWER"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "Patch for $TITLE has been installed successfully" "$TITLE"
}

wget http://upload.wikimedia.org/wikipedia/en/7/77/TombRaiderIII.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TITLE" "Eidos Interactive" "www.eidos.com" "NSLW" "$PREFIX" 

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking about patching or updating Wine version
if [ -e "$REPERTOIRE/configurations/installed/$TITLE" ]; then
POL_SetupWindow_menu "What do you want to do?" "Actions" "Patch game" "~"

if [ "$APP_ANSWER" == "Patch game" ]; then
patch_trIII
POL_SetupWindow_Close
exit
fi
fi

POL_SetupWindow_message "Please insert $TITLE media into your disk drive."
POL_SetupWindow_cdrom

cd "$CDROM"
CHECK=$(find . -iwholename ./tomb3.exe)
if [ "$CHECK" == "" ]; then
CHECK="tomb3.exe"
fi

POL_SetupWindow_check_cdrom "$CHECK"

if [ ! -d "$REPERTOIRE/wineprefix/$PREFIX" ]; then
POL_SetupWindow_prefixcreate
fi

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%" |tr -d '\015' | tr -d '\010'`
PROGRAMFILES=${PROGRAMFILES:3}
 
#adding CD-ROM as drive e: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" e:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg

sleep 5

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
cd "$CDROM"
wine "Setup.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Core Design/Tomb Raider III" "Tomb3.exe" "" "$TITLE" "" ""
POL_SetupWindow_make_icon_for_shortcut "$TITLE" "*_tomb3.0.xpm"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TITLE"

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Core Design/Tomb Raider III" "Tomb3.exe" "" "Setup $TITLE" "" "setup"
POL_SetupWindow_make_icon_for_shortcut "Setup $TITLE" "*_tomb3.0.xpm"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "Setup $TITLE"

cd "$REPERTOIRE/ressources"
#downloading XP patch
if [ ! -e "tr3updateXP.zip" ]; then
POL_SetupWindow_download "PlayOnLinux is downloading tr3updateXP.zip" "Downloading patch" "http://s1.sigmirror.com/files/48812_3gmm0/tr3updateXP.zip"
fi

#unpacking XP patch to temp
cd "$WINEPREFIX/drive_c/windows/temp/"
unzip "$REPERTOIRE/ressources/tr3updateXP.zip"

#installing XP patch
POL_SetupWindow_wait_next_signal "Installation of XP patch in progress..." "$TITLE"
wine "tr3update.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_message "$TITLE has been installed successfully" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFgACgkQ5TH6yaoTykddMgCfUnujUXYDgSyWCUmUI1Bsa+l4
DjEAn0EAkq9SsinoQWI37qR1dIXAg/L1
=vwMc
-----END PGP SIGNATURE-----
