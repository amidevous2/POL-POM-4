#!/bin/bash
# Date : (2010-03-12 21-00)
# Last revision : (2013-07-23 22-07)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-07-23 22-07)
#   Update gettext messages

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Baldur's Gate II Patch 2.5.23037"
TITLE_REQUIRED="Baldur's Gate II"
PREFIX="BaldursGate2"
PVERSION="2.5.23037"

#starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/BG2/top.jpg" "http://files.playonlinux.com/resources/setups/BG2/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION installer for $TITLE_REQUIRED')"

# Verify base game existence
if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit 1
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

#Using specific Wine
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_USER_ROOT/tmp"
    POL_SetupWindow_menu "$(eval_gettext 'Which version do you have?')" "$TITLE" "$(eval_gettext 'English version')~$(eval_gettext 'Italian version')~$(eval_gettext 'Japanese version')~$(eval_gettext 'International version')" "~"
    if [ "$APP_ANSWER" = "$(eval_gettext 'English version')" ]; then
        PATCH_URL="http://downloads.bioware.com/baldursgate2/Baldur%27sGateII-ShadowsofAmnPatchENGLISH.exe"
        PATCH_EXE="Baldur'sGateII-ShadowsofAmnPatchENGLISH.exe"
    elif [ "$APP_ANSWER" = "$(eval_gettext 'Italian version')" ]; then
        PATCH_URL="http://downloads.bioware.com/baldursgate2/Baldur%27sGateII-ShadowsofAmnItalianTLKUpdate.exe"
        PATCH_EXE="Baldur'sGateII-ShadowsofAmnItalianTLKUpdate.exe"
    elif [ "$APP_ANSWER" = "$(eval_gettext 'Japanese version')" ]; then
        PATCH_URL="http://downloads.bioware.com/baldursgate2/Baldur%27sGateII-ShadowsofAmnPatchJAPANESE.exe"
        PATCH_EXE="Baldur'sGateII-ShadowsofAmnPatchJAPANESE.exe"
    else
        PATCH_URL="http://downloads.bioware.com/baldursgate2/Baldur%27sGateII-ShadowsofAmnPatchEUROPE.exe"
        PATCH_EXE="Baldur'sGateII-ShadowsofAmnPatchEUROPE.exe"
    fi
    POL_Download "$PATCH_URL" ""
    POL_Wine start /unix "$PATCH_EXE"
    POL_Wine_WaitExit "$TITLE"
    rm "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHu5GIACgkQ5TH6yaoTykehFACfYXOiM4ba1HPOOZni8jiqQHE3
1AAAn1xIF3CPvpsBFxOm3f4lfkLlg4Pr
=EMtI
-----END PGP SIGNATURE-----
