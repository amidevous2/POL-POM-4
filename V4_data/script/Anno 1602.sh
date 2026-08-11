#!/bin/bash
# Date : 2017-11-21 17:34
# Latest revision: 2018-02-10 11:25
# Wine version used : 3.0
# Distribution used to test : Ubuntu 17.04, Ubuntu 18.04 x64
# Author : LinuxScripter
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Anno 1602"
PREFIX="Anno1602"
WORKING_WINE_VERSION="3.0"
EDITOR="SunFlowers"
GAME_URL="http://anno.uk.ubi.com/pc/history1602.php"
AUTHOR="LinuxScripter"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_SetupWindow_InstallMethod "LOCAL,CD"
if [ "$INSTALL_METHOD" == "CD" ];then
    POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "autorun.cdd"
	POL_Wine start /unix "$CDROM/Anno1602.EXE"
	POL_Wine_WaitExit "Anno1602.EXE"
else
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	POL_Wine start /unix "$APP_ANSWER"
	POL_Wine_WaitExit "$TITLE"
fi
 
POL_Shortcut "START.exe" "$TITLE" "1602.ico"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPUBigAKCRDlMfrJqhPK
RxnRAJ41YjKADfZ/CxA0FWlnPZiFJ75XCgCeK9WJZqeBuhg6AJS8yMe9G/EEauY=
=46V+
-----END PGP SIGNATURE-----
