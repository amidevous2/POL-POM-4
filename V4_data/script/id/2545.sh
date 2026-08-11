#!/usr/bin/env playonlinux-bash
# CHANGELOG
# **PlayOnLinux 4.2.8**
# Wine version used: 1.7.28
# Distribution used to test: openSUSE 13.2 x86_64
# PictureToTV version used to test: 1.4.5
# Author: Ueliton

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Variables
AUTHOR="Ueliton"
BINU_SERVER="http://media.binu.com/12630290/stream"
PREFIX="PictureToTV"
TITLE="PictureToTV"
WINEVERSION="1.7.28"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2545

# Enable debugging
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "Codejam Pte Ltd" "www.codejam.com" "$AUTHOR" "$PREFIX"

# Managing prefix and Wine version
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Creating Temp directory
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
# Installation Method DOWNLOAD
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
  then
  POL_Download "$BINU_SERVER/98566922764-6b5754d737784b51/p2tv145.exe" "de0d261d897450852c5c0be79036b595"
  POL_SetupWindow_message "$(eval_gettext 'Please do not restart.')" "$TITLE"
  POL_Wine_WaitBefore "$TITLE"
  POL_Wine p2tv145.exe
fi

# Installation Method LOCAL
if [ "$INSTALL_METHOD" = "LOCAL" ]
  then
      cd "$HOME"
      POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
      POL_SetupWindow_message "$(eval_gettext 'Please do not restart.')" "$TITLE"
      POL_Wine_WaitBefore "$TITLE"
      POL_Wine "$APP_ANSWER"
fi
# Delete temp directory
POL_System_TmpDelete
# Create a launcher
POL_Shortcut "PictureToTV.exe" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlVvifwACgkQ5TH6yaoTykcsawCdEmJ7idyxl0lCJh3zrYgVljgn
TtkAoJndhd92djd4jh2iw1poUELMShWO
=q5T9
-----END PGP SIGNATURE-----
