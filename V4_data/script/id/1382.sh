#!/bin/bash
# Date : (2012-08-29 21-13)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-08-29 21-13)
#   Initial script
# [Pierre Etchemaite] (2014-11-02 20-41)
#   Wine 1.6.2
# [Dadu042] (2020-04-08 13:30).
#   Wine 1.6.2 (outdated) -> 3.0.3


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="far_cry_2_fortunes_edition"
PREFIX="FarCry2_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Far Cry 2"
SHORTCUT_NAME="Far Cry 2: Fortune's Edition"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1382
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft Montréal / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "77874c0184213f9c9a64c94c36d6632e" "c4d6b6a19c563cbc309ec35041659078" "8eb725b44a5a87e9ced068f913cbe3a3"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_d3dx9_36

POL_Call POL_GoG_install /nogui


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "256"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "farcry2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Far Cry 2 Fortune's Edition/manual.pdf"
# C:\GOG Games\Far Cry 2 Fortune's Edition\ReadMe.txt
# C:\GOG Games\Far Cry 2 Fortune's Edition\bin\FC2Editor.exe
# C:\GOG Games\Far Cry 2 Fortune's Edition\bin\FC2BenchmarkTool.exe
# C:\GOG Games\Far Cry 2 Fortune's Edition\bin\FC2ServerLauncher.exe

POL_SetupWindow_Close

# Run Failsafe as configurator
cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Far Cry 2 Fortune's Edition/bin" || exit 1
TITLE="$TITLE"
POL_Wine farcry2.exe -RenderProfile_ResolutionX 640 -RenderProfile_ResolutionY 480 -RenderProfile_RefreshRate 0
exit 0
_EOF_

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXo8OJwAKCRDlMfrJqhPK
R5xCAJwOaltb/7Rg3nSruIm6b6GS/96UYwCgl2ZV4tHZnzAIyXqjz2mxTwsHLvU=
=GyRj
-----END PGP SIGNATURE-----
