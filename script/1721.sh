#!/bin/bash
# Date : (2013-05-27 22-00)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Fedora 17, Debian Sid
# Author : TonyFlow
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [TonyFlow] (2013-05-27 22-00)
#   Initial script.
# [Pierre Etchemaite] (2013-12-29 11-28)
#   Script updated for GOG's installer v2 ?
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="stronghold"
PREFIX="Stronghold_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Stronghold HD"
SHORTCUT_NAME="Stronghold HD"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1721
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "FireFly Studios" "http://www.gog.com/gamecard/$GOGID" "TonyFlow" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" "2" "a26178ebca7865949d2458818464cd4e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

POL_Call POL_Install_directplay

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesnt hurt ;)
POL_Wine_reboot

# Language selection for the manual shortcut
POL_SetupWindow_menu "$(eval_gettext 'What is your preferred language?')" "$(eval_gettext 'Language')" "en: English~fr: French~de: German~it: Italian~es: Spanish" "~"
MAN_LANG=$(echo "${APP_ANSWER}" | cut -d ':' -f 1)

# Configure the shortcut
GOGPATH="$GOGROOT/Stronghold HD"
POL_Shortcut "Stronghold.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGPATH/manual/manual_$MAN_LANG.pdf"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx+EQAKCRDlMfrJqhPK
R7RSAJ9f+E8YIbsjcMbbLVZ1iYT1Go8A5wCfbiYgyFsBxhA8iHH8siAA9enE2hA=
=yjPc
-----END PGP SIGNATURE-----
