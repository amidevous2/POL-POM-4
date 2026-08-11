#!/bin/bash
# Date : (2013-01-21 19-45)
# Last revision : 
# Wine version used : 1.5.8, 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Wine 1.4.1, 1.5.7: Unimplemented function msvcp90.dll.??0?$basic_ostringstream@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QAE@H@Z (after introduction)
# Wine 1.5.8: starts ok

#
# CHANGELOG
# [Pierre Etchemaite] (2013-01-21 19-45)
#   Initial script.
# [Pierre Etchemaite] (2013-12-22 15-12)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.6.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="interstate76"
PREFIX="Interstate76_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - The Interstate 76 Arsenal"
SHORTCUT_NAME1="Interstate '76"
SHORTCUT_NAME2="Interstate '76 Nitro Pack"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1550
# For POL_Wine_UpdateRegistryWinePair
POL_RequiredVersion "4.0.16" || POL_Debug_Fatal "$APPLICATION_TITLE 4.0.16 is required to install $TITLE"
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c0e8796f2b5ce44d6af46ccf35a8bd55"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


Set_OS winxp
POL_Wine_UpdateRegistryWinePair 'AppDefaults\i76.exe' "Version" "win98"
POL_Wine_UpdateRegistryWinePair 'AppDefaults\nitro.exe' "Version" "win98"

POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "i76.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Interstate 76 Arsenal/Interstate 76/Manual.pdf"

POL_Shortcut "nitro.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxPXQAKCRDlMfrJqhPK
R0mLAJ4515sdjnSQpS9ZymyapxBbL/7gGwCfeFtp9lyqvUW0EifRWF2r/8v6c+c=
=ILUB
-----END PGP SIGNATURE-----
