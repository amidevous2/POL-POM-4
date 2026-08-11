#!/usr/bin/env bash
# Date conv:yy-mm-dd
# Date : (2017-06-17)
# Last revision : see changelog
# Wine version used : -
# Distribution used to test : -
# Author : Kukulo, ImperatorS79, Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Kukulo] (2017-06-17)
#   First script.
# [ImperatorS79] (2017-06-19)
#   ?
# [Dadu042] (2019-11-30)
#   Wine 2.10-staging -> 2.22
#   Add shortcut category.
#   Add POL_RequiredVersion 4.0.0
#   Can install patch.
   
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
 
WINE_VERSION="2.22"
TITLE="Star Wars Empire at War Gold Pack - gog.com"
AUTOR="Kukulo"
GAME_URL="https://en.wikipedia.org/wiki/Star_Wars:_Empire_at_War"
EDITOR="LucasArts"
GAME_VMS="64"
 
#POL_GetSetupImages "undefined" "undefine" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTOR" "SWEAWGP"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "SWEAWGP"
 
POL_Wine_PrefixCreate "$WINE_VERSION"
 
POL_Call POL_Install_corefonts
POL_Call POL_Install_d3dx9 

# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

POL_SetupWindow_VMS "$GAME_VMS"
 
POL_SetupWindow_InstallMethod "LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the install file.')" "$TITLE"
    SETUP_PATH="$APP_ANSWER"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$SETUP_PATH"
fi

POL_Wine_WaitExit "$TITLE"
 
POL_Shortcut "sweaw.exe" "Star Wars Empire at War" "" "" "Game;"
POL_Shortcut "swfoc.exe" "Star Wars Empire at War Forces of Corruption" "" "" "Game;"

################
# Patch update #
################
   
POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ?\n (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
     
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgsX0QAKCRDlMfrJqhPK
R18oAKCZQIwBbCdo1iaC5ArLCzvDPLbTNwCfVRQxbrP/JXF5coKivmBM+aMD0oc=
=MMp3
-----END PGP SIGNATURE-----
