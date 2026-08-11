#!/bin/bash
# Last revision : (2015-11-06)
# Wine version used : 1.5.8
# Distribution used to test : Mint 17 64bits
# Author : guigonyts
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

WINEVERSION="1.5.8"
 
TITLE= "Giana Sisters - Twisted Dreams"
PREFIX="GianaSistersTD"
AUTHOR="guigonyts"
EDITOR="Black Forest"
GAME_URL="http://black-forest-games.com/"
  
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
#Version of wine that worked for me
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
 
#Install some dependencies
POL_Call POL_Install_xact
POL_Call POL_Install_wmp9
POL_Call POL_Install_mono28
 
#Selection of the setup program
POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
 
POL_SetupWindow_wait
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"
 
POL_SetupWindow_auto_shortcut
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDouAAKCRDlMfrJqhPK
RznuAKCAtd62uATzPDmUfs74FFcpHEQJuQCfTz8CGXcwUC5ulck3fN+woj/cl6Y=
=RbYg
-----END PGP SIGNATURE-----
