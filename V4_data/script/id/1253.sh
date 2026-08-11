#!/bin/bash
# Date : (2012-06-10 20-41)
# Last revision : (2014-02-15 14-16)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-10 20-41)
#   Initial script, for the GOG release.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.6.2 -> 2.22
#   Add VMS REQ: 4 -> 64 MB.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="planescape_torment"
PREFIX="PlanescapeTorment_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Planescape: Torment"
SHORTCUT_NAME="Planescape: Torment"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1253
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Black Isle Studios / Hasbro Inc." "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a6e2879e10d49f29a5d70e2eee4093e2"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

# "Fixed" version gives mouse cursor trails under Wine
cd "$GOGROOT/Planescape Torment" || POL_Debug_Fatal "Game not installed in standard path?"
POL_Wine setup-ddrawfix.exe --uninstall
rm -r setup-ddrawfix.exe ddrawfix

POL_Shortcut "Torment.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Planescape Torment/manual.pdf"
# C:\GOG Games\Planescape Torment\Readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Planescape Torment/" || exit 1

TITLE="$TITLE"

POL_SetupWindow_Init

POL_Call POL_Configurator_runparts

POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwwQAAKCRDlMfrJqhPK
R4YJAJ0esPzMD9iQF6H6yx60Xt5Er7GINgCfXWKETUFbetOoWp4t5Pebtr9FlQ4=
=qRpB
-----END PGP SIGNATURE-----
