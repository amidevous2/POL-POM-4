#!/bin/bash
# Date : (2012-11-27 00-14)
# Last revision : 
# Wine version used : 1.4.1
# Distribution used to test : Slackware 14.0, Debian Sid (Unstable)
# Author : ... (Based on Gemini Rue script by Pierre Etchemaite)
#    Updates by Pierre Etchemaite
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-11-27 00-14)
#   Initial script.
# [Pierre Etchemaite] (2013-11-03 20-33)
#   Script updated for GOG's installer v2 ?.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.4.1 (outdated) -> system

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="resonance"
PREFIX="Resonance_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Resonance"
SHORTCUT_NAME="Resonance"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1487
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Wadjet Eye Games" "http://www.gog.com/gamecard/$GOGID" "....." "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "efa958a7518cda9af68f8d452c09f3e5"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Resonance.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Resonance/README.txt"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Resonance/" || exit 1
TITLE="$TITLE"
POL_Wine winsetup.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqClJwAKCRDlMfrJqhPK
R+1dAKClqcKkIhcg7IPDgV/tm6581Z+LvwCfSNKAMEFUcpwBYul/16khUhTny4k=
=NLp0
-----END PGP SIGNATURE-----
