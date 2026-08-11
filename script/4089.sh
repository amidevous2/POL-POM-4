#!/usr/bin/env playonlinux-bash
# Date : (2020-06-05 17-11)
# Last revision : see changelog
# Wine version used : 5.0.0
# Distribution used to test : Ubuntu 20.04 amd64
# Author : IgnoredAmbience
# PlayOnLinux : 4.3.4
# Script licence : MIT
# Program licence : Retail
#
# 
# TESTED Editions: v4.6.9 (2020-06)
#
# CHANGELOG
# [IgnoredAmbience] (2020-06-05 17-11)
#   Initial version
# [IgnoredAmbience] (2020-06-08 16-30)
#   Set Legacy Train List option by default.
#   Add warning message to ignore installation error.
# [Dadu042] (2020-06-12 15-00)
#   Standardize.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="SimSig"
PREFIX="SimSig"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Cajon Rail LLC" "http://www.simsig.co.uk" "IgnoredAmbience" "$PREFIX"
 
POL_System_TmpCreate "$PREFIX"
 
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "https://www.simsig.co.uk/File/Download/852" "e93c3476785bec701517066498362634"
    INSTALLER="$POL_System_TmpDir/852"
fi
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

# WINEDLLOVERRIDES="mscoree="
POL_Wine_OverrideDLL "" "mscoree"

 
POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
POL_Wine "$INSTALLER" "/VERYSILENT" "/NOICON"
 
POL_SetupWindow_message "$(eval_gettext 'The SimSig Updater will now run. At the end of the update, you can ignore any error message telling you that the SimSig System Files are not installed.')" "$TITLE"
 
POL_Wine "C:\\Program Files\\SimSig\\SimSigRefresherC.exe"
POL_Wine_UpdateRegistryPair "HKEY_CURRENT_USER\Software\SimSig\Options" "LegacyTrainList" --dword 1
 
POL_System_TmpDelete
 
POL_Shortcut "SimSigLoader.exe" "$TITLE" "" "" "Game;Simulation;"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXuN+KQAKCRDlMfrJqhPK
R3O1AKCeKz8q1Sn8klST4wwbLU1zYf6NpwCfWZ6IOrv8xAbUKElC//p3vJJMMII=
=xk/8
-----END PGP SIGNATURE-----
