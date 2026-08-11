#!/bin/bash
# Date : (2012-01-29 18-29)
# Last revision : (2014-02-09 20-35)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="broken_sword_2__the_smoking_mirror"
PREFIX="BrokenSword2DC_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Broken Sword 2: The Smoking Mirror"
SHORTCUT_NAME="Broken Sword 2: The Smoking Mirror"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1101
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Revolution Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "6939b542ad3194a81e0bd36409f1e72a"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "BrokenSword2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Broken Sword II - The Smoking Mirror Remastered/manual.pdf"
# C:\GOG Games\Broken Sword II - The Smoking Mirror Remastered\Readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlL33UgACgkQ5TH6yaoTykePygCdFOMIdCDnJnszGaNHP5olOM0Z
Y24AnilgjggztoTx7XJIluXfW/NlnI79
=x7YH
-----END PGP SIGNATURE-----
