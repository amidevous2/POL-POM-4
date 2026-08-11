#!/bin/bash
# Date : (2015-12-09)
# Distribution used to test : Duzeru GNU/Linux 2.0 64 bit
# Author : chocoelho
# Based on: Office2010 script
# Licence : GPLv3
# PlayOnLinux: 4.2.9
#
# CHANGELOG
# [chocoelho] (2019-12-19 20:50)
#   First script.
# [Dadu042] (2020-01-02)
#   Wine 2.8 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="Project2010"
WINEVERSION="3.0.3"
TITLE="Microsoft Project 2010"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/Office/top.jpg" "http://files.playonlinux.com/resources/setups/Office/left.png" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 801

POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.microsoft.com" "chocoelho" "$PREFIX"

POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"

if [ "$POL_OS" = "Linux" ]; then
        wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE"
fi
POL_Debug_Init
POL_System_SetArch "x86"


POL_SetupWindow_InstallMethod "LOCAL,DVD"

if [ "$INSTALL_METHOD" = "DVD" ]; then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "x86/setup.exe" "setup.exe"
        SetupIs="$CDROM_SETUP"
        cd "$CDROM"
else
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SetupIs="$APP_ANSWER"
fi

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

# See http://forum.winehq.org/viewtopic.php?f=8&t=23126&p=95555#p95555
POL_Wine_OverrideDLL "native,builtin" "riched20"

# Fix a crash when loading a file
POL_Call POL_Install_msxml6

POL_Shortcut "WINPROJ.EXE" "Microsoft Project 2010" "" "" "Office;ProjectManagement;"

POL_Extension_Write mpp "Microsoft Project 2010"
POL_Extension_Write mpt "Microsoft Project 2010"
POL_Extension_Write mpx "Microsoft Project 2010"
POL_Extension_Write mdb "Microsoft Project 2010"

if [ "$POL_OS" = "Mac" ]; then
    POL_Shortcut_InsertBeforeWine "Microsoft Project 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
fi

POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed successfully\n\nIf an installation Windows prevent your programs from running, you must remove and reinstall $TITLE')" "$TITLE"
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg5qzAAKCRDlMfrJqhPK
R8f8AKCLhgErbl9+efkKvttVhde8P+qUwgCfc/G5zBv7ffC7DbKm+6D3o2JhOt0=
=uTch
-----END PGP SIGNATURE-----
