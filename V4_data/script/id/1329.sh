#!/bin/bash
# Date : (2012-07-21 20-58)
# Last revision : (2014-02-16 20-35)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="gemini_rue"
PREFIX="GeminiRue_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Gemini Rue"
SHORTCUT_NAME="Gemini Rue"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1329
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Wadjet Eye Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "1f4514f09d96e7af299ce1e8a5680eab"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Gemini Rue.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Gemini Rue/" || exit 1
TITLE="$TITLE"
POL_Wine winsetup.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMH7zcACgkQ5TH6yaoTykd2JACgnDEaxQBypg8pjpXoVP9U5hur
U8IAnROsgnJH9OjzC+YQy0duS0zI6bsu
=fKfV
-----END PGP SIGNATURE-----
