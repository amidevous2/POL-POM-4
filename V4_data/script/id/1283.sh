#!/bin/bash
# Date : (200x ?)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : Ubuntu 20.04 64 bits (Linux kernel v5.x). GPU: X
# Author : Quentin Paris
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions:
#
# Middlewares used by this software : 
#
# CHANGELOG
# [Dadu042] (2022-03-13 10-00).
#   Fix download URL.
#   Update some old functions.
#   However the program did fail to run (crash) with Wine 7.0, 6.0.1, 5.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Microsoft Freecell"
WINEVERSION="4.0.4"
EDITOR="Microsoft"
EDITOR_URL="http://www.microsoft.com"
PREFIX="MicrosoftFreecell"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_RequiredVersion "4.1.1" || POL_Debug_Fatal "PlayOnLinux 4.1.x required"
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

Set_OS "win98"
 
mkdir -p "$WINEPREFIX/drive_c/FreeCell"
cd "$WINEPREFIX/drive_c/FreeCell" || POL_Debug_Fatal "Unable to change directory"
 
POL_Call POL_Install_LunaTheme
POL_Download "http://ftpmirror.your.org/pub/misc/ftp.microsoft.com/Softlib/MSLFILES/PW1118.EXE"
POL_Wine_WaitBefore "$TITLE"
POL_System_unzip "PW1118.EXE" -d "$WINEPREFIX/drive_c/"
 
POL_Shortcut "FREECELL.EXE"  "$TITLE" "" "" "Game;"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYi5mOQAKCRDlMfrJqhPK
R/bmAKCiZAJlsaswTHY5hkuwlLkJ/S0aaACfRJsbL0RCksxDOtevVUEIYt3hvU4=
=7d7F
-----END PGP SIGNATURE-----
