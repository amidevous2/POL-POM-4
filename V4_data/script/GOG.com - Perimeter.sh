#!/bin/bash
# Date : (2012-12-09 22-12)
# Last revision : (2013-07-10 13-37)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="perimeter"
PREFIX="Perimeter_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Perimeter"
SHORTCUT_NAME="Perimeter"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1510
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "K-D Lab Game Development / 1C Publishing" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "88aceecea4125baeced1d0618483f88c" "396910fa797e782f1307e6efc0dba591"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Perimeter.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Perimeter/MANUAL.pdf"
# C:\GOG Games\Perimeter\readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Perimeter/" || exit 1
TITLE="$TITLE"

POL_Wine config.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHdugYACgkQ5TH6yaoTykeOoACeJXgptCovrpFODrqHcC72e4fS
83MAnR+SJD2hNRPaOkQBcxvnEisf5yop
=Y/ty
-----END PGP SIGNATURE-----
