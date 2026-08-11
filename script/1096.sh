#!/bin/bash
# Date : (2012-03-11 19-24)
# Last revision : (2014-05-29 21-59)
# Wine version used : 1.4-scummvm_support, 1.6.2-scummvm_support
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="lure_of_the_temptress"
PREFIX="LureOfTheTemptress_gog"
WORKING_WINE_VERSION="1.6.2-scummvm_support"

TITLE="GOG.com - Lure of the Temptress"
SHORTCUT_NAME="Lure of the Temptress"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1096

POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Revolution Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a702cfd73ab6c6667b81937f45ec8c5b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# "SVGA videocard" (?)
POL_SetupWindow_VMS "2"

cat <<_EOFCFG_ > "$WINEPREFIX/drive_c/GOG Games/Lure of the Temptress/lure.polcfg"
[lure]
description=Lure of the Temptress (VGA/DOS/English)
platform=pc
gameid=lure
language=en
extra=VGA
multi_midi=true
enable_gs=true
native_mt32=true
_EOFCFG_

POL_Shortcut "lure.polcfg" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Lure of the Temptress/Manual.pdf"
# C:\GOG Games\Lure of the Temptress\solution.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOHm1wACgkQ5TH6yaoTykfbpQCfTjRY+mNTlXxxSsL0iD7NjesG
t6MAn3Jr7qu99LkTpeAmrf3FCIoxYEi5
=Kl20
-----END PGP SIGNATURE-----
