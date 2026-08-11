#!/bin/bash
# Date : (2012-05-12 14-11)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-12 14-11)
#   Initial script.
# [Pierre Etchemaite] (2014-01-31 23-06)
#   ? Wine 1.4.1 -> 1.6.2 ?
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.6.2 -> 2.22
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="baldurs_gate_2_complete"
PREFIX="BaldursGate2_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Baldur's Gate II Complete"
SHORTCUT_NAME="Baldur's Gate II"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/BG2/top.jpg" "http://files.playonlinux.com/resources/setups/BG2/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1182
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bioware / Hasbro Inc." "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e6e71dc71a4dd15571bf1995e3427377" "609d4020f2acfd2a3195c70608fdea54" "ddb6e622e1254b5e9fd18137910ccaed"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "BGMain.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Baldur's Gate 2/manual.pdf"
# C:\GOG Games\Baldur's Gate 2\Readme.txt
# C:\GOG Games\Baldur's Gate 2\Readme_addon.txt

#POL_Shortcut "CharView.exe" "$SHORTCUT_NAME - Character Viewer" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Baldur's Gate 2/" || exit 1

TITLE="$TITLE"

POL_SetupWindow_Init

POL_Wine BGConfig.exe
POL_Call POL_Configurator_runparts

POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYk8wAKCRDlMfrJqhPK
R/49AKCqHdRj2/EQkzkjRQB4+xwKGyFQDACfadiQw+yZ7ynMHo6AHl4UEDhKmHw=
=CVX4
-----END PGP SIGNATURE-----
