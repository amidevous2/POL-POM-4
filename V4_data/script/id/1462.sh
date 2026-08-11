#!/bin/bash
# Date : (2012-11-08 21-42)
# Last revision : (2013-04-18 07-21)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="legacy_of_kain_defiance"
PREFIX="LegacyOfKainD_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Legacy of Kain: Defiance"
SHORTCUT_NAME="Legacy of Kain: Defiance"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1462
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Crystal Dynamics / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "3ea952edef8cdaf872bbcb9db3b87728"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "defiance.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Legacy of Kain Defiance/manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/Legacy of Kain Defiance/" || exit 1
TITLE="$TITLE"

POL_Wine defiance.exe -setup
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHoK1YACgkQ5TH6yaoTykdrHQCeIiBqn+cORMWgl66UWDmevX8D
o1wAoIyMOREifP/6TtPZROa8Zrot+swN
=QZSY
-----END PGP SIGNATURE-----
