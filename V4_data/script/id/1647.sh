#!/bin/bash
# Date : (2013-04-07 16-50)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-04-07 16-50)
#   Initial script, for the GOG release.
# [Pierre Etchemaite] (2013-07-10 13-36)
#   ?
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.5.27 -> 3.0.3
#   Force Arch x86.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="neverwinter_nights_2_complete"
PREFIX="NeverwinterNights2_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Neverwinter Nights 2: Complete"
SHORTCUT_NAME="Neverwinter Nights 2 Complete"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1647
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Studio / Publisher" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "6f64b0b2401564c4cde3ffbfa1bf1022" "7f0c309d426605ef12d6b650c1583b41" "5741d78d70a275b61ae5c6b46e0e5030" "922ed380f399e7c4da4b00a29c154593" "83294db2aee174c05dc436b39e2c00d1" "eb66b074d1b14946511eed344abc4bec"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


POL_Call POL_Install_d3dx9
POL_Call POL_Install_dxdiag

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "256"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "nwn2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Neverwinter Nights 2 Complete/Documentation/Neverwinter Nights 2 - Manual.pdf"
# C:\GOG Games\Neverwinter Nights 2 Complete\Documentation\Neverwinter Nights 2 Mask of the Betrayer - Manual.pdf
# C:\GOG Games\Neverwinter Nights 2 Complete\Documentation\Neverwinter Nights 2 Mysteries of Westgate - Walkthrough.pdf
# C:\GOG Games\Neverwinter Nights 2 Complete\Documentation\Neverwinter Nights 2 Storm of Zehir - Manual.pdf

POL_SetupWindow_Close

exit 0

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Neverwinter Nights 2 Complete/" || exit 1
TITLE="$TITLE"

POL_Wine SerialTool.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwtegAKCRDlMfrJqhPK
Rw+qAJoDLWbaBOZjAs8dUclWvy/8HSPtqACdFTsGOVS8U4VF7FKR+9MBqd2lCWI=
=Fr8Q
-----END PGP SIGNATURE-----
