#!/bin/bash
# Date : (2011-12-23 23-13)
# Last revision : (2014-02-08 18-22)
# Wine version used : 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="divine_divinity"
PREFIX="DivineDivinity_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Divine Divinity"
SHORTCUT_NAME="Divine Divinity"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1025
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Larian Studios" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "3798d48f04a7a8444fd9f4c32b75b41d"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "div.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Divine Divinity/manual.pdf"
# C:\GOG Games\Divine Divinity\ReadMe.txt
# C:\GOG Games\Divine Divinity\story.pdf

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG=""

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Divine Divinity/" || exit 1

POL_Wine configtool.exe

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlL3fEQACgkQ5TH6yaoTykdRwgCaA7Ps/H3+48FUZvLGXBjPf74M
m6AAnRJhzR+YOc5jl0a4UXmlsZQjQ6Fl
=oV84
-----END PGP SIGNATURE-----
