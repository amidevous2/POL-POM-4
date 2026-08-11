#!/bin/bash
# Date : (2010-12-31 10-36)
# Last revision : (2013-09-30 09-12)
# Wine version used : 1.3.20
# Distribution used to test :
# Author : SuperPlumus

# CHANGELOG
# [SuperPlumus] (2013-09-30 09-12)
#   Update gettext messages
#   Clean code
# [Dadu042] (2020-01-22 21:30)
#   Wine 1.3.20 -> 3.0.3
 

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Mount and Blade : Warband"
PREFIX="MountBladeWarband"
WORKING_WINE_VERSION="3.0.3"
[ "$POL_OS" = "Mac" ] && WORKING_WINE_VERSION="1.3.16" # Compulsery!

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/mountblade_warband/top.jpg" "http://files.playonlinux.com/resources/setups/mountblade_warband/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Paradox Interactive" "http://www.paradoxplaza.com/" "SuperPlumus" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
#POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

POL_Call POL_Install_mfc42

POL_SetupWindow_InstallMethod "LOCAL,STEAM"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit

fi
if [ "$INSTALL_METHOD" = "STEAM" ]
then

POL_Call POL_Install_steam
POL_Call POL_Install_steam_flags "48700"
POL_Wine_WaitBefore "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "Steam.exe" "steam://install/48700"
POL_Wine_WaitExit

fi

# Configuration du jeu
# Le repertoire ne ne situe pas toujours au meme endroit suivant les versions du jeu
mkdir -p "$WINEPREFIX/drive_c/users/$USER/Application Data/Mount&Blade Warband"
mkdir -p "$HOME/Mount&Blade Warband"
cd "$WINEPREFIX/drive_c/users/$USER/Application Data/Mount&Blade Warband"
cat << EOF > rgl_config.txt
use_winmm_audio = 1
use_secure_connection = 0
use_vertex_shaders = 0
EOF
cp "rgl_config.txt" "$HOME/Mount&Blade Warband/rgl_config.txt"

# Desactivation de mmdevapi
POL_Wine_OverrideDLL disabled mmdevapi

POL_Wine_SetVideoDriver

POL_SetupWindow_VMS

POL_System_TmpDelete

if [ "$INSTALL_METHOD" = "STEAM" ]; then
POL_Shortcut "Steam.exe" "$TITLE" "" "steam://rungameid/48700"
else
POL_Shortcut "mb_warband.exe" "$TITLE"
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXi9EkAAKCRDlMfrJqhPK
R+O2AJ4sCI4Vz3N6UlqWgGcfr601PjdMSgCgqXn48s7HH+fShHP+4syoOZ8ayOk=
=xLDz
-----END PGP SIGNATURE-----
