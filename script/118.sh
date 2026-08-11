#!/bin/bash
# Date : (2009-09-11 13-00)
# Last revision : (2011-10-09 09-58)
# Distribution used to test : Ubuntu 10.04
# Author : Tinou
 
# CHANGELOG
# [Quentin Paris] (2009-09-11 13-00)
#   Initial version.
# [SuperPlumus] (2013-12-10 09-42)
#   Update gettext messages
# [Dadu042] (2020-01-03)
#   Wine 1.4.1 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
 
TITLE="Safari 5"
PREFIX="Safari5"
WORKING_WINE_VERSION="3.0.3"
 
#POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/safari/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Apple" "http://www.apple.com/safari" "Tinou" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_System_TmpCreate "$PREFIX"
 
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_LunaTheme
 
# Cette modif permet de contourner le crash de Safari au demarrage
mkdir -p "$WINEPREFIX/drive_c/users/$USER/Application Data/Apple Computer/Preferences"
cat << EOF > "$WINEPREFIX/drive_c/users/$USER/Application Data/Apple Computer/Preferences/com.apple.Safari.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>LastDisplayedWelcomePageVersionString</key>
    <string>4.0</string>
</dict>
</plist>
EOF
 
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
 
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
 
cd "$POL_System_TmpDir"
POL_Download "http://appldnld.apple.com.edgesuite.net/content.info.apple.com/Safari5/061-7138.20100607.Y7U87/SafariSetup.exe" "adc0089b8ce39971964812d9580ac077"
POL_SetupWindow_message "$(eval_gettext 'During the install process, please deselect\n"Install Bonjour for Windows" and "Automaticaly update Safari".')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "SafariSetup.exe"
POL_Wine_WaitExit "$TITLE"
 
fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
 
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_SetupWindow_message "$(eval_gettext 'During the install process, please deselect\n"Install Bonjour for Windows" and "Automaticaly update Safari".')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
 
fi
 
# POL_Call POL_Install_Flashplayer_Others

# This help to avoid a crash when opening a new tab.
POL_Wine_Direct3D "PixelShaderMode" "disabled"
 
POL_System_TmpDelete
 
POL_Shortcut "Safari.exe" "$TITLE" "" "" "Network;"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg6CtgAKCRDlMfrJqhPK
RxU7AJ92B9ItRpg+cAOQin8x648czC/6RwCfcx5k4eOqp/vMaRN5iuS55/Dg3TA=
=hMeU
-----END PGP SIGNATURE-----
