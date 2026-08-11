#!/bin/bash
# Date : (2012-07-11 21-56)
# Last revision : 
# Wine version used :
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-07-11 21-56)
#   Initial script.
# [Pierre Etchemaite] (2014-05-17 23-37)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_whispered_world"
PREFIX="WhisperedWorld_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - The Whispered World Special Edition"
SHORTCUT_NAME="The Whispered World - Special Edition"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1309
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Daedalic Entertainment" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "be5869e5148c448325ae13f9780bba1e" "7ef8b93323a09a5c8ebdb5da3ceaf277" "f42ee15aeca76803a06deafced4144cc"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "256"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "twwse.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
# See: http://wiki.winehq.org/Sound ("SDL applications").
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'unset SDL_AUDIODIVER'
MANUAL="Manual_EN.pdf"
[ "$POL_LANG" = "es" ] && MANUAL="Manual_SP.pdf"
[ "$POL_LANG" = "de" ] && MANUAL="Manual_DE.pdf"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/The Whispered World - Special Edition/documents/$MANUAL"
# TWWOptions.exe only allows fullscreen/windowed setting, not worth using as configurator

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/The Whispered World - Special Edition/" || exit 1
TITLE="$TITLE"

POL_Wine VisionaireConfigurationTool.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxMeAAKCRDlMfrJqhPK
R8z4AJ9QRXCCSwogjUEIEf15rYoE/sIiCQCfet2rk0LIy05Y3NKBmVbiHEo4ge4=
=RW/p
-----END PGP SIGNATURE-----
