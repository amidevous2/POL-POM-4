#!/bin/bash
# Date : (2009-05-23 12-14)
# Last revision : (2015-05-27 07-07)
# Wine version used : 1.6.2
# Author : NSLW
# updated: petch
# Licence : Retail
#
# CHANGELOG
# [NSLW] (2009-05-23 12-14)
#   Initial script.
# [Dadu042] (2020-01-29 11:30)
#   Wine 1.6.2 -> 3.0.3.
#   Improve POL_Shortcut
#   Standardize POL_Function_NoCDWarning

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Call of Duty 4: Modern Warfare"
PREFIX="COD4"
 
# procedure for patching cod4
patch_cod4()
{
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Select patch file downloaded from www.infinityward.com')" "$TITLE" ""
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
    POL_SetupWindow_message "$(eval_gettext 'Patch for $TITLE has been installed successfully')" "$TITLE"
}
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "infinityward" "www.infinityward.com" "NSLW" "$PREFIX"
 
if [ -e "$POL_USER_ROOT/configurations/installed/$TITLE" ]; then
    POL_SetupWindow_menu "$(eval_gettext 'What do you want to do?')" "$(eval_gettext 'Actions')" "$(eval_gettext 'Patch game')" "~"
 
    if [ "$APP_ANSWER" == "$(eval_gettext 'Patch game')" ]; then
        patch_cod4
    fi
 
    POL_SetupWindow_Close
    exit 0
fi

POL_Call POL_Function_NoCDWarning

POL_SetupWindow_message "$(eval_gettext 'Please insert $TITLE media into your disk drive.')"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.0.3"
 
#starting installation
POL_Wine_WaitBefore "$TITLE"
cd "$CDROM"
POL_Wine "setup.exe"
POL_Wine_WaitExit "$TITLE"
 
POL_Wine_Direct3D "Multisampling" "enabled"
POL_SetupWindow_VMS
 
cd  "$WINEPREFIX/drive_c/windows/temp/"
convert "$CDROM/Setup/rsrc/cod4.ico" -geometry 32X32 "cod4.png"
cp "cod4-1.png" "$POL_USER_ROOT/icones/32/$TITLE Singleplayer"
cp "cod4-1.png" "$POL_USER_ROOT/icones/32/$TITLE Multiplayer"
 
#making shortcut
POL_Shortcut "iw3sp.exe" "$TITLE Singleplayer" "" "" "Game;"
POL_Shortcut "iw3mp.exe" "$TITLE Multiplayer" "" "" "Game;"
 
#asking about patching
POL_SetupWindow_question "$(eval_gettext 'Do you want to patch your game?')" "$TITLE"
if [ "$APP_ANSWER" == "TRUE" ]; then
    patch_cod4
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjFY9gAKCRDlMfrJqhPK
R7dcAJ4+IyjiNZ8AMTe9wsHDK3HdHPc1HgCgnGilZ1KfyYmjKvqFcXuOK5+7QyE=
=nxzm
-----END PGP SIGNATURE-----
