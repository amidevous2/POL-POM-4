#!/bin/bash
# Date : (2010-01-22 18-00)
# Last revision : (2010-01-24 16-00)
# Wine version used : 1.1.36
# Distribution used to test : Ubuntu 9.10
# Author : Wanama
# Licence : Retail
# Depend : -

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GAMETITLE="Anno 1602 Königs-Edition"
PREFIX="ANNO1602KE"

 
if [ "$POL_LANG" == "de" ]; then
LNG_MEM="Wieviel speicher hat deine Grafikkarte? (Ex : 32)"
LNG_WAIT_NEXT="Klicke erst auf \"Vor\" wenn das installieren abgeschlossen ist"
LNG_WAIT_END="wurde erfolgreich installiert"
LNG_INSTALL="ANNO 1602 Königs-Edition"
else
LNG_MEM="How much memory do your graphic card have got? (Ex : 32)"
LNG_WAIT_NEXT="Click on \"Next\" ONLY when the game installation"
LNG_WAIT_END="has been installed successfully"
LNG_INSTALL="ANNO 1602 Königs-Edition"
fi

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

POL_SetupWindow_Init

POL_SetupWindow_presentation "$GAMETITLE" "Sunflowers" "Max Design" "Wanama" "$PREFIX" 

CHOSENWINEVERSION="1.1.36"
POL_SetupWindow_install_wine "$CHOSENWINEVERSION"
Use_WineVersion "$CHOSENWINEVERSION"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "autorun.exe"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#adding CD-ROM as drive d: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" d:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
sleep 5

Set_OS win95

#install required libraries
POL_Call POL_Install_directplay # directplay for multiplayer

#starting installation
cd "$CDROM"
wine "autorun.exe"
POL_SetupWindow_message "$LNG_WAIT_NEXT" "$GAMETITLE"

cd "$WINEPREFIX/drive_c/windows/temp/"

#asking about memory size
POL_SetupWindow_menu_list "$LNG_MEM" "$GAMETITLE" "32-64-128-256-384-512-768-890-1024-2048" "-" "32"
VMS="$APP_ANSWER"

if [ "$VMS" -lt "32" ]; then
	POL_SetupWindow_message "" "$GAMETITLE" "$PLAYONLINUX/themes/tango/warning.png"
fi

echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg

#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi

#making shortcut
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/$LNG_INSTALL" "1602.EXE" "" "$GAMETITLE" "" ""
Set_WineVersion_Assign "$CHOSENWINEVERSION" "$GAMETITLE"
POL_SetupWindow_make_icon_for_shortcut "$GAMETITLE" "*_1602.0.xpm"

POL_SetupWindow_message "$GAMETITLE $LNG_WAIT_END" "$GAMETITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlXpouAACgkQ5TH6yaoTykemsgCgofPrJPomTPMoEjaQAR3Phi+c
nIQAn0Sppfl1yTJb/RicDao9Zhj55HA7
=1+LO
-----END PGP SIGNATURE-----
