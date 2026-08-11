#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
cfg_check

FULLNAME="Sam and Max 203: Night of the Raving Dead"
CODENAME="sammax-203"
COMPANY="Telltale Games"
WEBSITE="http://www.telltalegames.com/samandmax"
SCRIPTER="Kjella"

INSTDIR="http://www.telltalegames.com/download"
INSTNAME="nightoftheravingdead"

ICONDIR="http://files.telltalegames.com/productshots/gameicons"
ICONNAME="icon_sammax203.png"

LINKDIR="Program Files/Telltale Games/Sam and Max - Season Two/Episode 203 - Night of the Raving Dead"
LINKFILE="SamMax203.exe"
LINKNAME="Sam & Max 203: Night of the Raving Dead"

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
mv $INSTNAME $CODENAME.exe
wine $CODENAME.exe
rm $CODENAME.exe

### Custom: Remove WINE desktop icon
rm ~/Desktop/Episode\ 203\ -\ Night\ of\ the\ Raving\ Dead.desktop

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

iEYEABECAAYFAk1cJEsACgkQ5TH6yaoTykfqqACdHFmpGUYmX58aiBGyZR64KipO
HZwAnRZA733qYCBiR0jxMqJYAG9+atXz
=lypq
-----END PGP SIGNATURE-----
