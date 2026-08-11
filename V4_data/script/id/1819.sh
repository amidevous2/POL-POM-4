#!/bin/bash
# Date : (2013-04-01)
# Last Revision : see changelog
# Wine version used : 4.21
# Distribution used to test : Debian Wheezy (Testing repositories)
# Author : VisitntX visitntx@gmail.com
#   Updated : petch
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# TESTED Editions: GOG v2.1.0.7 .
#
# Middlewares used by this software : DirectX 6.
#
# CHANGELOG
# [VisitntX] (2013-04-01)
#   Initial script.
# [petch] (2013-11-23 02:44)
#   ? 
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.4.1 -> 2.22
# [Dadu042] (2020-01-21 10:50) (Ubuntu 19.04 64b)
#   Wine 2.22 -> 4.21.
#
#
#
# KNOWN ISSUES:
#  - Wine amd64 4.21: The game crash the first time launched (ie: no intro, text on the second menu screen is hidden).
#  - Wine amd64 4.0.3, 4.21: crash (error message) when the game does exit.
#
# KNOWN ISSUES FIXED:
#  - Wine amd64 2.22: mouse cursor appear over the game. Fix: Wine 3.0.3, 4.21
#  - Wine amd64 2.22, 3.0.3, 3.20, 4.0.3: makes huge log file (err:ddraw:d3d_device3_GetRenderState Unexpected texture stage state setup, returning D3DTBLEND_MODULATE - likely erroneous.). Related to ?: https://bugs.winehq.org/show_bug.cgi?id=36696  Fix: Wine 4.21

  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="shogo_mobile_armor_division"
PREFIX="ShogoMobileArmorDivision_gog"
WORKING_WINE_VERSION="4.21"
 
TITLE="GOG.com - Shogo: Mobile Armor Division"
SHORTCUT_NAME="Shogo: Mobile Armor Division"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1819
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Monolith Productions / Interplay" "http://www.gog.com/en/gamecard/$GOGID" "VisitntX" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Call POL_GoG_setup "$GOGID" "ffb5e64a67fa6522013472e76738289a"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe"
 
POL_Call POL_GoG_install
 
# Setting Windows Version
Set_OS winxp
 
# Cleaning Wine by rebooting
POL_Wine_reboot
 
POL_Shortcut "Shogo.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Shogo - Mobile Armor Division/MANUAL.PDF"
# C:\GOG Games\Shogo - Mobile Armor Division\readme.txt
# C:\GOG Games\Shogo - Mobile Armor Division\shogo.hlp
# C:\GOG Games\Shogo - Mobile Armor Division\RefCard.pdf
 
POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXibfDgAKCRDlMfrJqhPK
R6BWAJsEFlf69kNQ9HmlIN5E0tXIaW10TQCggBEfhQ+s4GVJGYJvLlmOJ1EIM4Y=
=DtN2
-----END PGP SIGNATURE-----
