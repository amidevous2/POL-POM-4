#!/usr/bin/env playonlinux-bash
# Date : (2011-11-06 18-56)
# Last revision : (2020-08-04 00-59)
# Wine version used : 5.0.1
# Distribution used to test : Linux Mint 20 Cinnamon
# Author : thib25 & Tutul (update) && andykimpe (update)
#
# CHANGELOG
# [SuperPlumus] (2014-12-25 11-59)
#   Update Wine version 1.3.5 -> System
#   Update 7-Zip version 4.65 -> 9.20
#   Update messages
#   Change title and prefix names
# [SuperPlumus] (2014-12-25 11-59)
#   Clean code
# [p-90-for-retail] (2018-3-3 18-26)
#   Update 7-Zip version 9.20 -> 18.01
# [Yaotl] (2020-8-4 00-59)
#   Update System Wine -> 5.0.1
#   Update 7-Zip version 18.01 -> 19.00
#   Change Optimize code
#   Change Add local installation option
# [Dadu042] (2020-09-22 15-00)
#   Update System Wine 5.0.1 -> 5.0.2
#   Add POL_Shortcut category

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="7-Zip"
PREFIX="7zip"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/7zip/top.jpg" "http://files.playonlinux.com/resources/setups/7zip/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 373
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "7-Zip" "https://7-zip.org" "andykimpe" "$PREFIX"

POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "5.0.2"

# POL_Call POL_Install_LunaTheme

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "Please select the installation file to run." "$TITLE installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    if [ "$POL_ARCH" == "amd64" ]; then
        POL_Download "https://7-zip.org/a/7z1900-x64.exe" "d7b20f933be6cdae41efbe75548eba5f"
        INSTALLER="$POL_System_TmpDir/7z1900-x64.exe"
    else
        POL_Download "https://7-zip.org/a/7z1900.exe" "fabe184f6721e640474e1497c69ffc98"
        INSTALLER="$POL_System_TmpDir/7z1900.exe"
    fi
fi

POL_Wine_WaitBefore "$TITLE"
POL_AutoWine "$INSTALLER"

POL_System_TmpDelete

POL_Shortcut "7zFM.exe" "$TITLE" "" "" "Archiving;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX2n2VAAKCRDlMfrJqhPK
Ry9xAKChEQaSaZQYS1lHLohnUXLwE2lQ+wCgjsBlr1Y4ZtPpQdM0ugfJvMTQHL4=
=IIoV
-----END PGP SIGNATURE-----
