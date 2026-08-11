#!/bin/bash
# Date : (2015-11-12)
# Last revision : (2015-11-12 23:00)
# Distribution used to test : Ubuntu, Debian
# Author : Rodrigo Pinto
# Licence : GPLv3

# Changelog
# (2015-10-01) 23:00 (Rodrigo Pinto)
#       - WowApp 5.0.0 with Wine 1.7.46 32bits
# (2015-10-21) 17:00 (Rodrigo Pinto)
#       - Set arch to x86
#        - Remove the Downloading dialog
# (2015-11-12) 14:00 (Rodrigo Pinto)
#       - New 6.0.0 version
#        - Audio fix

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

POL_System_SetArch "x86" 
WINEVERSION="1.7.46"

TITLE="WowApp"
PREFIX="WowApp"
SHORTCUT_NAME="WowApp"
EXE_URL="http://cdn-rackspace.wowapp.com/pub/WowApp_Setup_Full_6.0.0.exe"

POL_GetSetupImages "http://www.wowapp.com/images/logo.png" "http://www.wowapp.com/images/logo.png" "$TITLE"

POL_SetupWindow_Init
POL_RequiredVersion "4.0.18" || POL_Debug_Fatal "$APPLICATION_TITLE 4.0.18 is required to install $TITLE"
POL_SetupWindow_SetID 1135

which glxinfo || POL_Debug_Error "$(eval_gettext 'glxinfo is not installed. Please install mesa-utils package')"

if ! glxinfo | grep -q GL_EXT_texture_compression_s3tc; then
    POL_SetupWindow_message "$(eval_gettext 'Warning! S3TC compression is not available on your system.\n\nIf you have a free driver, you might need to install a proprietary driver \n\nOtherwise, you can enable it by installing libtxc-dxtn0 package, but you might get slower results')"
    POL_Debug_Warning "S3TC not enabled!"
fi

POL_Debug_Init

POL_SetupWindow_presentation "WowApp" "Nobel INC" "https://www.wowapp.com/" "Rodrigo Pinto" "WowApp"

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"

    FULL_INSTALLER="$APP_ANSWER"
else # DOWNLOAD
    POL_System_TmpCreate "$PREFIX"

    DOWNLOAD_URL=$EXE_URL
    DOWNLOAD_MD5="2256981db07885f3e330a40692a4842e"
    DOWNLOAD_FILE="$POL_System_TmpDir/$(basename "$DOWNLOAD_URL")"

    POL_Call POL_Download_retry "$DOWNLOAD_URL" "$DOWNLOAD_FILE" "$DOWNLOAD_MD5" "$TITLE standalone installer"

    FULL_INSTALLER="$DOWNLOAD_FILE"
fi

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_SetupWindow_message "$(eval_gettext 'Warning: You must not tick the checkbox "Run $TITLE" when setup is done')" "$TITLE"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$FULL_INSTALLER"

Set_OS winxp


# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

#install setupapi
POL_Download "http://downloadapp.wowapp.com/public/setupapi.dll" "24192246760e0e64435522e246b1d6c2"
# Copy setupapi.dll to App folder in $WINEPREFIX/drive_c/users/$USER/Application Data/WowApp/
#POL_Debug_Message "Installing setupapi"
cp setupapi.dll "$WINEPREFIX/drive_c/users/$USER/Application Data/WowApp/setupapi.dll"


POL_Call POL_Function_OverrideDLL native setupapi


POL_Shortcut_InsertBeforeWine "WowApp" "export PULSE_LATENCY_MSEC=30" 

POL_Shortcut "WowApp.exe" "$SHORTCUT_NAME" "" "-noupdate -renderer software" ""

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    # Free some disk space
    POL_System_TmpDelete
fi


POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlZE97YACgkQ5TH6yaoTyke5mgCfZlQT1UBGye5sCTicU3zR6R2N
Z5gAn05ONr6zFJavew2wkjro5wEqPgZd
=xFVH
-----END PGP SIGNATURE-----
