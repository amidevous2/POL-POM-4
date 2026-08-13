#!/bin/bash
# Date : (2013-01-05 22-55)
# Last revision : (2013-07-14 21-02)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="conflict_desert_storm"
PREFIX="ConflictDesertStorm_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Conflict: Desert Storm"
SHORTCUT_NAME="Conflict: Desert Storm"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1529
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Pivotal Games / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "dcbc662e7d9b855ba131a82b749f32a1"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Didn't manage to get it working, but prevents game crash on exit
POL_Call POL_Install_directplay

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "DesertStorm.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Conflict - Desert Storm/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHi/C0ACgkQ5TH6yaoTykeAEACfeizGDEMHAyod0+BjiH8ELgAk
JmQAnjHJaU9GNLV+4QAX++6qz5YNkqfK
=kYob
-----END PGP SIGNATURE-----
