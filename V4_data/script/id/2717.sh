#!/bin/bash
# Date : (2016-01-20 08-09)
# Last revision : (2016-01-20 08-09)
# Wine version used : 1.7.49
# Distribution used to test : Arch Linux (kernel 4.2.5-1)
# Author : Cedric Wehrum
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Origin from OriginLab"
PREFIX="OriginLabOriginPro"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2717
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "OriginLab" "http://www.originlab.com/" "Cedric Wehrum" "$PREFIX"

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
#For me Origin crashes with other versions of wine
POL_Wine_PrefixCreate "1.9.1"
#Components needed according to http://www.originlab.com/forum/topic.asp?TOPIC_ID=10428
#POL_Call POL_Install_vcrun2008 A more recent version is needed, see below
POL_Call POL_Install_corefonts
POL_Call POL_Install_ie8
POL_Call POL_Install_msxml3
POL_Call POL_Install_gdiplus
#I figured this one out on my own. It seems that many things crash without a native msvcr110.dll
POL_Call POL_Install_vcrun2012

POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
# Wait till Origin is installed
POL_Wine_WaitBefore "$TITLE"
# Installing
POL_Wine "$APP_ANSWER"

# Create a shortcut, show the user a message that everything went successfully and exit
POL_Shortcut "Origin[0-9][0-9][0-9][0-9]/Origin*.exe" "$TITLE" "$TITLE.png"
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlailR8ACgkQ5TH6yaoTykd0oQCfWFj44SqX2doXvAhMwl22JbmE
KI0AnAi07DqDD/FXeAu0W4L9QySET/Zr
=AV4T
-----END PGP SIGNATURE-----
