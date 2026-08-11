#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
cfg_check

FULLNAME="Sam and Max 201: Ice Station Santa"
CODENAME="sammax-201"
COMPANY="Telltale Games"
WEBSITE="http://www.telltalegames.com/samandmax"
SCRIPTER="Kjella"

INSTDIR="http://www.telltalegames.com/download"
INSTNAME="icestationsanta"

ICONDIR="http://files.telltalegames.com/productshots/gameicons"
ICONNAME="icon_sammax201.png"

LINKDIR="Program Files/Telltale Games/Sam and Max - Season Two/Episode 201 - Ice Station Santa"
LINKFILE="SamMax201.exe"
LINKNAME="Sam & Max 201: Ice Station Santa"

# Basic setup
POL_SetupWindow_Init
POL_SetupWindow_presentation "$FULLNAME" "$COMPANY" "$WEBSITE" "$SCRIPTER" "$CODENAME"
select_prefixe "$REPERTOIRE/wineprefix/$CODENAME"
POL_SetupWindow_prefixcreate 

### Custom: WINE setup
Set_OS "vista"

# Install game
cd $PLAYONLINUX/tmp/
POL_SetupWindow_download "Downloading installer from $COMPANY" "Downloading installer" "$INSTDIR/$INSTNAME"
POL_SetupWindow_download "Downloading 1.0.0.3 patch from $COMPANY" "Downloading patch" "http://telltale.vo.llnwd.net/o15/games/samandmax/201/patches/20071129_SamMax201_patch_1003.exe"
mv $INSTNAME $CODENAME.exe
wine $CODENAME.exe
rm $CODENAME.exe
wine 20071129_SamMax201_patch_1003.exe
rm 20071129_SamMax201_patch_1003.exe

### Custom: Remove WINE desktop icon
rm ~/Desktop/Episode\ 201\ -\ Ice\ Station\ Santa.desktop

# Set up the shortcut
cd $REPERTOIRE/icones
wget $ICONDIR/$ICONNAME
mv $ICONNAME $CODENAME.png
POL_SetupWindow_make_shortcut "$CODENAME" "$LINKDIR" "$LINKFILE" "$CODENAME.png" "$LINKNAME"

# Cleanup
POL_SetupWindow_reboot
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEwACgkQ5TH6yaoTykdWpgCeI++QV4yLmPp2wTE4QoQqKd6i
Gi4AnRMyRPRZBxUeYVaZRcbniwV2Esjt
=pEjr
-----END PGP SIGNATURE-----
