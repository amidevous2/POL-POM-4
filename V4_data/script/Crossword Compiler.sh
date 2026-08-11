#!/bin/bash
# Date: 2015-12-28
# Author: MTres19
# Wine version used: 1.8
# Distribution used to test: Kubuntu 15.10 (amd64)

# CHANGELOG
# [Dadu042] (2019-06-30)
#   URL fixed. Wine 1.8 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Crossword Compiler"
PREFIX="CrosswordCompiler"
WINEVERSION="2.22"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "WordWeb Software" "www.wordwebsoftware.com" "MTres19" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_LunaTheme

POL_SetupWindow_menu "$(eval_gettext 'Please select a language.')" "$TITLE" "English~Deutsch~Español~Français~Italiano" "~"
[ "$APP_ANSWER" = "English" ] && END=".exe"
[ "$APP_ANSWER" = "Deutsch" ] && END="_de.exe"
[ "$APP_ANSWER" = "Español" ] && END="_es.exe"
[ "$APP_ANSWER" = "Français" ] && END="_fr.exe"
[ "$APP_ANSWER" = "Italiano" ] && END="_it.exe"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
    then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the program.')" "$TITLE"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine --ignore-errors "$APP_ANSWER"
fi

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
    then
        POL_SetupWindow_message "$(eval_gettext 'Notice: This will only be a demo version.')" "$TITLE"
        
        POL_System_TmpCreate "$PREFIX"
        cd "$POL_System_TmpDir"
        POL_Download "https://uk.wordwebsoftware.com/downloads/ccdemo$END"
        
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine --ignore-errors "ccdemo$END"
        
        POL_System_TmpDelete
fi

POL_Shortcut "ccw$END" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRhJ+QAKCRDlMfrJqhPK
R7KPAKCljSrO4B19T3+OgdR8b20ODmL2kgCgmRvyTlpahT4NxYcHEBtXObpsbqo=
=B8Zk
-----END PGP SIGNATURE-----
