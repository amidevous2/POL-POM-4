#!/usr/bin/env playonlinux-bash
# CHANGELOG
# **PlayOnLinux 4.2.8**
# Wine version used: 1.7.28
# Distribution used to test: openSUSE 13.2 x86_64
# MemoriesOnTV2 version used to test: 2.2.1
# Author: Ueliton
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Variables -------------
AUTHOR="Ueliton"
BINU_SERVER="http://media.binu.com/12630290/stream"
PREFIX="MemoriesOnTV2"
TITLE="MemoriesOnTV2"
WINEVERSION="1.7.28"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2546
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
  POL_Download "$BINU_SERVER/98566922982-dc363817786ff182/motv221.exe" "1d569cde2ef6076e05a12fa47d7a562a"
  POL_SetupWindow_message "$(eval_gettext 'Please do not restart.')" "$TITLE"
  POL_Wine_WaitBefore "$TITLE"
  POL_Wine motv221.exe
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
POL_Shortcut "MemoriesOnTV.exe" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlVv100ACgkQ5TH6yaoTykdSnQCgpOtOqykb4OSr7tXYznwW7dIB
pc4AoIeah3wxkDnh0aNqTJnJu9Ax7URN
=43x0
-----END PGP SIGNATURE-----
