#!/bin/bash
# Date : (2009-12-22 21-00)
# Last revision : (2009-12-22 21-00)
# Wine version used : Fedora 12
# Distribution used to test : 1.1.35
# Author : NSLW
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

TITLE="Tomb Raider Chronicles"
PREFIX="TRV"
WORKINGWINEVERSION="1.1.35"

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

#procedure for patching TombRaider V
patch_trV()
{
POL_SetupWindow_browse "Select patch file" "$TITLE" ""
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
wine "$APP_ANSWER"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "Patch for $TITLE has been installed successfully" "$TITLE"
}

wget http://upload.wikimedia.org/wikipedia/en/5/5f/TombRaiderChronicles.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
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
patch_trV
POL_SetupWindow_Close
exit
fi
fi

POL_SetupWindow_message "Please insert $TITLE media into your disk drive."
POL_SetupWindow_cdrom

cd "$CDROM"
CHECK=$(find . -iwholename ./PCTomb5.exe)
if [ "$CHECK" == "" ]; then
CHECK="PCTomb5.exe"
fi

POL_SetupWindow_prefixcreate
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

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Core Design/Tomb Raider Chronicles" "PCTomb5.exe" "" "$TITLE" "" ""
POL_SetupWindow_make_icon_for_shortcut "$TITLE" "*_pctomb5.0.xpm"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TITLE"

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Core Design/Tomb Raider Chronicles" "PCTomb5.exe" "" "Setup $TITLE" "" "setup"
POL_SetupWindow_make_icon_for_shortcut "Setup $TITLE" "*_pctomb5.0.xpm"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "Setup $TITLE"

cd "$REPERTOIRE/ressources"
#downloading XP patch
if [ ! -e "tr5updateXP.zip" ]; then
POL_SetupWindow_download "PlayOnLinux is downloading tr5updateXP.zip" "Downloading patch" "http://s1.sigmirror.com/files/48911_8msrd/tr5updateXP.zip"
fi

#unpacking XP patch to temp
cd "$WINEPREFIX/drive_c/windows/temp/"
unzip "$REPERTOIRE/ressources/tr5updateXP.zip"

#installing XP patch
POL_SetupWindow_wait_next_signal "Installation of XP patch in progress..." "$TITLE"
wine "tr5update.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_message "$TITLE has been installed successfully" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFgACgkQ5TH6yaoTykcpMACghWo2nUxH8jHxcurJ7v224WG6
MMsAmwSKT67C1TrQnjD3MzkuA5+lSfEI
=i6bm
-----END PGP SIGNATURE-----
