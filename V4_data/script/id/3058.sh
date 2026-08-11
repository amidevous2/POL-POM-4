#!/bin/bash
# Date : (2016-10-02 13-21)
# Last revision : (2016-10-05 17-50)
# Author : daniil_filipov
  
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
  
TITLE="ETS2"
PREFIX="ETS2"
 
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "SCS Software" "http://scssoft.com/" "daniil_filipov" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
 
POL_Call
 
POL_SetupWindow_InstallMethod "LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
  
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
  
fi
POL_Shortcut "eurotrucks2.exe" "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlgfCLUACgkQ5TH6yaoTykfDRwCfbLTcyfyx6cTrETQxZEt/LCU3
DhoAnjg0u3B2aY8JGt+Tn2KQDKUcjvjv
=sPlX
-----END PGP SIGNATURE-----
