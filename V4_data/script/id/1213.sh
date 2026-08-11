#!/bin/bash
# Date : (2012-05-19 12-38)
# Last revision : (2014-02-02 13-34)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="icewind_dale_2"
PREFIX="IcewindDale2_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Icewind Dale II Complete"
SHORTCUT_NAME="Icewind Dale II"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1213
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Black Isle Studios / Hasbro Inc." "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "40df734de7f050433fabb91a9f75bde8"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "IWD2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Icewind Dale II/README.htm"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Icewind Dale II/" || exit 1
TITLE="$TITLE"

POL_SetupWindow_Init

POL_Wine Config.exe

POL_Call POL_Configurator_runparts

POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlLuUmsACgkQ5TH6yaoTykd8AQCgiVeD2YmuU1bslsa/Mdei2CT7
YqIAnRjj76ewqTo9HTfdRLN0m9/5/Yxt
=Zjzv
-----END PGP SIGNATURE-----
