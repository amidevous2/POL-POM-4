#!/bin/bash
# Date : (2012-09-22 22-30)
# Last revision : (2013-11-11 17-10)
# Wine version used : 1.4.1, 1.5.13
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="wallace_gromits_grand_adventures"
PREFIX="WallaceAndGromitGA_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Wallace and Gromits Grand Adventures"
SHORTCUT_NAME1="Wallace and Gromit EP101: Fright of the Bumblebees"
SHORTCUT_NAME2="Wallace and Gromit EP102: The Last Resort"
SHORTCUT_NAME3="Wallace and Gromit EP103: Muzzled"
SHORTCUT_NAME4="Wallace and Gromit EP104: The Bogey Man"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1410
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Telltale Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "afac7e24f26073901727f6b6e3d4f94e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

POL_Call POL_Install_d3dx9_36

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "WallaceGromit101.exe" "$SHORTCUT_NAME1" "" "" "Game;AdventureGame;" # $SHORTCUT_NAME1.png
POL_Shortcut "WallaceGromit102.exe" "$SHORTCUT_NAME2" "" "" "Game;AdventureGame;" # $SHORTCUT_NAME2.png
POL_Shortcut "WallaceGromit103.exe" "$SHORTCUT_NAME3" "" "" "Game;AdventureGame;" # $SHORTCUT_NAME3.png
POL_Shortcut "WallaceGromit104.exe" "$SHORTCUT_NAME4" "" "" "Game;AdventureGame;" # $SHORTCUT_NAME4.png

POL_SetupWindow_Close

for SHORTCUT in "$SHORTCUT_NAME1" "$SHORTCUT_NAME2" "$SHORTCUT_NAME3" "$SHORTCUT_NAME4"; do
    cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Wallace and Gromit's Grand Adventures/" || exit 1

TITLE="$TITLE"
POL_Wine Language.exe
exit 0
_EOF_
done

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKBBA8ACgkQ5TH6yaoTyke7EQCeNYtiSBUXnNBDMKRa3pscSFQQ
GJoAn1o5Lajqe1etrGwFvaIKGAKtmURA
=RrH4
-----END PGP SIGNATURE-----
