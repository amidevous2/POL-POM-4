#!/bin/bash
# Date : (2017-06-08 12:00)
# Last revision : see changelog
# Play On Linux version used : 4.3.4
# Wine version used : system
# Distribution used to test : Xubuntu 19.04 x64
# Author : 7roxel
# Licence : https://wiki.mikrotik.com/wiki/Manual:The_Dude/License
# Only For : http://www.playonlinux.com
 
## Note ##
# This script does just install the client to connect to The Dude Server which runs on MikroTik's RouterOS.

# CHANGELOG
# [Dadu042] (2019-12-21 13:30)
#   First script.
# [Dadu042] (2019-12-22)
#   Tested with dude-install-6.44.6.exe
#   Wine 2.9 -> system version
#   DUDE_VER="6.40.1" -> "6.44.6" (LTS)
#   Fix download link.
#   Add install from local source.
#   OS winxp -> win7

# KNOWN ISSUES:
#  - Wine amd64 3.0.0 (+ -6.44.6): installer fail because fonts does not appear.

 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="The Dude client"
PREFIX="TheDudeClient"
EDITOR="MikroTik"
URL="https://mikrotik.com/thedude"
AUTHOR="7roxel"
WORKING_WINE_VERSION=""
DUDE_VER="6.44.6"
SHORTCUT_FILENAME="dude.exe"
SOFTWARE_CATEGORIES="Network;"
 
# Starting the script
#POL_GetSetupImages "" "" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
#Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
Set_OS "win7"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Installing mandatory dependencies
# X

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
    
# Begin installation
if [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        # POL_SetupWindow_message "$(eval_gettext '\nNote: this script will download the DEMO.')" "$TITLE"
 
        cd "$WINEPREFIX/drive_c"

	POL_Download_Resource "https://download2.mikrotik.com/routeros/$DUDE_VER/dude-install-$DUDE_VER.exe" ""
	POL_Wine "dude-install-$DUDE_VER.exe"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
         
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.EXE')" "~"
        APP_ANSWER=".EXE"
 
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE" # "/SILENT"
        POL_Wine_WaitExit "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
fi
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXf9NPwAKCRDlMfrJqhPK
R9oJAJ9c/0PURtyaz7eW+IDqAURUWAtTRgCgq/sMc3kzzlUrx62D3RGasQgY7QQ=
=u4tZ
-----END PGP SIGNATURE-----
