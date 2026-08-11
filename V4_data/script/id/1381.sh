#!/bin/bash
# Date : (2012-08-25 18-58)
# Last revision : 
# Wine version used :
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-08-25 18-58)
#   Initial script.
# [Pierre Etchemaite]  (2013-11-27 23-32)
#   ?
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.4.1 (outdated) -> 3.0.3


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="unreal_2_the_awakening_se"
PREFIX="Unreal2_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Unreal 2"
SHORTCUT_NAME="Unreal 2: The Awakening"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1381
# 4.0.15 needed for complex POL_Shortcut_InsertBeforeWine
POL_RequiredVersion "4.0.15" || POL_Debug_Fatal "$APPLICATION_TITLE 4.0.15 is required to install $TITLE"
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Epic Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "3b157d88da108e4cea15b1d35ff06c5a"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Wine_DirectInput "MouseWarpOverride" "force"

POL_Call POL_Install_directmusic
# Only keep dmband, dmloader and dmscript
POL_Wine_OverrideDLL "builtin" devevum dmcompos dmime dmstyle dmsynth dmusic dmusic32 dswave quartz streamci

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Unreal2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'taskset -pc 0 $$'
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Unreal 2 – The Awakening Special Edition/Help/Manual.pdf"
# C:\GOG Games\Unreal 2 – The Awakening Special EditionE\Help\Readme.txt

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxFKgAKCRDlMfrJqhPK
R5DAAKCyaSN7AzCuNrwmIC6aA7rrW8LpNQCdGJaAuTecvxD481nQnzegfYu7a2s=
=//E7
-----END PGP SIGNATURE-----
