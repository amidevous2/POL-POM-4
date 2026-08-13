#!/bin/bash
# Date : (2012-05-22 19-15)
# Last revision : (2014-02-28 20-29)
# Wine version used : 1.4, 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="gabriel_knight_3_blood_of_the_sacred_blood_of_the_damned"
PREFIX="GabrielKnight3_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Gabriel Knight 3: Blood of the Sacred, of the Damned"
SHORTCUT_NAME="Gabriel Knight 3: Blood of the Sacred, Blood of the Damned"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1220
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sierra / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "12db316178fbf6f476913754783ed848"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# So that it doesn't ask for "CDROM 1"
ln -sf / "$WINEPREFIX/dosdevices/p:"
cat <<_EOFINI_ > "$POL_USER_ROOT/tmp/cdrom.reg"
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\Wine\Drives]
"P:"="cdrom"
_EOFINI_
POL_Wine regedit.exe "$POL_USER_ROOT/tmp/cdrom.reg"
rm "$POL_USER_ROOT/tmp/cdrom.reg"

# There's lot of issues with GK3's Direct3D, http://bugs.winehq.org/show_bug.cgi?id=26566
# Force DirectDraw + software rendering
cat <<_EOFINI_ > "$POL_USER_ROOT/tmp/gk3software.reg"
REGEDIT4

[HKEY_CURRENT_USER\Software\Sierra On-Line\Gabriel Knight 3\Engine]
"Rasterizer"="software"
_EOFINI_
POL_Wine regedit.exe "$POL_USER_ROOT/tmp/gk3software.reg"
rm "$POL_USER_ROOT/tmp/gk3software.reg"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "GK3.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Gabriel Knight 3/Manual.pdf"
# C:\GOG Games\Gabriel Knight 3\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMTU4EACgkQ5TH6yaoTykdtjgCfRhAmQ534KATkeTonv6ZOw0l9
b8AAn1+JkaalFQiRnpYjpRF5TrD0gBG9
=oTCO
-----END PGP SIGNATURE-----
