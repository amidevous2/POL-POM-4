#!/bin/bash
# Date : (2012-11-30 23-44)
# Last revision : (2014-02-08 17-25)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="lands_of_lore_3"
PREFIX="LandsOfLore3_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Lands of Lore 3"
SHORTCUT_NAME="Lands of Lore 3"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1497
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Westwood Studios / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "7db9595060006d7f9a4028564c406b5d" "0d117f92762ebe7928d0949c55049d20" "d89e487d0577ff50b287fe94977155cd"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "LOL3.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "-CD. -16MB -NO_ASSERTS" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Lands of Lore 3/Manual.pdf"
# C:\GOG Games\Lands of Lore 3\Keycard.pdf

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Lands of Lore 3/" || exit 1
TITLE="$TITLE"

POL_Wine nglide_config.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlL2XZIACgkQ5TH6yaoTykeUXgCePVa6JJtIVRNi7tPz4+yW7Ep/
jv0An1JuscEh61jC7y2zns8AvtfdcJpN
=BLQo
-----END PGP SIGNATURE-----
