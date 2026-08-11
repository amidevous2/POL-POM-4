#!/bin/bash
# Date : (2012-07-29 16-18)
# Last revision : 
# Wine version used : 1.4.1, 1.6.2,
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-07-29 16-18)
#   Initial script.
# [Pierre Etchemaite]  (2014-07-06 16-22)
#   ?
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="unreal_gold"
PREFIX="UnrealGold_gog"
WORKING_WINE_VERSION="3.0.3"
PATCH_ARCHIVE="OMP-UGOLD-V0.2.zip"

TITLE="GOG.com - Unreal Gold"
SHORTCUT_NAME="Unreal Gold"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1335
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Epic Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e19566e9bbda7029efcc179b8dd39d61"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


cd "$POL_USER_ROOT/tmp" || POL_Debug_Fatal "Can't find temp directory!"

# Update and enable OpenGL driver
# Taken from http://www.oldunreal.com/specialpatches.html
POL_Download "http://files.playonlinux.com/$PATCH_ARCHIVE" "455dc59d939cff53cf3c28b9d7dbc87d"

POL_System_ExtractSingleFile "$PATCH_ARCHIVE" "OpenGLDrv.dll" "$GOGROOT/Unreal Gold/System/OpenGlDrv.dll"
POL_System_ExtractSingleFile "$PATCH_ARCHIVE" "OpenGlDrv.int" "$GOGROOT/Unreal Gold/System/OpenGlDrv.int"
POL_System_ExtractSingleFile "$PATCH_ARCHIVE" "Unreal.exe" "$GOGROOT/Unreal Gold/System/Unreal.exe"
POL_System_ExtractSingleFile "$PATCH_ARCHIVE" "UCC.exe" "$GOGROOT/Unreal Gold/System/UCC.exe"
POL_System_ExtractSingleFile "$PATCH_ARCHIVE" "Setup.exe" "$GOGROOT/Unreal Gold/System/Setup.exe"
#perl -i.bak -pe 's/^GameRenderDevice=[0-9A-Za-z.]*/GameRenderDevice=OpenGLDrv.OpenGLRenderDevice/' "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/Unreal Gold/System/Unreal.ini"

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Unreal.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Unreal Gold/Manual/Manual.pdf"
# C:\GOG Games\Unreal Gold\Help\ReadMe.txt

# C:\GOG Games\Unread Gold\System\UnrealEd.exe

POL_SetupWindow_message "$(eval_gettext 'On first run the game will autodetect available renderers.\nIt is likely that you will get better performance out of the OpenGL renderer.')" "$TITLE"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxFsAAKCRDlMfrJqhPK
R1TDAJ9UNRPMalTkeVnYLn6H14AzmckdOACfU8mEKo8t2OSuxNu1NYTm72WJlF4=
=DVqB
-----END PGP SIGNATURE-----
