#!/usr/bin/env playonlinux-bash
# Date : (2014 ? )
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : 
# Author : see changelog
# PlayOnLinux : 4.3.4
# Script licence : GPL3
# Program licence : Freeware
#
# CHANGELOG
# Script by Tinou (original) and Congelli501
# [SuperPlumus] (2013-07-08 12-03)
#   Update POLv3 -> POLv4
# [SuperPlumus] (2017-05-20 16-05)
#   Update Notepad++ version 6.8.8 to 7.4.1
# [p-90-for-retail] (2018-03-03 19-13)
#   Improvments
#   Updated NP++
#   ...
# [Yaotl] (2019-10-29 14-53)
#   Update Notepad++ 7.7.1 to 7.8.1
#   Update Wine 4.0.1 to 4.0.2
#   Script Fixes
# [Yaotl] (2019-12-01 06-58)
#   Fix invalid URL.
#   Update Wine 4.0.2 to 4.0.3
#   Add corefonts
# [mrHedgehog] (2020-01-21 16-01)
#   Update Notepad++ from 7.8.1 to 7.8.3
#   Update Wine from 4.0.3 to 5.0
# [Dadu042] (2020-06-16 09-00)
#   Wine 5.0 -> 5.0.1
#   Add category TextEditor
# [Yaotl] (2020-09-11 15-07)
#   Update Notepad++ 7.8.3 to 7.8.9
#   Wine 5.0.1 -> 5.0.2
#   Added auto selection for 32-bit or 64-bit installation
# [Yaotl] (2020-12-05 16-18)
#   Update Notepad++ 7.8.9 to 7.9.1
#   Wine 5.0.2 -> 5.0.3
# [Yaotl] (2021-06-14 21-45)
#   Update Notepad++ 7.9.1 to 8.0
#   Wine 5.0.3 -> 6.0.1

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Notepad Plus Plus"
PREFIX="NotepadPlusPlus"
WORKING_WINE_VERSION="6.0.1"
NPVERSION="8.0"
# x86
DOWNLOAD_URL_X86="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8/npp.8.0.Installer.exe"
MD5_CHECKSUM_x86="940f248133b55d6ebba043f872a01d56"
# x64
DOWNLOAD_URL_X64="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8/npp.8.0.Installer.x64.exe"
MD5_CHECKSUM_x64="6cf3f43a109fb82ea740dc98c54be109"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/np/top.jpg" "http://files.playonlinux.com/resources/setups/np/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 69
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Don Ho" "https://notepad-plus-plus.org/" "POL & POM Community" "$PREFIX"

POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_corefonts

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    INSTALLER="$APP_ANSWER"
else
    if [ "$POL_ARCH" == "amd64" ]; then
        ARCH=".x64"
        DOWNLOAD_URL=$DOWNLOAD_URL_X64
        MD5_CHECKSUM="$MD5_CHECKSUM_x64"
    else
        ARCH=""
        DOWNLOAD_URL=$DOWNLOAD_URL_X86
        MD5_CHECKSUM="$MD5_CHECKSUM_x86"
    fi
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOAD_URL" "$MD5_CHECKSUM"
    INSTALLER="$POL_System_TmpDir/npp.$NPVERSION.Installer$ARCH.exe"
fi

POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"

POL_Shortcut "notepad++.exe" "Notepad++" "" "" "Development;TextEditor;"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYMl9wQAKCRDlMfrJqhPK
R6rrAJ916PiLsoHc8v1OLWCcYxGVEx5wHACaAx/ySKiK0VGH40tNrRCfi4BYoMM=
=kRpg
-----END PGP SIGNATURE-----
