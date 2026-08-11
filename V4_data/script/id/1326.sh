#!/bin/bash
# Date : (2012-07-20 01-46)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# CHANGELOG
# [Pierre Etchemaite] (2012-07-20 01-46)
#   First script. Wine 1.7.55.
# [Pierre Etchemaite] (2013-11-26 23-02)
#   ?
# [Dadu042] (2019-12-30)
#   Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="disciples_2_gold"
PREFIX="Disciples2Gold_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Disciples 2 Gold"
SHORTCUT_NAME1="Disciples 2: Dark Prophecy and Gallean's Return"
SHORTCUT_NAME2="Disciples 2: Rise of the Elves"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1326
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Strategy First" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "665091a9385687b91702f17cc6392ec7"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS "winxp"

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "GOG Games/Disciples 2 Gold/Disciples 2 - Dark Prophecy and Gallean's Return/Discipl2.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Disciples 2 Gold/Disciples 2 - Dark Prophecy and Gallean's Return/manual.pdf"
# C:\GOG Games\Disciples 2 Gold\Disciples 2 - Dark Prophecy and Gallean's Return\ScenEdit.exe
# C:\GOG Games\Disciples 2 Gold\Disciples 2 - Dark Prophecy and Gallean's Return\Readme.txt

POL_Shortcut "GOG Games/Disciples 2 Gold/Disciples 2 - Rise of the Elves/Discipl2.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Disciples 2 Gold/Disciples 2 - Rise of the Elves/manual addon.pdf"
# C:\GOG Games\Disciples 2 Gold\Disciples 2 - Rise of the Elves\ScenEdit.exe
# C:\GOG Games\Disciples 2 Gold\Disciples 2 - Rise of the Elves\Readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME1"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Disciples 2 Gold/Disciples 2 - Dark Prophecy and Gallean's Return/" || exit 1
TITLE="$TITLE"
POL_Wine ConfigEditor.exe
exit 0
_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME2"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Disciples 2 Gold/Disciples 2 - Rise of the Elves/" || exit 1
TITLE="$TITLE"
POL_Wine ConfigEditor.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgs2lwAKCRDlMfrJqhPK
RyinAJ9WWfDaV4hERVXGIoBdKYmELd1lmgCcDZomTqheQduuHLfBf1mJW0Xgy/Q=
=pJXN
-----END PGP SIGNATURE-----
