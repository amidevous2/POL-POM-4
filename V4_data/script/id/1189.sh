#!/bin/bash
# Date : (2012-05-13 17-24)
# Last revision : (2014-02-01 20-49)
# Wine version used : 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# 1.3.27, 1.3.37, 1.4, 1.4.1, 1.5.0, 1.5.3, 1.5.4: intro videos sound stuttering
# 1.5.5, 1.5.7, 1.5.18: no intro videos stuttering

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="icewind_dale_complete"
PREFIX="IcewindDale_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Icewind Dale Complete"
SHORTCUT_NAME="Icewind Dale"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1189
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Black Isle Studios / Hasbro Inc." "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "b1395109232aac8d7f8455dad418b084"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# Prevent a lot of fixme:dplay:DP_IF_Receive in logs during game
POL_Call POL_Install_directplay

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "IDMain.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Icewind Dale Complete/Manual.PDF"
# C:\GOG Games\Icewind Dale Complete\readme.txt
# C:\GOG Games\Icewind Dale Complete\readme_addon.TXT
# C:\GOG Games\Icewind Dale Complete\readme_addon2.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Icewind Dale Complete/" || exit 1

TITLE="$TITLE"

POL_SetupWindow_Init

POL_Wine Config.exe

POL_Call POL_Configurator_runparts

POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlLtV0EACgkQ5TH6yaoTykdUiQCeNWfNaOkNdDMiOT1nFCYW7yO1
T9gAoIOOeijso56JRxkXTxeJqhxPmF58
=vvK9
-----END PGP SIGNATURE-----
