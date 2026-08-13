#!/bin/bash
# Date : (2012-05-02 11-46)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-02 11-46)
#   Initial script.
# [Pierre Etchemaite] (2014-02-27 22-17)
#   1.4.1, 1.5.3, 1.6.2
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.6.2 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="anachronox"
PREFIX="Anachronox_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Anachronox"
SHORTCUT_NAME="Anachronox"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1159
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ion Storm Inc. / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a9e148972e51a4980a2531d12a85dfc0"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Used by GCT Setup
POL_Call POL_Install_vbrun6

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "anox.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Anachronox/manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Anachronox/" || exit 1

TITLE="$TITLE"

POL_Wine "GCT Setup.exe"

POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYbuwAKCRDlMfrJqhPK
Rz5dAJ9HsCo6Iiqd+WZ2KKI1a3+SPDAluQCfY+g9wZg3jooFWCPWlh9cihcp7ZA=
=PT7x
-----END PGP SIGNATURE-----
