#!/bin/bash
# Date : (2015-09-27 22:00)
# Last revision : (2016-01-01 13:08)
# Wine version used : 1.8
# Distribution used to test : Ubuntu 15.04 64bit
# Author : LinuxScripter
# Script licence : GPLv3
# Program licence : Proprietary

# CHANGELOG
# [Dadu042] (2022-04-12 10-00).
#   Wine 1.8 (outdated and incompatible with Ubuntu 18.04+) -> 4.0.4


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Space Engineers"
PREFIX="SpaceEngineers"
EDITOR="Keen Software House"
AUTHOR="LinuxScripter"
GAME_URL="http://www.spaceengineersgame.com"
WORKING_WINE_VERSION="4.0.4"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/SpaceEngineers-48x48.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/SpaceEngineers-22x22.jpg" "$TITLE"

# Starting the script
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating 32-bit prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing mandatory dependencies BEFORE installing Steam so the buttons inside Steam windows won't appear textless.
# If this wont work you might have to manually instal SE and set dlls below to native.
POL_Call POL_Install_corefonts
POL_Call POL_Function_FontsSmoothRGB
POL_Call POL_Install_dotnet40
POL_Call POL_Install_vcrun6
POL_Call POL_Install_vcrun2012
POL_Call POL_Install_d3dx11_42
POL_Call POL_Install_d3dx11_43
POL_Wine_OverrideDLL "" "dwrite"
POL_Wine_OverrideDLL "native" "oleaut32"
POL_Wine_OverrideDLL "native" "mscoree"
POL_Wine_OverrideDLL "native" "x3daudio1_7"

POL_SetupWindow_InstallMethod "STEAM,DVD"

# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
    POL_Call POL_Install_steam
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine "steam.exe" steam://install/244850
    POL_Wine_WaitBefore "$TITLE"
else
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
    POL_Wine start /unix "$SETUP_EXE"
    POL_Wine_WaitExit "$TITLE"
fi

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
    POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/244850"
else
    POL_Shortcut "SpaceEngineers.exe" "$TITLE" "" "" "Game;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYlVOoQAKCRDlMfrJqhPK
R5PMAJ9LrQoE4Y/Mn0Yj8+rPIxyZWEq4/ACeKiTk2O1KOZH2Szj+vbCk56stfvo=
=CI+a
-----END PGP SIGNATURE-----
