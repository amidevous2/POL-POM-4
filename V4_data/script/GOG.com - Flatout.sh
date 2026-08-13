#!/bin/bash
# Date : (2011-12-17 21-03)
# Last revision : (2013-11-24 19-55)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="flatout"
PREFIX="Flatout_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Flatout"
SHORTCUT_NAME="Flatout"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1010
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bugbear Entertainment / Strategy First" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "9958bac2f96c9c8ea72ccef6d8eac95e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "flatout.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;SportsGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/FlatOut/manual.pdf"

# I'd like to automate it (Savegames/device.cfg, byte #148 set to 0), but
# config file is only created after the game is started once.
POL_SetupWindow_message "$(eval_gettext 'Think about disabling triple-buffering in settings,\nas it is not fully supported by Wine yet.')" "$TITLE"

# Crashes upon first run, GOG's Safedisc workaround doesn't seem to work perfectly under Wine
[ -e "$WINEPREFIX/drive_c/windows/system32/drivers/SECDRV.SYS" ] || \
  POL_Wine --ignore-errors "$GOGROOT/FlatOut/flatout.exe" "-setup"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG=""

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/FlatOut/" || exit 1

POL_Wine "flatout.exe" "-setup"

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKSVBkACgkQ5TH6yaoTykfrNACgjrRlWt/Sz32V0fsFHWiYVp3p
ndMAoKZPRPcylnCwEVJoNZq/v45e2lDj
=QPX/
-----END PGP SIGNATURE-----
