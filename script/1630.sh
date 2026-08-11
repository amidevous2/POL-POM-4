#!/bin/bash
# Date : (2013-03-20 ??-??)
# Last revision : (2015-05-22 21-04)
# Wine version used : 1.6
# Distribution used to test : Arch x86_64
# Licence : GPLv3
# PlayOnLinux : 4.1.9
# Author : l0ser140

# CHANGELOG
# [nabellaleen] (2015-05-22 21-04)
#   MSI Installer
# [petch] (2013-08-28 01-06)
#   Wine 1.6 (#2453)
# [SupePlumus] (2013-06-08 18-48)
#   gettext
# [Petch] (2013-09-21 23-26)
#   system menu entry
# [Dadu042] (2020-01-03)
#   Wine 1.7.46 (outdated) -> 3.20 (according Appdb.winehq.org)
#   Add POL_Wine_SetVideoDriver
#   Fix POL_SetupWindow_message return to line.

POL_Wine_DelOverrideDLL()
{
    # Delete override DLLs
    cat << EOF > "$POL_USER_ROOT/tmp/del-override-dll.reg"
REGEDIT4

[HKEY_CURRENT_USER\Software\Wine\DllOverrides]
EOF

    while test "$1" != ""
    do
        echo ""$1"=-" >> "$POL_USER_ROOT/tmp/del-override-dll.reg"
        shift
    done
    POL_Debug_Message "Deleting overrides DLLs"
    POL_SetupWindow_wait_next_signal "Please wait" "$TITLE"
    POL_Wine regedit "$POL_USER_ROOT/tmp/del-override-dll.reg"
}

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="EVEonline"
WINEVERSION="3.20"
TITLE="EVE online"
EDITOR="CCP games"
GAME_URL="http://www.eveonline.com"
AUTHOR="l0ser140"
GAME_VMS="128"

# Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_SetupWindow_message "$(eval_gettext 'Requires about 18 GB free space (2015).\nAs well, an additional 5 Gb in your /home/ folder if you will use online installer.\nRecommend using offline installer.')" "$TITLE"

# Create Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Dependencies
POL_Call POL_Install_vcrun2008

# Overriding dlls
POL_Wine_DelOverrideDLL "*msvcr90"
POL_Wine_OverrideDLL "" "d3d11"
POL_Wine_OverrideDLL_App "launcher.exe" "native,builtin" "msvcr90"
POL_Wine_OverrideDLL_App "repair.exe" "native,builtin" "msvcr90"

################
#      GPU     #
################
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Installation
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_question "$(eval_gettext 'You want to open $TITLE download page in your browser?')" "$TITLE"
    if [ "$APP_ANSWER" = "TRUE" ]
    then
        POL_Browser "http://community.eveonline.com/download/?fallback=1&"
    fi
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"

    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    # Check latest EVE version to download it
    POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"
    check_one "wget" "wget"
    check_one "sed" "sed"
    POL_SetupWindow_missing
    version=`wget -q -O - http://community.eveonline.com/download/ | sed -rn 's;^.*href="http://content.eveonline.com/([0-9]+)/[^"]*"[[:space:]]+class="primary-dlbutton.*$;\1;p'`

    if [ -n "$version" ]
    then
        # Create temp folder
        POL_System_TmpCreate "$PREFIX"
        cd "$POL_System_TmpDir"
        # Download online installer
        POL_Download "http://content.eveonline.com/${version}/EVE_Online_Installer_${version}.msi"

        POL_Wine_WaitBefore "$TITLE"
        POL_Wine msiexec /i "$POL_System_TmpDir/EVE_Online_Installer_${version}.msi"
        POL_Wine_WaitExit "$TITLE"

        POL_System_TmpDelete
    else
        POL_Debug_Fatal "Error while checking $TITLE version."
    fi
fi

# Create symbolic link for settings
POL_SetupWindow_question "$(eval_gettext 'You want to create symbolic link for $TITLE settings in your /home/ folder?n(Recommend yes.)')" "$TITLE"
if [ "$APP_ANSWER" = "TRUE" ]
then
    POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"
    ccp_path="${WINEPREFIX}/drive_c/users/${USER}/Local Settings/Application Data/CCP"
    if [ ! -d "$HOME/EVE/settings" ]; then
        mkdir -p "$HOME/EVE/settings"
    fi
    if [ -d "${ccp_path}/EVE" ]; then
        mv "${ccp_path}/EVE" "${ccp_path}/EVE_old"
    else
        mkdir -p "$ccp_path"
    fi
    ln -s "$HOME/EVE/settings" "${ccp_path}/EVE"
fi

# Create Shortcuts
POL_Shortcut "eve.exe" "$TITLE" "" "" "Game;RolePlaying;"

POL_SetupWindow_message "$(eval_gettext "Known issues:\n1) Loading EULA on the first run can take a long (5min) time.\n2) The Captain s Quarters feature is broken for most (all?) users.\nIf you crash after selecting a character try hitting escape at the login screen and disabling Captain''s Quarters under the graphics selection.\n(This feature is considered useless by most Eve Players.)")" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg+9twAKCRDlMfrJqhPK
R/8nAJ9qhGWLe3xt+R0EOMBUbd6vcu4xDACeK3Wu9YVtZzz+9U347JprokqxY10=
=a77Q
-----END PGP SIGNATURE-----
