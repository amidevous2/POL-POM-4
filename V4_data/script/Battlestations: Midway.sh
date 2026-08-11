#!/usr/bin/env playonlinux-bash
# Date : (2019-05-06 21-14)
# Last revision : (2019-05-06 21-14)
# Wine version used : see below
# Distribution used to test : Ubuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Media used: DVD, febuary 2008 (folders date), pre patched 1.1.1.

#
# Known issues
# W 4.7 : game does not see the DVD.


[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Battlestations: Midway"
PREFIX="bsmidway"
WORKING_WINE_VERSION="4.0.3"
AUTHOR="Dadu042"
EDITOR="Eidos"
GAME_URL="https://pcgamingwiki.com/wiki/Battlestations:_Midway"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"

################
# GPU settings #
################

# Really indispensable ? (Dadu042)
POL_SetupWindow_VMS "64"

POL_Call POL_Install_VideoDriver
 
POL_Call POL_Install_d3dx9_43
POL_Call POL_Install_d3compiler_43
 
###############
# Go          #
###############

POL_SetupWindow_InstallMethod "LOCAL,DVD"

POL_SetupWindow_message  "Warning: Please DO NOT install DirectX nor GameShadow ! (this is the way this script was tested).\nAnd do not launch the game at the end of the installation." "$TITLE"
   
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "MidwayDF.cab"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "Battlestationsmidway.exe" "$TITLE" ""

POL_Shortcut "Options.exe" "$TITLE - Options" ""

# Filename to change according the language
POL_Shortcut_Document "$TITLE" "PC_MANUAL_UK.pdf"


POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiB3wAKCRDlMfrJqhPK
R09LAJkB+E+3FjhdNIQQFsIaOydrawGYzACfcyPTuFHPYpjITFD0FtCsJlQlLS0=
=Xi+5
-----END PGP SIGNATURE-----
