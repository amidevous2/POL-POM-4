#!/bin/bash
# Date : (2012-10-17 11-33)
# Last revision : (2013-12-10 20-29)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="legacy_of_kain_soul_reaver_2"
PREFIX="LegacyOfKainSR2_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Legacy of Kain: Soul Reaver 2"
SHORTCUT_NAME="Legacy of Kain: Soul Reaver 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1434
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Crystal Dynamics / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "00bf351ced077237d68e2e5dcf45699f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "sr2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Legacy of Kain Soul Reaver 2/manual.pdf"
# C:\GOG Games\Legacy of Kain Soul Reaver 2\readme.rtf

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/Legacy of Kain Soul Reaver 2/" || exit 1

POL_Wine "sr2.exe" "-setup"
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKnhtAACgkQ5TH6yaoTykdMhQCdH7xBluJzLGfriS8SmNKhyUhU
c7cAnjCP9cOl2ySXz5O4u+Ey5F9qgv9A
=1yVc
-----END PGP SIGNATURE-----
