#!/bin/bash

# CHANGELOG
# [SuperPlumus] (2013-06-27 11-38)
#   Clean code
# [petch] (2013-07-13 08-00)
#   Update hash
# [petch] (2013-09-03 19-22)
#   Update hash
# [petch] (2014-01-17 19-56)
#   Update hash
# [petch] (2014-03-02 22-56)
#   Update hash
# [Dadu042] (2019-11-07 &é-56)
#   Disable download
#   Wine 1.2.3 -> 3.0.3


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Publish or Perish"
PREFIX="PublishOrPerish"
WORKING_WINE_VERSION="3.0.3"

EDITEUR="Harzing.com"
EDITEUR_URL="http://www.harzing.com/"
POP_URL="https://harzing.com/download/PoP7Setup.exe"
FILE="PoPSetup.exe"
EXECUTABLE="popwin.exe"
AUTEUR="Tinou"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITEUR" "$EDITEUR_URL" "$AUTEUR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

POL_Wine_InstallFonts
POL_Call POL_Install_LunaTheme

cd "$POL_System_TmpDir"

if [ "$POL_SELECTED_FILE" ]; then
    SetupFile="$POL_SELECTED_FILE"
else
    # POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
    INSTALL_METHOD="LOCAL"
    
    if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        POL_Download "$POP_URL" "f92c360208a9747bda5f910ce7e3819f"
        SetupFile="$POL_System_TmpDir/PoP7Setup.exe"
    elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SetupFile="$APP_ANSWER"
    fi
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupFile"

POL_System_TmpDelete

POL_Shortcut "$EXECUTABLE" "$TITLE"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcQIAwAKCRDlMfrJqhPK
R7uKAKCB9rZnUA8740OKwS2L9RIXRCNaBgCdFMCegDELVS7d6cb4rnDtmj2PEqM=
=rOaU
-----END PGP SIGNATURE-----
