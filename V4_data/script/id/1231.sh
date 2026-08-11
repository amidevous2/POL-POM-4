#!/bin/bash
# Date : (2012-05-22 21-29)
# Last revision : (2014-05-17 22-09)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="duke_nukem_manhattan_project"
PREFIX="DukeNukemMP_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Duke Nukem: Manhattan Project"
SHORTCUT_NAME="Duke Nukem: Manhattan Project"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1231
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "3D Realms Entertainment / Apogee Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "8558b2058ba51fc08fa39ea2dbbe5f0e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "DukeNukemMP.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Duke Nukem - Manhattan Project/manual.pdf"
# C:\GOG Games\Duke Nukem - Manhattan Project/Readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Duke Nukem - Manhattan Project/" || exit 1

TITLE="$TITLE"

POL_Wine DukeNukemMP.exe show

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlN30AcACgkQ5TH6yaoTykeLnwCgp6GHsjRYq+iP9/p2oAu/nVEb
fwIAoIVp+kAmAjQksYxZAdWhYOGT5tMb
=rbKg
-----END PGP SIGNATURE-----
