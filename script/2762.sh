#!/usr/bin/env playonlinux-bash   
# Date : 2018-01-23
# Last revision : 2018-01-23
# Wine version used : 2.21-staging for installation dotnet462, wine-2.18 (Ubuntu 2.18-1) for running
# Distribution used to test : Ubuntu MATE 17.10
# Author : simulant   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Banking4W"
PREFIX="Banking4W"
 
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Subsembly" "https://subsembly.com/banking4.html" "simulant" "$PREFIX"

if [ "$POL_OS" = "Linux" ]; then
        wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE"
fi

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
cd "$POL_System_TmpDir"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_Download "https://subsembly.com/download/TopBankingSetup.exe"
    INSTALLER="$POL_System_TmpDir/TopBankingSetup.exe"
fi

# Select and create prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "2.21-staging"

# Set OS to windows2003
Set_OS "win2003"

# Installation
eval_gettext 'Please wait while $TITLE is installed.'
POL_Wine "$INSTALLER"

# Install packages
POL_Install_corefonts
POL_Call POL_Install_dotnet40
POL_Call POL_Function_FontsSmoothRGB

# Workaround for function POL_Install_dotnet462 (doesn't exist at the moment)
#POL_Call POL_Install_dotnet462

# Set OS to windows7
Set_OS "win7"

# Download and install dotnet462
eval_gettext 'Please wait while $TITLE is installed.'
POL_Download "https://download.microsoft.com/download/F/9/4/F942F07D-F26F-4F30-B4E3-EBD54FABA377/NDP462-KB3151800-x86-x64-AllOS-ENU.exe" "9a5d647ee710af2b1aede329c40bbe1a"

eval_gettext 'Please wait while $TITLE is installed.'
POL_Wine --ignore-errors "$POL_System_TmpDir/NDP462-KB3151800-x86-x64-AllOS-ENU.exe" /q

# Clear tempfile
POL_System_TmpDelete

# Create launcher
POL_Shortcut "TopBanking.exe" "$TITLE"

POL_SetupWindow_install_wine "2.18"
POL_Wine_SetVersionPrefix "2.18"

POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUSVPwAKCRDlMfrJqhPK
R7qFAJ9p3SFMa0yIHQ7ZzKPqvMtq5GewigCfYw/K3yPZpMq880a0KjvcsOzZYmE=
=JjjV
-----END PGP SIGNATURE-----
