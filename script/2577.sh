#!/usr/bin/env playonlinux-bash
# Date : (2019-05-10 22-33)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Software version used of the software to write this script: v0.40 (2010)
#
#
# CHANGELOG
# [Dadu042] (2019-05-10 22-33)
#   Initial script.
#   As of 2019-05-10 the officials dedicated Wine instructions are down (http://wine.getcontinuum.com).
#   Windows .EXE is downloadable from other websites than the orignal (that block download because of Linux OS).
# [Dadu042] (2020-03-30 10:30)
#   Wine 4.1 (network issue) -> 3.20. Games does run up to the login step.
#   Alternative URL for Download from Linux: http://www.subspaceforum.com/downloads/

# KNOWN ISSUES
#  - Wine x86 4.1, 4.7: the game does not see the network ('Failing to connect to server').
#  - Wine x86 3.0.3: crash when launching ('Unexpected termination of services.exe'). Workaround: Wine 3.20
#
# KNOWN ISSUES (FIXED):
#  - Wine x86 5.0: X


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
     
TITLE="Subspace Continuum"
PREFIX="subspace-continuum"
WORKING_WINE_VERSION="3.20"
AUTHOR="Dadu042"
EDITOR=""
GAME_URL="http://subspace-continuum.com"
  
Set_OS "win7"
  
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
     
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"
 
###############
# Go          #
###############
     
POL_SetupWindow_InstallMethod "LOCAL"
     
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
fi
     
POL_Shortcut "Continuum.exe" "$TITLE" "" "" "Game;"
   
# POL_Shortcut_Document "$TITLE" ""
 
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXoHGCQAKCRDlMfrJqhPK
R1qRAJ9xgoLqrNhGb3VdomiMsffwFMNVtgCeLoIRG3c8i6ZssTI5iqjJJejKzm8=
=7/nq
-----END PGP SIGNATURE-----
