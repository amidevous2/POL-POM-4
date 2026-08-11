#!/bin/bash
# Date : (2020-04-29)
# Distribution used to test : OpenSUSE Tumbleweed x64
# Author : Simona Avornicesei
# Licence : MIT
# PlayOnLinux: 4.3.4
#
# Installs Balsamiq Mockups 3 through PlayOnLinux/PlayOnMac
#
#
# CHANGELOG
# [Simona Avornicesei] (2020-04-29)
#   Initial script.
# [Dadu042] (2020-04-29 13-00)
#   Add category.
#   Add POL_RequiredVersion

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="BalsamiqMockups"
APP_TITLE="Balsamiq Mockups"
APP_EDITOR="Balsamiq Studios, LLC"
APP_URL="https://balsamiq.com/"
SCRIPT_AUTHOR="Simona Avornicesei"

#Initialization
POL_GetSetupImages "https://media.balsamiq.com/files/company/balsamiq-logo-noborder-print.png" "https://media.balsamiq.com/images/ico-desktop-lg.png" "$APP_TITLE"
POL_SetupWindow_Init
       
POL_Debug_Init
       
# Presentation
POL_SetupWindow_presentation "$APP_TITLE" "$APP_EDITOR" "$APP_URL" "$SCRIPT_AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
 
####################################### 
# Installation
#######################################
BALSAMIQ_URL="https://build_archives.s3.amazonaws.com/obsolete/mockups-desktop/3.5.17/Balsamiq_Mockups_3.5.17_bundled.zip"
BALSAMIQ_ZIP="Balsamiq_Mockups_3.5.17_bundled.zip"
BALSAMIQ_EXE="Balsamiq Mockups 3.exe"

# Require that unzip is available
if ! which unzip > /dev/null
then
    POL_Debug_Error "$(eval_gettext 'Missing required program: ')unzip"
    return 1
fi

# Download and extract Balsamiq
POL_Download "$BALSAMIQ_URL"
if ! unzip "$BALSAMIQ_ZIP"
then
    POL_Debug_Error "$(eval_gettext 'Failed to unzip the Balsamiq archive: ')$BALSAMIQ_ZIP"
    return 1
fi
POL_Debug_Message "Balsamiq extracted to $POL_System_TmpDir"
mkdir ~/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Balsamiq_Mockups_3
mv -f Balsamiq_Mockups_3/* ~/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Balsamiq_Mockups_3/

# Delete TMP folder
POL_System_TmpDelete
 
# Create Shortcuts
POL_Shortcut "$BALSAMIQ_EXE" "$APP_TITLE" "" "" "Development;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqqFiAAKCRDlMfrJqhPK
R7zyAJwIHrMYBVkm7vx9qE66TnMl9SA7QwCgq7Wl8KIghVIDMc72y+eQN7qcCBM=
=XQqh
-----END PGP SIGNATURE-----
