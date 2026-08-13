#!/bin/bash

# CHANGELOG
# [Quentin PÂRIS] (2010 ?)
#   Initial writting.
# [SuperPlumus] (2013-06-09 15-11)
#   gettext
#   clean code
#   fix $PLAYONLINUX variable check
#   fix POL_SetupWindow_browe -> POL_SetupWindow_browse (missing 's')
# [Dadu042] (2020-02-20 17:15)
#   Wine 1.7.46 (outdated) -> 3.0.3 (untested)
#   Add function to set a virtual desktop window.
#   Add POL_RequiredVersion "4.1.0" 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Starcraft"
PREFIX="Starcraft"
WORKING_WINE_VERSION="3.0.3"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Blizzard" "http://www.blizzard.com" "Quentin PÂRIS" "$PREFIX"

POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "setup.exe"
    SetupIs="$CDROM/setup.exe"
fi

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SetupIs="$APP_ANSWER"
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupIs"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "Starcraft.exe" "$TITLE" "" "" "Game;"

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Starcraft/"
POL_Download "http://files.playonlinux.com/ddraw.dll" "efe4aa40d8633213dbfd2c927c7c70b0"


#######################################
# Create a 'virtual desktop' (window) #
#######################################
   
# Workaround to fix the "No mouse nor keyboard on main menu":
   
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1368x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
     
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
   
Set_Desktop "On" "$WIDTH" "$HEIGHT"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXp3kRgAKCRDlMfrJqhPK
R7ldAJ97FUd+Cm9acsxDAL7hHDoWdSXHlQCeMPc22/FzKvS3em6VW9KJuC+9nPo=
=YwYb
-----END PGP SIGNATURE-----
