#!/bin/bash
# Date : (2012-03-26 20-43)
# Last revision : (2013-10-26 16-25)
# Wine version used : 1.3.27
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# 1.3.32, 1.3.37, 1.4.1, 1.5.0: slow
# 1.3.29: slow?
# 1.3.28: no sound (complains about DirectSound)
# 1.3.27: fast

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="freespace_2"
PREFIX="Freespace2_gog"
WORKING_WINE_VERSION="1.3.27"

TITLE="GOG.com - Freespace 2"
SHORTCUT_NAME="Freespace 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1107
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Volition / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "2870b98722a1e56a360e3a959019e678"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "FS2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Freespace 2/MANUAL.PDF"
# C:\GOG Games\Freespace 2\ReadMe.txt
# C:\GOG Games\Freespace 2\refcard.pdf
# C:\GOG Games\Freespace 2\FRED2.exe

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJr1lwACgkQ5TH6yaoTykfr0ACeK8m7Z/270jYIkdsQlPxR4jv8
YnwAnjopoAk7CHu1hJTckf+iMnGnmAAE
=8ecp
-----END PGP SIGNATURE-----
