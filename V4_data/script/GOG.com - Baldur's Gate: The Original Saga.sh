#!/bin/bash
# Date : (2012-05-10 17-58)
# Last revision : see changelog
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-10 17-58)
#   Initial script.
# [Pierre Etchemaite] (2014-02-01 17-44)
#   ? Wine 1.4.1 -> 1.6.2 ?
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.6.2 -> 3.0.3
 

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="baldurs_gate_the_original_saga"
PREFIX="BaldursGate1_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Baldur's Gate: The Original Saga"
SHORTCUT_NAME="Baldur's Gate"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/BG1/top.jpg" "http://files.playonlinux.com/resources/setups/BG1/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1179
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bioware / Hasbro Inc." "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "99cf29eae93dc4de4b1dd219b4bccce0"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

POL_Wine_X11Drv "GrabFullScreen" "Y"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Baldur.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Baldur's Gate/MANUAL.PDF"
# C:\GOG Games\Baldur's Gate\Readme.txt
# C:\GOG Games\Baldur's Gate\MAP.pdf
# C:\GOG Games\Baldur's Gate\MANUAL_addon.PDF
# C:\GOG Games\Baldur's Gate\Readme_totsc.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Baldur's Gate/" || exit 1

TITLE="$TITLE"

POL_SetupWindow_Init

POL_Wine Config.exe
POL_Call POL_Configurator_runparts

POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYlvQAKCRDlMfrJqhPK
R85oAKCA+ERJ5eNOYDMFN2mZQrA5KtNkOwCfZtXDVnI0NxHdVxWsCpYs+EA0VPs=
=CJx2
-----END PGP SIGNATURE-----
