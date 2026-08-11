#!/bin/bash
# Last revision : (2014-08-20 19:20)
# Author : Tutul
# License : GNU/GPL v3
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="The Elder Scrolls 3 - Bloodmoon"
TITLE_REQUIRED="The Elder Scrolls 3 - Morrowind"
PREFIX="TES3_Morrowind"
EDITOR="Bethesda Softworks"
GAME_URL="http://bethsoft.com/"
AUTHOR="Tutul"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/morrowind/top.jpg" "http://files.playonlinux.com/resources/setups/morrowind/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 709
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')"
    POL_SetupWindow_Close
    exit
fi

POL_SetupWindow_message "$(eval_gettext 'If you have the extentions, you should install Tribunal first !')" "$TITLE"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,LOCAL"
  
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
   
        POL_SetupWindow_cdrom
        POL_Call POL_Sudo_UnhideCdrom
        POL_SetupWindow_check_cdrom "Setup.exe"
   
        SETUP_EXE="$CDROM/Setup.exe"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
fi
 
# Run the install
POL_Wine_WaitBefore "$TITLE"
POL_Wine $SETUP_EXE
POL_Wine_WaitExit "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlP03GQACgkQ5TH6yaoTykc4DQCdGu8Y8Iw1grvU6ZYOBZi68KX2
lJgAoKXpAeU2VnzHuOCmsa3NfZ4BTmLs
=3egT
-----END PGP SIGNATURE-----
