#!/bin/bash
# Date : (2009-05-24 10-15)
# Last revision : (2009-05-24 10-15)
# Wine version used : N/A 
# Distribution used to test : N/A
# Author : NSLW
# Licence : Retail

#Translated from V2 to V3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

TITLE="Hitman 2 : Silent assassin"
PREFIX="Hitman2" 

wget http://upload.wikimedia.org/wikipedia/en/c/cd/Hitman_2_artwork.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TITLE" "Io Interactive" "http://www.hitman2.com/" "The_Mystery_Machine and NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
cd "$WINEPREFIX/dosdevices"
ln -s $CDROM d:

echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > $REPERTOIRE/tmp/cdrom.reg
echo "\"d:\"=\"cdrom\"" >> $REPERTOIRE/tmp/cdrom.reg
regedit $REPERTOIRE/tmp/cdrom.reg
sleep 5

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
cd $CDROM
wine "setup.exe"
POL_SetupWindow_detect_exit
 
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Eidos Interactive/Hitman 2 Silent Assassin" "config.exe" "" "$TITLE" "" ""
POL_SetupWindow_reboot 
 
if [ "$POL_LANG" == "fr_FR.UTF-8" ]
then

POL_SetupWindow_message "Hitman 2 : Silent Assassin supporte mal le mode plein écran, il est donc conseillé de le décocher dans les options en début de jeu" "Note about fullscreen" "/home/user/playonlinux/themes/tango/warning.png"

else

POL_SetupWindow_message "Hitman 2: Silent Assassin doesn't support full-screen mode, it is advised to unselect it in the option at the beginning of the game" "Note about fullscreen" "/home/user/playonlinux/themes/tango/warning.png"
 
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEQACgkQ5TH6yaoTykdTVwCgk090DZCHLlj2i6TOBzpi+8oy
8UcAoJb2PmstHu7DmKWF13iYozV1Xhu9
=dDMh
-----END PGP SIGNATURE-----
