#!/bin/bash
# Date : (2012-05-20 18-43)
# Last revision : (2014-05-06 16-13)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="uru_complete_chronicles"
PREFIX="Uru_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Myst Uru Complete Chronicles"
SHORTCUT_NAME="Myst Uru Complete Chronicles"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1218
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Cyan Worlds" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "7ba23098724fde01404f05db41457021"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "UruExplorer.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Myst Uru Complete Chronicles/Manual.pdf"
# C:\GOG Games\Myst Uru Complete Chronicles\Readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Myst Uru Complete Chronicles/" || exit 1

TITLE="$TITLE"

POL_Wine UruSetup.exe

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNpHtYACgkQ5TH6yaoTykfZWACfR5edluQw0hbyyKOcJJRHKVBa
dRkAn0CWsee4zyla4GYtkC+wueFKi+oN
=cIPy
-----END PGP SIGNATURE-----
