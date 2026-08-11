#!/bin/bash
# Date : (2012-01-06 21-20)
# Last revision : (2014-03-09 11-49)
# Wine version used : 1.4-scummvm_support
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_feeble_files"
PREFIX="FeebleFiles_gog"
WORKING_WINE_VERSION="1.4-scummvm_support"

TITLE="GOG.com - The Feeble Files"
SHORTCUT_NAME="The Feeble Files"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1034
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Adventure Soft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "37173b8fc33148f087b919221ad7dc05" "2cfdbdbaf61663967d6748530d648337" "e44ace05f37979415565ebfeb19fc8a6"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


cat <<_EOFCFG_ > "$GOGROOT/The Feeble Files/feeble.polcfg"
[feeble]
description=The Feeble Files
platform=windows
gameid=feeble
language=en
_EOFCFG_

POL_Shortcut "feeble.polcfg" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/The Feeble Files/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMcUHUACgkQ5TH6yaoTykfmfQCdGwkRMFMcPzLykJZMvNDHN6jN
TxsAoIqsbtUIfHcvoBL5EK3BzkGhlI3B
=qMnN
-----END PGP SIGNATURE-----
