#!/usr/bin/env playonlinux-bash
# Date : (2018-06-17 20:40)
# Last revision : (2018-07-10 17:54)
# Distribution used to test : Ubuntu 16.04 LTS with NVIDIA geforce GTX 770 (lathis), Ubuntu 18.04 LTS with NVIDIA GeForce GTX 1070 (LinuxScripter)
# Author : lahtis
# Licence : GPLv3
    
    
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
PREFIX="L3DT"
WORKING_WINE_VERSION="3.1"
TITLE="L3DT"
EDITOR="Bundysoft"
GAME_URL="http://www.bundysoft.com/L3DT/"
AUTHOR="lahtis, ZemoScripter"
    
# Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups/$PREFIX/left.png" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_System_TmpCreate "$PREFIX"

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
           
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
   
# Downloading/installing the program
POL_SetupWindow_question "$(eval_gettext 'Do you have downloaded the instalation file?')" "$TITLE"
if [ "$APP_ANSWER" = "FALSE" ]; then
        POL_SetupWindow_question "$(eval_gettext 'Do you want the development version?')" "$TITLE"
	if [ "$APP_ANSWER" = "TRUE" ]; then
		cd "$POL_System_TmpDir"
		POL_Download "http://www.bundysoft.com/L3DT/downloads/standard/dev/2018/L3DT_SE_dev-18.05.0.1.exe"
		POL_Wine "$APP_ANSWER"
		POL_Wine_WaitExit "$TITLE"
	else
		cd "$POL_System_TmpDir"		
		POL_Download "http://www.bundysoft.com/L3DT/downloads/standard/L3DT_SE-16.05.exe"
		POL_Wine "$APP_ANSWER"
		POL_Wine_WaitExit "$TITLE"
	fi
else
	POL_SetupWindow_browse "$(eval_gettext 'Please select the downloaded exe file.')" "$TITLE"
	POL_Wine "$APP_ANSWER"
	POL_Wine_WaitExit "$TITLE"
fi        

# Shortcut 
POL_Shortcut "L3DT.exe" "$TITLE"
 
POL_SetupWindow_message "$(eval_gettext 'If the program crashes at startup, open a terminal and type:\necho 0|sudo tee /proc/sys/kernel/yama/ptrace_scope')"
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNUwfAAKCRDlMfrJqhPK
R3qnAJ9sgEKX0jJ270jSmQNE0Ig1HK3UiwCeO1aknvm9G5l79VCVMM4LORXeR0U=
=25zp
-----END PGP SIGNATURE-----
