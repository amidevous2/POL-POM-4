#!/bin/bash
# Date : (2016-11-06 11-10)
# Last revision : (2016-11-06 11-10)
# Author : daniil_filipov
  
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
  
TITLE="TOTALCMD"
PREFIX="TOTALCMD"
 
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Ghisler Software GmbH" "http://www.ghisler.com/" "daniil_filipov" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
 
POL_Call POL_Install_LunaTheme
 
POL_SetupWindow_InstallMethod "LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
  
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
  
fi
POL_Shortcut "TOTALCMD.EXE" "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlgfCCYACgkQ5TH6yaoTykf/mwCfQ06vrzyqECSTAxRyL2WQEgaQ
WZgAmQHVzXGXgbNOJ9g18pBIuRQfZTUU
=TMfj
-----END PGP SIGNATURE-----
