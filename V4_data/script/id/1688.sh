#!/bin/bash
# Date : (2013-05-09 12-45)
# Last revision : (2019-11-02 20-50)
# Distribution used to test : Ubuntu 12.10 using Unity and Gnome
# Author : Manuel Vögele
# Script licence : GPLv3

# CHANGELOG
# [SuperPlumus] (2013-05-19 13-30)
#   Clean code
# [Dadu042] (2019-11-02)
#   Wine 1.5.29 -> 2.22
#   Note: Download URL is dead. Current release (IDA Pro v7) has a Linux native release.

# Manuel Vögele (2013 ?):
# I installed it under Ubuntu 12.10 using Unity and Gnome.
# I tested the disasembler functions which seemed to work fine.
# I did no deep tests on this tool and also didn't test the debugger.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="IDA 5 Pro Free"
WORKING_WINE_VERSION="2.22"
PREFIX="IDA5ProFree"
DOWNLOAD_LINK="https://out7.hex-rays.com/files/idafree50.exe"

POL_SetupWindow_Init
POL_Debug_Init

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_presentation "$TITLE" "Hex-Rays" "http://www.hex-rays.com/" "Manuel Vögele" "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    INSTALL_FILE="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOAD_LINK"
    INSTALL_FILE="$POL_System_TmpDir/idafree50.exe"
else
    POL_Debug_Fatal "Unknown install method."
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Wine start /unix "$INSTALL_FILE"
POL_Wine_WaitExit

#Apply game fixes
INSTALL_PATH=`find $WINEPREFIX -name "idag.exe" | sed s/idag.exe//g`
mv "$INSTALL_PATH/cfg/idagui.cfg" "$INSTALL_PATH/cfg/idagui_old.cfg"
# The line "BitwiseNegate" in the idagui.cfg has to be commented out
sed 's:"BitwiseNegate://"BitwiseNegate:' "$INSTALL_PATH/cfg/idagui_old.cfg" > "$INSTALL_PATH/cfg/idagui.cfg"

POL_Shortcut "idag.exe" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXb1GxQAKCRDlMfrJqhPK
R7PJAJ9riL2dYaS91fmcJfqQVzK/5/u79ACgpSWTIb5jDM01QQ2GgIqGSjLF9Ko=
=MN5w
-----END PGP SIGNATURE-----
