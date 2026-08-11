#!/bin/bash
# Date : (2012-06-23 11-41)
# Last revision : see changelog
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-23 11-41)
#   Initial script.
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="splinter_cell"
PREFIX="SplinterCell_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Splinter Cell"
SHORTCUT_NAME="Tom Clancy's Splinter Cell"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1272
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft Montréal / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "66ca4861f727eddc2ce641670497962c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

cat <<_EOFFUNC_ > "$GOGROOT/Splinter Cell/system/splinter_funcs"

read_sc_settings () {
  [ -z "\$WINEPREFIX" ] && POL_Debug_Fatal 'read_sc_settings: \$WINEPREFIX must be set'
  perl -ne 'print "SCWIDTH=\$1\nSCHEIGHT=\$2\n" if /^Resolution=(\d+)x(\d+)/' "$GOGROOT/Splinter Cell/system/SplinterCellUser.ini"
}

sync_resolutions () {
  eval \$(read_sc_settings)
  # From what I've read game requires virtual desktop, but I can't really test
  Set_Desktop "On" "\$SCWIDTH" "\$SCHEIGHT"
}

_EOFFUNC_

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "SplinterCell.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'source "splinter_funcs"'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'sync_resolutions'
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Splinter Cell/Manual.pdf"
# C:\GOG Games\Splinter Cell\Readme.rtf
# C:\GOG Games\Splinter Cell\reference card.pdf

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpyCFwAKCRDlMfrJqhPK
RzBeAKCyrWt4TIpXpfQUyo17i+dfk1nvoACgjksQ/m3ess56zJvwfMVZ+biWCwY=
=wq0G
-----END PGP SIGNATURE-----
