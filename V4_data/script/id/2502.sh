#!/bin/bash
# Date : (2015-04-17 16-37)
# Wine version used : 1.7.34
# Distribution used to test : OpenSUSE 13.2
# Author : Benjamin Hardy
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - Xenonauts"
GOGID="xenonauts"
PREFIX="Xenonauts"
#Installer crashed when using 1.6.2, but ran well with 1.7.34
WINEVERSION="1.7.34"
SHORTCUT_NAME="Xenonauts"
 
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Goldhawk Interactive" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX"
 
POL_SetupWindow_message "$(eval_gettext 'This installer requires the patch provided by gog.com. Please ensure it has been downloaded to a local drive before continuing.')" "$TITLE"
 
 
POL_Call POL_GoG_setup "$GOGID" "682443fa62f222891ee528900866b254"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
POL_Call POL_GoG_install
 
 
POL_SetupWindow_browse "$(eval_gettext 'Please select the patch file.')" "$TITLE"
POL_Wine_WaitBefore "$(eval_gettext 'Please wait, patch installation in progress.')" "$TITLE"
POL_Wine "$APP_ANSWER"
 
 
POL_SetupWindow_VMS "512"
 
POL_Wine_reboot
 
POL_Shortcut "Xenonauts.exe" "$SHORTCUT_NAME" "" "" "Game;StrategyGame"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Xenonauts/GameManual.pdf"
 
POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlUyA4wACgkQ5TH6yaoTyke9wwCbBWfOAv1KwSU4zAgW69ijrLhU
J+wAn1v/zBI7efkcR2+PHphtwCU1ifUV
=3Xym
-----END PGP SIGNATURE-----
