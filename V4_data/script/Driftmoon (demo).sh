#!/bin/bash
# Date : (2012-11-24 21:30)
# Last revision : (2019-11-01)
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 19.04 amd64
# Author : hmdai (Based on Deponia DC script by Kweepeer and PDF-XChange Viewer by Fredo)
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# CHANGELOG
# [Dadu042] (2012-11-24)
#   hmdai.
# [Dadu042] (2019-11-01)
#   Wine 1.5.5 -> 3.0.3 (latest supported by POL 4.2.12)
#   Used game v1.016 (got from automatic download)


# KNOWN ISSUES:
#  - Wine amd64 3.0.3: missing text on the two buttons of the first window (Play Demo / Get Full Version). Fix: Wine 4.0.2



[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="Driftmoon"
WORKING_WINE_VERSION="3.0.3"
 
TITLE="Driftmoon"
SHORTCUT_NAME="Driftmoon"
 
POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1479
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Instant Kingdom" "http://www.instantkingdom.com/driftmoon/" "hmdai" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
Set_OS winxp
 
POL_SetupWindow_VMS "128"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
if [ "$INSTALL_METHOD" == "DOWNLOAD" ]
then
   POL_System_TmpCreate "$TITLE"
   cd "$POL_System_TmpDir"
   POL_Download "http://www.instantkingdom.com/download/driftmoon.exe"
   INSTALLER="driftmoon.exe"
else
    POL_SetupWindow_browse "$(eval_gettext "Please select the setup file to run.")" "$TITLE"
    INSTALLER="$APP_ANSWER"
fi
 
# Installation in progress
POL_SetupWindow_WaitBefore "$TITLE"
POL_Debug_Message "Installing $TITLE from $INSTALLER."
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$TITLE"
 
# Doesn't hurt ;)
POL_Wine_reboot
 
POL_Shortcut "Driftmoon.exe" "$SHORTCUT_NAME" "" "" "Game;RoleGame;"
 
# Clean up
POL_System_TmpDelete
 
POL_SetupWindow_Close
 
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbyCuAAKCRDlMfrJqhPK
RykqAJ9992tMwqLv1pThp2anmEWxbDV5SQCfeVoIEtZAYj0TxExTwiEYaQvm9Tw=
=vn1n
-----END PGP SIGNATURE-----
