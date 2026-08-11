#!/bin/bash
#
# CHANGELOG
# [Tinou] (2014-07-14)
#   Initial writting.
# [Dadu042] (2019-06-29)
#   Add warning about user files deleted on OSX.
#   Wine 3.0.4 -> 3.0.5
#   Fix the issue 'Script does download v5 instead of v4'
# [Dadu042] (2020-03-05)
#   Wine 3.0.5 -> 3.20 (latest supported by POL v4.2)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="MetaTrader 4"
PREFIX="metatrader4"
FILE="mt4setup.exe"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$TITLE" "http://www.metatrader4.com/" "Tinou" "$PREFIX"

POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_SetupWindow_message "Warning (Mac OSX):\nOn OSX, it was reported one time (june 2019) that this script deleted files of the user !. Details in the forum:\n\n https://www.playonlinux.com/en/topic-16577-Mac_documents_and_desktop_folder_wiped.html"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.20"
# Set_OS win7

POL_Call POL_Install_LunaTheme
 
cd "$WINEPREFIX/drive_c"

# Does download v5 instead of v4 (2019-06 Dadu042)
# POL_Download "http://files.metaquotes.net/metaquotes.software.corp/mt4/$FILE"
POL_Download "https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/$FILE"

POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "$FILE"
POL_Wine_WaitExit "$TITLE"
  
POL_Shortcut "terminal.exe" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXmFOUwAKCRDlMfrJqhPK
R7s6AJsGLQG/IXJrGKl8pcVYQ+FHs3SE5gCfRLt1gbaq/Y82XP/zOnfW2IS/VwU=
=T8fB
-----END PGP SIGNATURE-----
