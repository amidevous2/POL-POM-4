#!/bin/bash
# Date : (2012-04-09 13-47)
# Last revision : (2013-05-14 20-39)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="prince_of_persia_the_sands_of_time"
PREFIX="SandsOfTime_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Prince of Persia: The Sands of Time"
SHORTCUT_NAME="Prince of Persia: The Sands of Time"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1119
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "1f0694e57f09c8b45e6c94023203ef0b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "PrinceOfPersia.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/Prince of Persia The Sands of Time/manual.pdf"
# C:\Program Files\GOG.com\Prince of Persia The Sands of Time\readme.txt

# Disable fog option by default
if type -t POL_unbase64 > /dev/null; then
	POL_unbase64 <<-_EOF_ > "$GOGROOT/Prince of Persia The Sands of Time/Profiles/DefaultProfile.DAT"
	UE9QNEQAZQBmAGEAdQBsAHQAAAAhOFn3sPoCAAAAUgAAAFSwDt0AASADAABYAgAAIAAAAAEAAAAA
	AAAAAgAAAAIAAAACAAAAAgAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAA
	AAABAAAABAAAABoAAABSzYhDAAEAAIA/AACAPwAAgD8BAAAAAAAAAAAAAAA=
	_EOF_
else
	POL_SetupWindow_message "$(eval_gettext 'If you can barely distinguish a landscape behind main menu,\ndisable FOG in graphic options.')" "$TITLE"
fi

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGSiegACgkQ5TH6yaoTykdvYQCeJGoLhQsK2RlVhqh1qqVE8wXZ
FfEAoI0BGXyd1oKj3EHhtyjfs3zhJj3Y
=qvdc
-----END PGP SIGNATURE-----
