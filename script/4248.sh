#!/bin/bash
 
# CHANGELOG
# [Claudio Santos] (2020-08-23 17:00)
#   Initial script.
# [Dadu042] (2020-10-24 11-26)
#   POL POL_RequiredVersion 4.0 -> v4.3 (required for Wine 5.x).
#   Remove useless POL_Wine_OverrideDLL (job is done by the functions).
#   Fix POL_Shortcut category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Microsoft Power BI Desktop"
PREFIX="Power BI Desktop"
WINEVERSION="5.0.3"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/Office/top.jpg" "http://files.playonlinux.com/resources/setups/Office/left.png" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 801
 
POL_SetupWindow_presentation "$TITLE" "Microsoft" "https://powerbi.microsoft.com" "Claudio Santos" "$PREFIX"
 
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"
 
if [ "$POL_OS" = "Linux" ]; then
        wbinfo -V || POL_Debug_Fatal "Please install winbind (or samba, on Arch Linux) before installing $TITLE"
fi
POL_Debug_Init
POL_System_SetArch "x86"
 
 
POL_SetupWindow_InstallMethod "LOCAL"

POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
SetupIs="$APP_ANSWER"

 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
if [ "$POL_OS" = "Mac" ]; then
    # Samba support
    POL_Call POL_GetTool_samba3
    source "$POL_USER_ROOT/tools/samba3/init"
fi
 
 
POL_Wine_WaitBefore "$TITLE"
[ "$CDROM" ] && cd "$CDROM"
 
if [ ! "$(file $SetupIs | grep 'x86-64')" = "" ]; then
    POL_Debug_Fatal "$(eval_gettext "The 64bits version is not compatible! Sorry")";
fi
POL_Wine "$SetupIs"
POL_Wine_WaitExit "$TITLE"
POL_Call POL_Install_dotnet45
POL_Call POL_Install_gecko
POL_Call POL_Install_corefonts
POL_Call POL_Install_gdiplus
POL_Call POL_Install_riched20
POL_Call POL_Install_riched30
POL_Call POL_Install_msxml6
POL_Call POL_Install_mspatcha
# See http://forum.winehq.org/viewtopic.php?f=8&t=23126&p=95555#p95555

# Fix a crash when loading a file


POL_Shortcut "PBIDesktop.exe" "Power BI Desktop" "" "" "Office;" 
 
POL_Extension_Write pbix "Power BI Desktop"

 
POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed successfully.\n\nIf an installation Windows prevent your programs from running, you must remove and reinstall $TITLE')" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYC9BbQAKCRDlMfrJqhPK
RyEDAJwNuQA4FuK1wBgxqyGi45pRMZGaXwCeMOvoyCzeNvlzToooJz+xTAJOcVE=
=tz1v
-----END PGP SIGNATURE-----
