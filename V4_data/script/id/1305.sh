#!/bin/bash
# Date : (2012-07-08 18-17)
# Last revision : (2013-11-24 20-59)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="postal_2_complete"
PREFIX="Postal2Complete_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Postal 2 Complete"
SHORTCUT_NAME1="Postal 2 Share the Pain"
SHORTCUT_NAME2="Postal 2 Apocalypse Weekend"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1305
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Running With Scissors" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "df254b8b64283c0365f68612d9fbb519"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Wine_DirectInput "MouseWarpOverride" "force"

# Doesn't hurt ;)
POL_Wine_reboot

# Oh joy, the game and the extension binaries share the same name!
POL_Shortcut "GOG Games/Postal 2 Share The Pain/System/Postal2.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Postal 2 Share The Pain/Manual.pdf"
# C:\GOG Games\Postal 2 Share The Pain\Help.htm
# C:\GOG Games\Postal 2 Share The Pain\System\UnrealEd.exe

POL_Shortcut "GOG Games/Postal 2 Share The Pain/ApocalypseWeekend/System/postal2.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Postal 2 Share The Pain/Apocalypse Weekend Manual.pdf"
# C:\GOG Games\Postal 2 Share The Pain\ApocalypseWeekend\System\UnrealEd.exe

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME1"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Postal 2 Share The Pain/System" || exit 1
TITLE="$TITLE"
POL_Wine Postal2.exe -safe
exit 0
_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME2"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Postal 2 Share The Pain/ApocalypseWeekend/System" || exit 1
TITLE="$TITLE"
POL_Wine postal2.exe -safe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKSbdIACgkQ5TH6yaoTykdGlACdGqY/OUS40hQH0JIkUubsUsDQ
4O8AnRtO3GudeAbQfm9yaFLUsvMY4IyZ
=JpBo
-----END PGP SIGNATURE-----
