#!/bin/bash
# Date : (2013-01-07 23-32)
# Last revision : (2013-11-01 17-33)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="original_war"
PREFIX="OriginalWar_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Original War"
SHORTCUT_NAME="Original War"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1531
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Altar Interactive / Bohemia Interactive Studio" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "f211bbd7c645620317cd7ecac9e73a3c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Screen can be scrolled by moving the mouse to the borders
POL_Wine_X11Drv "GrabFullScreen" "Y"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Owar.exe" "$SHORTCUT_NAME" "" "" "Game;StrategyGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Original War/Manual.pdf"
# C:\GOG Games\Original War\readme.txt
# C:\GOG Games\Original War\Help\English\Index.htm
# C:\GOG Games\Original War\OwarDedicated.exe
# C:\GOG Games\Original War\GM_Editor.exe
# C:\GOG Games\Original War\gm_view.exe
# C:\GOG Games\Original War\grndsec.exe
# C:\GOG Games\Original War\PRCiX.exe
# C:\GOG Games\Original War\PakView.exe
# C:\GOG Games\Original War\OWP_Validator.exe
# C:\GOG Games\Original War\XichtEd.exe
# C:\GOG Games\Original War\ow_editor.exe
# C:\GOG Games\Original War\Utils\TitleCreator\Titulky.exe
# C:\GOG Games\Original War\ModLauncher.exe
# C:\GOG Games\Original War\Utils\MMSC\Meaaov_ModSetupCompiler.exe

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJz5KsACgkQ5TH6yaoTykcqgwCfXAb2w7f/ecn729UQAfCUajWV
+CsAn1lQvbRp+3q2WisqhUskWS51yyHj
=Nnkj
-----END PGP SIGNATURE-----
