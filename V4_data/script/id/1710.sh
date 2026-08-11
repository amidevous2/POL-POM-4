#!/bin/bash
# Date : (2013-05-23 18-00)
# Last revision : (2014-04-03 21-23)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Xubuntu 13.04
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="wizardry_8"
PREFIX="Wizardry8_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Wizardry 8"
SHORTCUT_NAME="Wizardry 8"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1710
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sir-Tech Software / Gamepot Inc." "http://www.gog.com/gamecard/wizardry_8" "Xodetaetl" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" "1" "10deb68474ef67ecd8bd414407ffbdf3"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# Needed for 3DSetup.exe, if anyone wants to use it
POL_Call POL_Install_mfc42

# Fix game quitting freeze by changing audio settings, makes it crash instead. :)
cat << _EOF_ > "$WINEPREFIX/drive_c/GOG Games/Wizardry 8/3DVideo.CFG"
Glide2x
800
600
16
RAD Game Tools RSX 3D Audio
_EOF_

# Preconfigure aspect ratio and no 3dfx splash screen
POL_System_TmpCreate "$PREFIX"
cat << _EOFREG_ > "$POL_System_TmpDir/settings.reg"
[HKEY_CURRENT_USER\\Software\\Zeus Software\\nGlide]
"Aspect"="1"
"Gamma"="5"
"Refresh"="0"
"Resolution"="1"
"Splash"="0"
"Vsync"="1"
_EOFREG_
POL_Wine regedit "$POL_System_TmpDir/settings.reg"
POL_System_TmpDelete

POL_Shortcut "Wiz8.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Wizardry 8/Wizardry 8 - Manual.pdf"
# C:\GOG Games\Wizardry 8\3DSetup.exe

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Wizardry 8/" || exit 1
TITLE="$TITLE"

POL_Wine nglide_config.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNTyysACgkQ5TH6yaoTykcALQCgkRWqbMwuBrRjnq+29AnNUfUY
k/IAn15tbUJuQmXVsT084mq5IHccJkr+
=cHtL
-----END PGP SIGNATURE-----
