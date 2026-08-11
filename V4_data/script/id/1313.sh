#!/bin/bash
# Date : (2012-07-14 20-19)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-07-14 20-19)
#   Initial script.
# [Pierre Etchemaite] (2013-07-10 13-40)
#   Script updated for GOG's installer v2 ?.
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="space_rangers_2_reboot"
PREFIX="SpaceRangers2_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Space Rangers 2: Reboot"
SHORTCUT_NAME="Space Rangers 2: Reboot"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1313
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Elemental Games / 1C Publishing" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "90b36e2d043d3fdd6d1603b7f22f85ca"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Fix ground battle initialization crash for me
POL_Call POL_Install_d3dx9

# Fix internal help
POL_Call POL_Install_ie6

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Rangers.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/Space Rangers 2 - Reboot/manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"
POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/\$PROGRAMFILES/GOG.com/Space Rangers 2 - Reboot/" || exit 1
TITLE="$TITLE"
POL_Wine setup.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpyDQQAKCRDlMfrJqhPK
R71rAJsE881hXddCaXyRDf8k13jrXI890ACfUpbaWCWSPHLiBlE9zwxEcgLELQA=
=5bZq
-----END PGP SIGNATURE-----
