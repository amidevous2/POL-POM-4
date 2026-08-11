#!/bin/bash
# Date : (2012-12-31 17-33)
# Last revision : 
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-12-31 17-33)
#   Initial script.
# [Pierre Etchemaite] (2014-06-29 22-58)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.6.2 (outdated) -> system.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="return_to_mysterious_island"
PREFIX="ReturnToMysteriousIsland_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Return to Mysterious Island"
SHORTCUT_NAME="Return to Mysterious Island"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1524
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Kheops Studio / Anuman Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "752f07d6609423926605671f4b6a9e35"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

# Disable hardware acceleration (disappeared UI components)
sed -i.bak -e 's/^bUseHardware=1/bUseHardware=0/' "$GOGROOT/Return to Mysterious Island/config.ini"

POL_Shortcut "RtMI.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Return to Mysterious Island/RTMI_Manual_EN.pdf"
# C:\GOG Games\Return to Mysterious Island\[EN] ReadMe.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "$GOGROOT/Return to Mysterious Island/" || exit 1
TITLE="$TITLE"

POL_Wine Language.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCmkAAKCRDlMfrJqhPK
R3PtAJ9YpT7QkaOEEK8H6vNNuyeO2m1EVgCfcoyen3gfW9QT5NZctSVMyYfrRRw=
=dYNJ
-----END PGP SIGNATURE-----
