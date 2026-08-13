#!/bin/bash
# Date : 2016-11-22 23:08
# Last revision : 2023-04-15 16:27
# Wine version used : 6.17-staging
# Distribution used to test : Debian Bullseye
# Author : fasmat, LinuxScripter
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Pokemon Uranium 1.2.5 Setup"
PREFIX="PokeUranium"
AUTHOR="fasmat"
WORKINGWINEVERSION="6.17-staging"
 
POL_SetupWindow_SetID 3518
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Pokémon Uranium Team" "http://www.reddit.com/r/pokemonuranium" "fasmat" "$PREFIX"
 
POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_Wine_OverrideDLL "" "dwrite"
POL_Install_d3dx9_36
POL_Install_directplay
POL_Install_directmusic
   
POL_SetupWindow_question "$(eval_gettext 'Do you want to download the installer now?')" "$TITLE"
   
if [ "$APP_ANSWER" = "TRUE" ]
then
   POL_Browser "https://www.reddit.com/r/pokemonuranium/comments/m9yvd6/download_links/"
fi
   
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
   
SETUP_EXE="$APP_ANSWER"

POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
   
POL_Shortcut "Uranium.exe" "Pokémon Uranium"
   
POL_SetupWindow_Close
   
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZEfgDgAKCRDlMfrJqhPK
R/ukAKCFr3hOxS43dAaXtc/TLGbUKIynqACcChbmYZ8U4rTrc6HLsHI9L0/07MI=
=eCmr
-----END PGP SIGNATURE-----
