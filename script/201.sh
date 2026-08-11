#!/bin/bash
# Date : (2015-03-30T20:30Z)
# Last revision : see changelog
# Distribution used to test : Arch Linux
# Author : Alexander Borysov (Xenos5)
# Script licence : GPLv3
# Program licence: Proprietary

# CHANGELOG
# [Alexander Borysov (Xenos5)] (2015-03-30 20:30)
#   Initial script.
# [Dadu042] (2020-01-15 16:00)
#   Wine 1.7.39 -> 3.0.3 .
#   Improve POL_Shortcut
#   Add POL_RequiredVersion
#   Improve GPU setup.
#   Add POL_Shortcut_Document
#   Add patch update function.
# [Dadu042] (2020-09-20 16:00)
#   Force OS to winxp.
#   Add shortcut to the settings tool
#
# KNOWN ISSUES :
#  - Wine amd64 3.0.3, 4.0.4, 5.0.2 + GOG release: the GOG's Settings.exe tool seems to change the language (it remembers it), but this does not work in the game. 
#
# KNOWN ISSUES (FIXED):

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="S.T.A.L.K.E.R.: Shadow of Chernobyl"
PREFIX="STALKERShadowOfChernobyl"
WINEVERSION="3.0.3"
STEAM_APP_ID=4500
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "THQ" "http://stalker-game.com" "Alexander Borysov" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

Set_OS "winxp"

################
#      GPU     #
################
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS "128"
  
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
   
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx



POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
 
if [ "$INSTALL_METHOD" = "DVD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "setup-1a.bin"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$CDROM/setup.exe"
elif [ "$INSTALL_METHOD" = "STEAM" ]; then
   POL_Call POL_Install_steam
   cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
   POL_Wine "steam.exe" "steam://install/$STEAM_APP_ID"
   POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext "Please select the setup file to run.")" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
fi
 

if [ "$INSTALL_METHOD" = "STEAM" ]; then
   POL_Shortcut "steam.exe" "$TITLE" "${TITLE}.png" "steam://rungameid/$STEAM_APP_ID -no-dwrite"
else
    binary_path=$(find_binary XR_3DA.exe | sed 's|dedicated/XR_3DA.exe$|XR_3DA.exe|g') # find_binary has a tendency to find bin/dedicated/XR_3DA.exe instead of bin/XR_3DA.exe
    POL_Shortcut "$binary_path" "$TITLE" "" "" "Game;"
    # POL_Shortcut "bin/XR_3DA.exe" "$TITLE" "" # needs commit 09735e098bc3aa6649393c9271d5f55466f35bfb, presumably in PoL 4.2.7

    POL_Shortcut_Document "$TITLE" "Stalker*.pdf"

    POL_Shortcut "Set*.exe" "$TITLE - Settings" "" "" "Game;"
fi4

################
# Patch update #
################
 
POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ?')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"     
 
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX2eaJgAKCRDlMfrJqhPK
R3vHAKCRrbjFx9x+hNaAaprig+9BQCZ/7wCdFyy3qnqNQkgln0KgMTopLPlyjv8=
=tXty
-----END PGP SIGNATURE-----
