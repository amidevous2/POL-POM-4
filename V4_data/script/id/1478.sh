#!/bin/bash
# Date : (2012-11-24 21:30)
# Last revision : 
# Wine version used : 1.5.5, 1.6.1, 1.7.8
# Distribution used to test : OpenSuSE 12.2 64-bit
# Author : hmdai (Based on Deponia DC script by Kweepeer)
#   Update: petch
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [hmdai (Based on Deponia DC script by Kweepeer)] (2012-11-24 21:30)
#   Initial script.
# [Pierre Etchemaite] (2014-02-22 03-02)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.7.8 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_dark_eye_chains_of_satinav"
PREFIX="TheDarkEyeChainofSatinav_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - The Dark Eye: Chain of Satinav"
SHORTCUT_NAME="The Dark Eye: Chain of Satinav"

POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1478
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Daedalic Entertainment" "http://www.gog.com/gamecard/$GOGID" "hmdai" "$PREFIX"
POL_Call POL_GoG_setup "$GOGID" "022a59739b9d7b16f036fb2fecd5bca2" "aa50ac1bf998b7d945f58b6104f58298" "6748d3208d3c59f91cce0de4e6e56af7" "4c1208642ea83d7dde6e90ac3ce885fb" "284a6c2e37897e44a69fac6f8c0971e0"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "satinav.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'unset SDL_AUDIODRIVER'

# Create a tmp directory for the game to create thumbnail image for save game
mkdir "$WINEPREFIX/drive_c/tmp"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/The Dark Eye - Chains of Satinav/" || exit 1

POL_Wine "VisionaireConfigurationTool.exe"
exit 0
_EOF_

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxQFgAKCRDlMfrJqhPK
R3CyAKCs6i3RX3fL8pd4uipqxRSPTaedTgCfYYfR6ylhkHO/+L16MlGvm2EyizY=
=ndyb
-----END PGP SIGNATURE-----
