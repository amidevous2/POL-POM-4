#!/bin/bash
# Date : (2016-05-07 ??-??)
# Last revision : (2016-05-07 ??-??)
# Wine version used : 1.9.5
# Distribution used to test : Linux Mint 17.3 x64
# Author : plata
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Rocksmith 2014 (Steam)"
PREFIX="Rocksmith_2014"
WORKING_WINE_VERSION="1.9.5"
EDITOR="Ubisoft"
GAME_URL="http://rocksmith.ubi.com/rocksmith/en-US/home/index.aspx"
AUTHOR="plata"
 
# start the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# set prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# download wine if necessary and create prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# use Windows 7
Set_OS "win7"

# make sure that audio works
Set_SoundDriver "alsa"

# install dependencies
POL_Call POL_Install_d3dx9
POL_Call POL_Install_steam
 
# begin game installation
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/221680
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
POL_Wine_WaitExit "$TITLE"

# fix Rocksmith.ini
cd "$WINEPREFIX/drive_c/Program Files/Steam/steamapps/common/Rocksmith2014"
# set Win32UltraLowLatencyMode=0
sed -i 's/^\(Win32UltraLowLatencyMode=\).*/\10/' Rocksmith.ini
# set display resolution
read width height <<<$(xrandr | fgrep '*' | egrep -o '[0-9]+x[0-9]+' | egrep -o '[0-9]+')
sed -i "s/^\(ScreenWidth=\).*/\1$width/" Rocksmith.ini
sed -i "s/^\(ScreenHeight=\).*/\1$height/" Rocksmith.ini
 
# create shortcut
POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/221680"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUSC+gAKCRDlMfrJqhPK
R9poAJ4+lCjM5mM5FjpDT8DJlb6MsK79kQCfYcdAl6NbRrktvzug+cUoNPkFStw=
=MLgA
-----END PGP SIGNATURE-----
