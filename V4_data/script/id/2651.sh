#!/bin/bash
# Date : (2015-12-02 16-00)
# Last revision : (2019-11-02)
# Wine version used : system
# Distribution used to test : Xubuntu 19.04
# Author : Tarulia
# Script licence :
# Program licence : GPL
# Depend :

# CHANGELOG
# [Tarulia] (2015-12-02)
#   First script.
# [...]
#    ...
# [Dadu042] (2019-11-02)
#   Note: I tested installation with 'HeidiSQL_10.2.0.5599_Setup.exe' (system Wine: 4.0.0) but then I had not a SQL DB to connect to.
#   - Remove feature 'install from download' (because the link break again, file removed by the publisher).
#   - Add feature 'install from local'.
#   - Add warning message about fixme-all.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="HeidiSQL"
PREFIX="heidisql"
# FILE="HeidiSQL_10.1.0.5464_Setup.exe"
# MD5="9e82f9dad7ff68b428d9928d6863f69c"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2651
POL_SetupWindow_presentation "$TITLE" "$TITLE" "http://www.heidisql.com/" "Tarulia" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
Set_OS "win7"

# POL_Download "http://www.heidisql.com/installers/$FILE" "$MD5"

        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"

POL_SetupWindow_message "WARNING!\n
\n
When asked to select a theme, make sure you select \"Use default Windows theme\", because WINE is not able to handle the \"Dark Material theme\"!\n
\n
If you are using a dark system theme, after the installation go to the WINE configuration and in the Staging tab select \"Enable GTK3 Theming\" (KDE users can change the GTK theme in System Settings > Application Style > GTK). GTK3 Theming may not be perfect however." "$TITLE"

        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
 
POL_Shortcut "heidisql.exe" "$TITLE" "" "" "Development;Database"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to let POL/POM write a huge log file, you may type \ninto Debug flags : fixme-all')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXb1XPgAKCRDlMfrJqhPK
R0XWAKCLl0gcJ3mvYlPlGyH4Vh53WopbqwCfSMYXfjYqpJqSyxE6KgM7zLQaMYM=
=xLM6
-----END PGP SIGNATURE-----
