#!/bin/bash
# Date : (2012-12-17 22-36)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# CHANGELOG
# [Pierre Etchemaite] (2012-12-17 22-36)
#   Initial script.
# [Pierre Etchemaite] (2013-11-24 09-50)
#   ?
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="hitman_2_silent_assassin"
PREFIX="Hitman2SA_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Hitman 2: Silent Assassin"
SHORTCUT_NAME="Hitman 2: Silent Assassin"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1516
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "IO Interactive / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a7e5d8d363db2150f30835ffe1fa0e92"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Disable environmental bump mapping
# Looks like "copper" reflections under Wine (1.5.19)
printf "DisableEMBM 1\r\n" >> "$GOGROOT/Hitman 2 Silent Assassin/Hitman2.ini"

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "hitman2.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Hitman 2 Silent Assassin/manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Hitman 2 Silent Assassin/" || exit 1
TITLE="$TITLE"

POL_Wine config.exe
exit 0
_EOF_

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiWAEgAKCRDlMfrJqhPK
R67UAJ9AsjJGwmTjH3e8lffDz0FIl2Y02ACggEaMbdlqCD8i1d0QI4ndXKKgwZY=
=4YNh
-----END PGP SIGNATURE-----
