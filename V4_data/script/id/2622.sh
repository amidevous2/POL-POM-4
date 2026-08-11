#!/bin/bash
# Date : (2015-09-28 71-06)          # Year-month-day hour-min
# Last revision : (2015-09-28 71-06)
# Wine version used : 1.7.51, 1.7.5
# Distribution used to test : Arch
# Author : Wabuo spam.wabuo@googlemail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="legend_of_grimrock_2"
PREFIX="LegendOfGrimrock_2_gog"
#WORKING_WINE_VERSION="1.7.51"

TITLE="GOG.com - Legend of Grimrock"
SHORTCUT_NAME="Legend of Grimrock 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2622
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Almost Human" "http://www.gog.com/gamecard/$GOGID" "Wabuo" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_message "$(eval_gettext 'At the end of the install progres there will appear few error messages; just ignore them!')"

POL_Call POL_GoG_install "/NOGUI /SILENT /SUPPRESSMSGBOXES"


POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_gdiplus
POL_Call POL_Install_vcrun2005

# GoG work!
Set_OS win7

POL_SetupWindow_VMS "256"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "grimrock2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Legend of Grimrock II/Legend of Grimrock 2 Manual.pdf"
# C:\GOG Games\Legend of Grimrock II/

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlYJc6wACgkQ5TH6yaoTykflqACaAj7ZOg/3blc9kULHYJZ3XVhN
MCAAn3XHHbigjRRn+VoBDWx4W3lNbvwb
=UtWw
-----END PGP SIGNATURE-----
