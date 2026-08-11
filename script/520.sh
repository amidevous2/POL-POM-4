#!/bin/bash
# Date : (2018-02-08 23-31)
# Last revision : (2019-06-13 18-02)
# Wine version used : 4.0.1
# Distribution used to test : GNU/Linux
# Author : LinuxScripter
# Licence : Retail
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="King's Bounty - The Legend"
EDITOR="Atari"
AUTHOR="LinuxScripter"
GAME_URL="http://www.kings-bounty.com"
PREFIX="KBtL"
WORKING_WINE_VERSION="4.0.1"
   
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
   
POL_SetupWindow_Init
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
   
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "support/AdbeRdr930_en_US.exe"
POL_Wine start /unix "$CDROM/setup.exe"
POL_Wine_WaitExit "$CDROM/setup.exe"
 
POL_Shortcut "kb.exe" "King's Bounty - The Legend" "" ""
   
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXQKPwwAKCRDlMfrJqhPK
R6pyAJ9NO3KEnBpKEYLO66jtfAGL+vUvFgCfRJ8UUj/mrGkoc8SfPMQ/+kDdO64=
=IlwC
-----END PGP SIGNATURE-----
