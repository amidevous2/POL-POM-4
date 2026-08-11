#!/usr/bin/env playonlinux-bash
# Date : (2019-03-13 15-30)
# Last revision : (2019-03-13 15-30)
# Wine version used : 4.3
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Game installer used: v2.1.0 (2011 ?), it works only from Wine v4.0.
 
[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Angry Birds Rio"
PREFIX="angrybirdsrio"
WORKING_WINE_VERSION="4.0"
AUTHOR="Dadu042"
EDITOR="Rovio"
GAME_URL="https://en.wikipedia.org/wiki/Angry_Birds_Rio"
 
Set_OS "win7"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Minimum version to have access to Wine 4.x
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
###############
# Go          #
###############
 
POL_SetupWindow_InstallMethod "LOCAL,CD"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "ABR.ico"
        POL_Wine start /unix "$CDROM/AngryBirdsRioInstaller_2.0.0.exe"
        POL_Wine_WaitExit "AngryBirdsRioInstaller.exe"
        cd "$POL_System_TmpDir"
fi
 
POL_Shortcut "AngryBirdsRio.exe" "$TITLE" ""
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiDHwAKCRDlMfrJqhPK
Ry1OAKCzBRRYFckYemMG5pbxKS7uwTv/egCeK98PwvrxWUhJB0tbI/QVaBY3Wdo=
=6frw
-----END PGP SIGNATURE-----
