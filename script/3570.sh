#!/usr/bin/env playonlinux-bash
# Date : (2019-03-18)
# Last revision : (2021-10-09 08-21)
# Wine version used : 5.0.2
# Distribution used to test : Linux Mint 20.1 Cinnamon
# Author : Yaotl
# PlayOnLinux : 4.3.4
# Script licence : GPL3
# Program licence : https://nsis.sourceforge.io/License


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Nullsoft Scriptable Install System"
PREFIX="NSIS"

# Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 3570
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "Nullsoft" "https://nsis.sourceforge.io/" "Yaotl" "$PREFIX"

POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "6.0.1"

# Dependencies
POL_Call POL_Install_corefonts

Set_OS "win10"

# Installation
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    POL_Download "https://netcologne.dl.sourceforge.net/project/nsis/NSIS%203/3.08/nsis-3.08-setup.exe" "20c14273607e02112163a26309694364"
    INSTALLER="$POL_System_TmpDir/nsis-3.08-setup.exe"
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"

# Create Shortcut
POL_Shortcut "NSIS.exe" "$PREFIX" "" "" "Development;"

# Cleanup
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYWcCFgAKCRDlMfrJqhPK
R9X2AKCJcvXbA11RyQomufkNyVigWXakHQCfQ3TNjvXADqmOkLr93tM9cdplumw=
=1y01
-----END PGP SIGNATURE-----
