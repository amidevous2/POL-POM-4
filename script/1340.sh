#!/bin/bash
# Date : (2012-08-01 03-19)
# Last revision : (2013-12-15 00-07)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="psychonauts"
PREFIX="Psychonauts_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Psychonauts"
SHORTCUT_NAME="Psychonauts"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1340
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Double Fine Productions" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 3 "7b7edc2b387ec950bc40c18d686b72f0" "3ebb44d2e0500ad2262965a7945b956f" "34fc9227a6b07ef9d6ae451a25822f2c" "f2674a4aed415d2ebc835595cf7cb74c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install /nogui


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Psychonauts.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Psychonauts/Psychonauts Manual Win.pdf"
# C:\GOG Games\Psychonauts\ReadMe.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/Psychonauts/" || exit 1
TITLE="$TITLE"

POL_Wine "Language Setup.exe"
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKtc3kACgkQ5TH6yaoTykdtSgCfS/ThY0f2dj+f3fLFji3zBgak
rp4An18hYsFQHRLBp9fie9exRtnzSJg6
=/M4e
-----END PGP SIGNATURE-----
