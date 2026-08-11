#!/bin/bash
# Date : (2012-10-09 19-57)
# Last revision : (2013-12-04 19-29)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="legacy_of_kain_soul_reaver"
PREFIX="LegacyOfKainSR_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Legacy of Kain: Soul Reaver"
SHORTCUT_NAME="Legacy of Kain: Soul Reaver"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1426
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Crystal Dynamics / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "bd1929ad6235846e221aefe931f80863"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# "SVGA 256 colors"?
POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "kain2.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Legacy of Kain Soul Reaver/Manual.pdf"
# C:\GOG Games\Legacy of Kain Soul Reaver\Patchv12_Readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/Legacy of Kain Soul Reaver/" || exit 1
TITLE="$TITLE"

POL_Wine kain2.exe -setup
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKffrQACgkQ5TH6yaoTykeplwCfWCxS0Cv2mVPsrNwNa2aCorry
E6oAnjtxddoRwAU1oG6rrcdMFbkB4MZH
=kWjE
-----END PGP SIGNATURE-----
