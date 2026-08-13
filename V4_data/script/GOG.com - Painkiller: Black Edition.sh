#!/bin/bash
# Date : (2012-01-07 21-26)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-01-07 21-26)
#   Initial script.
# [Pierre Etchemaite] (2013-12-13 20-51)
#   ?
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="painkiller"
PREFIX="PainkillerBlack_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Painkiller: Black Edition"
SHORTCUT_NAME="Painkiller Black Edition"
SHORTCUT_EDITOR="$SHORTCUT_NAME - $(eval_gettext 'Editor')"
SHORTCUT_DS="$SHORTCUT_NAME - $(eval_gettext 'Dedicated Server')"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1035
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "People Can Fly / Nordic Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 3 "c433bc586d932316d15a66d9735fba15" "d726f29f968a85f148d8109b8aac46e2" "d246d7b52caf147adbfb9df5550e87b2" "c2d78223714c48899e9812d93f4648db"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

LNG_EDITOR="$(eval_gettext 'Editor')"
LNG_DS="$(eval_gettext 'Dedicated server')"
POL_SetupWindow_checkbox_list "$(eval_gettext 'What extra shortcuts should be created?')" "$TITLE" "${LNG_EDITOR}~${LNG_DS}" "~"
SHORTCUTS="$APP_ANSWER"

POL_Shortcut "Painkiller.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Painkiller Black/Docs/Manual.pdf"
# C:\GOG Games\Painkiller Black\Docs\ReadMe.txt

if echo "$SHORTCUTS" | grep -q "$LNG_EDITOR"; then
    POL_Shortcut "PainEditor.exe" "$SHORTCUT_EDITOR" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
    POL_Shortcut_Document "$SHORTCUT_EDITOR" "$GOGROOT/Painkiller Black/Docs/Pain Engine.pdf"
fi

if echo "$SHORTCUTS" | grep -q "$LNG_DS"; then
    POL_Shortcut "Painkiller.exe" "$SHORTCUT_DS" "$SHORTCUT_NAME.png" "-dedicated" "Game;ActionGame;"
fi

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYeygAKCRDlMfrJqhPK
RxAGAJ9uZFzZXALRNztZudTmZsht34FLLQCggOrsKR+ZkwGGQ6CY7G7pvqtb3VM=
=gH5H
-----END PGP SIGNATURE-----
