#!/bin/bash
# Date : (2015-12-09)
# Distribution used to test : Duzeru GNU/Linux 2.0 64 bit
# Author : chocoelho
# Based on: Office2010 script
# Licence : GPLv3
# PlayOnLinux: 4.2.9

# CHANGELOG
# [chocoelho] (2015-12-09)
#   Initial writting.
# [Dadu042] (2019-06-03 23-00)
#   Installation fail with POL 4.2.12. Upgrade Wine 1.7.52 to 1.9.24 for testing.
# [Dadu042] (2019-11-12 19:40)
#   Wine 1.9.24 -> 2.22 to workaround this issue: Wine cannot find the FreeType font library. To enable Wine to use TrueType fonts please install a version of FreeType greater than or equal to 2.0.5.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="Visio2010"
WINEVERSION="2.22"
TITLE="Microsoft Visio 2010"
 
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
 
POL_Shortcut "VISIO.EXE" "Microsoft Visio 2010" "" "" "Office;VisioManagement;"
 
POL_Extension_Write vdx "Microsoft Visio 2010"
POL_Extension_Write vsd "Microsoft Visio 2010"
POL_Extension_Write vss "Microsoft Visio 2010"
POL_Extension_Write vst "Microsoft Visio 2010"
POL_Extension_Write vsx "Microsoft Visio 2010"
POL_Extension_Write vtx "Microsoft Visio 2010"
 
if [ "$POL_OS" = "Mac" ]; then
    POL_Shortcut_InsertBeforeWine "Microsoft Visio 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
fi
 
POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed successfully\n\nIf an installation Windows prevent your programs from running, you must remove and reinstall $TITLE')" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcr8zQAKCRDlMfrJqhPK
R7U+AJ96kMirhfKiIn8VgN+MlyVHiNMJkgCeNd/ptSkd2BhQO5lxhqaoI+9oPdw=
=LF3l
-----END PGP SIGNATURE-----
