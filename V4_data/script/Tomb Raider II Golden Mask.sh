#!/bin/bash
# Date : (2009-12-22 21-00)
# Last revision : (2009-12-22 21-00)
# Wine version used : Fedora 12
# Distribution used to test : 1.1.35
# Author : NSLW
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

TITLE="Tomb Raider II Golden Mask"
PREFIX="TRII"
WORKINGWINEVERSION="1.1.35"

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

wget http://upload.wikimedia.org/wikipedia/en/e/ef/TombRaiderGoldenMask.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TITLE" "Eidos Interactive" "www.eidos.com" "NSLW" "$PREFIX" 

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

POL_SetupWindow_message "Please insert Tomb Raider II media into your disk drive."
POL_SetupWindow_cdrom

cd "$CDROM"
CHECK=$(find . -iwholename ./setup.exe)

if [ "$CHECK" == "" ]; then
CHECK="setup.exe"
fi
POL_SetupWindow_check_cdrom "$CHECK"

APP_ANSWER=""
while [ "$APP_ANSWER" == "" ]; do
POL_SetupWindow_browse "Select Golden Mask file" "$TITLE" ""
sleep 1
CHECK="$APP_ANSWER"
APP_ANSWER=`echo "$CHECK" | grep tr2_gold`
done

if [ ! -d "$REPERTOIRE/wineprefix/$PREFIX" ]; then
POL_SetupWindow_prefixcreate
fi

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

#adding CD-ROM as drive d: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" e:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg

sleep 5

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
cd "$CDROM"
wine "$CHECK"
POL_SetupWindow_detect_exit

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Core Design/Tomb Raider II Gold (Full Net)" "t2gold.exe" "" "$TITLE" "" ""
POL_SetupWindow_make_icon_for_shortcut "$TITLE" "*_t2gold.0.xpm"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TITLE"

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Core Design/Tomb Raider II Gold (Full Net)" "t2gold.exe" "" "Setup $TITLE" "" "setup"
POL_SetupWindow_make_icon_for_shortcut "Setup $TITLE" "*_t2gold.0.xpm"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "Setup $TITLE"

POL_SetupWindow_message "$TITLE has been installed successfully" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFgACgkQ5TH6yaoTykf/vQCaAq7eRX6sN9W5WuuUznrFPCs5
GdkAoIB/R9oePerAf499sz6Goooc4sOI
=8wpA
-----END PGP SIGNATURE-----
