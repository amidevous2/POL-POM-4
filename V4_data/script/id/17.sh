#!/bin/bash
# Author : Tinou
 
# CHANGELOG
# [SuperPlumus] (2013-07-24 15-22)
#   Update gettext messages
 
# CHANGELOG
# [Tutul] (2014-11-09 13-55)
#   Update local installation
 
[ "$PLAYONLINUX" = "" ] && exit 1
source "$PLAYONLINUX/lib/sources"
 
TITLE="Diablo II : Lord Of Destruction"
PREFIX="DiabloII"
PATCHTITLE="Blizzard Updater v2.72"
PATCHLINK="http://ftp.blizzard.com/pub/diablo2exp/patches/PC"
PATCHFILE="LODPatch_113d.exe"
PATCHFILESUM="49d70c8b15988e5bb15853d0466f2a7e"

 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Blizzard" "http://www.blizzard.com/" "Tinou" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit 1
fi
 
POL_SetupWindow_InstallMethod "CD,LOCAL"
 
if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_Call POL_Wine_InstallCDROM "1" "w" "D2xMusic.mpq"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$CDROM/install.exe"

    POL_Call POL_Wine_InstallCDROM "2" "w" "d2music.mpq" "Installer Tome 2.mpq" "Installer_Tome_2.mpq"

    POL_Call POL_Wine_InstallCDROM "01" "w" "D2xMusic.mpq"
else
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SetupFile="$APP_ANSWER"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$SetupFile"
fi
 
POL_Wine_WaitExit "$TITLE"

POL_Download_Resource "$PATCHLINK/$PATCHFILE" "$PATCHFILESUM"
POL_Wine start /unix "$POL_USER_ROOT/ressources/$PATCHFILE"
POL_Wine_WaitExit "$PATCHTITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXeowlQAKCRDlMfrJqhPK
RwJMAJ9cqRGFBnku5XD/8Nnv8yPHph21gQCeJQp401oiOFGfYcyzH6pvOmkhj78=
=P0VX
-----END PGP SIGNATURE-----
