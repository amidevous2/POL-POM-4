#!/bin/bash
# Date : (2012-01-23 01-07)
# Last revision : (2014-02-09 22-13)
# Wine version used : 1.3.37, 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="jack_orlando_a_cinematic_adventure_dc"
PREFIX="JackOrlandoDC_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Jack Orlando: A Cinematic Adventure"
SHORTCUT_NAME="Jack Orlando DC"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1062
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Toontraxx / Topware Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "859e1dd5cc918d742c73b10d7ab1529c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Music's too loud vs voices with game defaults
# I hope it's not just my setup
cat << _EOFREG_ >> "$POL_USER_ROOT/tmp/sound_volumes.reg"
[HKEY_LOCAL_MACHINE\Software\TopWare Poland\Jack Orlando]
"Config"=hex:01,00,00,00,00,00,00,00,00,00,21,00,21,00,40,00,00,00,00,00,00,00,01,00,00,3a,5c,00,00,00,00,00,00,00,00,00,00,00
_EOFREG_
POL_Wine regedit "$POL_USER_ROOT/tmp/sound_volumes.reg"
rm "$POL_USER_ROOT/tmp/sound_volumes.reg"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "JackOrlando.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
# sometimes exits with an exitcode != 0 for what it seems no good reason
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Jack Orlando Director's Cut/Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlL38qsACgkQ5TH6yaoTykdYRACglcc+XRACc5ajgcCoJlA/oQEQ
f7gAn0l5LvzmUifS3pyGi+XIM9CvBlYQ
=me4U
-----END PGP SIGNATURE-----
