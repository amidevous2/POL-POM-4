#!/usr/bin/env playonlinux-bash
# Date : (2014-07-14 17-00)
# Distribution used to test : Mac OS
# Author : Quentin PARIS
# Only For : http://www.playonlinux.com

#
# CHANGELOG
# [Quentin PARIS] (2014-07-14 17-00)
#   Initial script (Wine 1.7.21).
# [Dadu042] (2020-03-22 12:30).
#   Wine 2.12-staging (outdated) -> 3.0.3
#   POL_Shortcut improved.
#   POL_RequiredVersion added (currently useless).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Age Of Empire II - HD"
PREFIX="AOE2HD"
STEAM_ID="221380"
EDITOR="Microsoft"
AUTHOR="Quentin PARIS"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="512"
  
POL_SetupWindow_Init
POL_SetupWindow_SetID 2167
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
 
  
POL_Call POL_Install_vcrun2012
POL_SetupWindow_InstallMethod STEAM
 
POL_Wine_SetVideoDriver
POL_SetupWindow_VMS $GAME_VMS
  
POL_Wine_Direct3D "UseGLSL" "enabled"
POL_Wine_Direct3D "DirectDrawRenderer" "opengl"
POL_Wine_Direct3D "StrictDrawOrdering" "disabled"
POL_Wine_OverrideDLL "" "gameoverlayrenderer"
 
if [ "$INSTALL_METHOD" = "STEAM" ]; then
    POL_Call POL_Install_steam
    POL_Call POL_Install_steam_flags "$STEAM_ID"
    POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID -nostartup"
 
    POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine start /unix "Steam.exe" "steam://install/$STEAM_ID"
    POL_Wine_WaitExit "$TITLE"
 
fi
 
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
     
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$SETUP_EXE"
    POL_Wine_WaitExit "$TITLE"
     
    POL_Shortcut "AoK HD.exe" "$TITLE" "" "-nostartup" "Game;"
fi
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXneHIQAKCRDlMfrJqhPK
R/A1AKCOCIsxWwQrsxvYw//+alhOwvISzACggvXksdGhUPZOfB6k2biGla6VvdM=
=cj6r
-----END PGP SIGNATURE-----
