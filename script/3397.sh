#!/usr/bin/env playonlinux-bash
#
# Savage XR - Battle for Newerth. Installer script for Play On Linux/Mac.
#         http://www.savagexr.com
#         http://www.newerth.com/
#
# Date : (2018-10-19 12-00)
# Last revision : see changelog
# Wine version used : 3.20
# Distribution used to test : Xubuntu 18.04
# Game used to test : v1.4 (once patched after first start)
# Author : sea-eye-aya
#
# Tabs (not spaces), UTF-8, Unix line encoding.

# CHANGELOG
# [sea-eye-aya] (2018-10-19 12-00)
#   First script version.
# [sea-eye-aya] (2018-10-19 12-00)
#   Updates.
# [Dadu042] (2019-05-30 15-20)
#   Wine 3.18 -> 3.21  Minor changes. Standardize.
# [sea-eye-aya] (2020-01-11 12-00)
#   For some reason the PoL installer can no longer find the downloaded install file (xr_setup-1.0-cl_win_prod.exe) 
#   when it runs the POL_Wine command. Adding the $POL_System_TmpDir prefix to the command allows it to find it.
# [Dadu042] (2020-01-11 20-23)
#   Wine 3.21 -> 3.20 (latest available from POL v4.2.12)
#   Add POL_RequiredVersion "4.2.12"
#   Fix POL_Shortcut category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Savage XR"
PREFIX="SavageXR"
EDITOR="Newerth"
GAME_URL="http://www.newerth.com"
AUTHOR="sea-eye-aya"
WORKING_WINE_VERSION="3.20"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_System_TmpCreate "Tmp$PREFIX"
cd "$POL_System_TmpDir" || exit 1
 
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
  
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
        # Local install is really only meant for this script development purposes,
        # to stop hitting Newerth.com bandwidth needlessly!
        #
        POL_SetupWindow_browse "$(eval_gettext 'Please select the SavageXR installer.')" "$TITLE"
        cp "$APP_ANSWER" "$POL_System_TmpDir"
        SAVAGE_INSTALLER=$(basename "$APP_ANSWER")
 
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        # Grr POL_Download automatically give the file a name which is the end of the URL...
        #
        SAVAGE_INSTALLER="xr_setup-1.0-cl_win_prod.exe"
        AUTO_NAME="?id=downloads&op=downloadFile&file=xr_setup-1.0-cl_win_prod.exe&mirrorid=2"
        POL_Download "http://www.newerth.com/?id=downloads&op=downloadFile&file=xr_setup-1.0-cl_win_prod.exe&mirrorid=2" "84ddcf12e693f8ad0c91aefa39481328"
        mv "$AUTO_NAME" "$SAVAGE_INSTALLER"
fi
 
# Set WINE environment.
#
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_SetArch "x86"
Set_OS "win7"
 
# Run SavageXR installer.
#
POL_Wine_WaitBefore "$TITLE"
POL_SetupWindow_message "$(eval_gettext 'Before to start the Savage XR Installer, please choose:\n\t * The default install location.\n\t * The default settings.\n\nOnce installed you can register an account (to have your player stats and rankings recorded) or login as guest by leaving the fields empty.')"
POL_Wine "$POL_System_TmpDir/$SAVAGE_INSTALLER"
 
# Create shortcut to game.
#
POL_Shortcut "savage.exe" "$TITLE" "" "" "Game;"
POL_Shortcut_Document "$TITLE" "SavageXR_Guide.pdf"

# Clean up and exit.
#
POL_System_TmpDelete
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhohTAAKCRDlMfrJqhPK
R5k+AJwIOYR7azxAw15Q7rzueKu2XtTORQCfWruFT9BByvJDMNjdNQQCUb0eDfY=
=cdCt
-----END PGP SIGNATURE-----
