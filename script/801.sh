#!/bin/bash
 
# CHANGELOG
# [Quentin PÂRIS] (2012-05-05 14-45)
#   Wine version set to 1.5.3, Outlook 2010 compatiblity
# [Quentin PÂRIS] (2012-05-05 15-05)
#   Check winbind (samba) presence on Linux, required to install
#   Adding gettext support
# [Quentin PÂRIS] (2012-05-12 18-36)
#   Requires 4.0.18
# [SuperPlumus] (2013-06-09 14-44)
#   gettext
# [Quentin PÂRIS] (2014-07-21 17-09)
#   Updating with the latest WineHQ version
# [rbelo] (2018-07-22 15-50)
#   Updating with the latest stable WineHQ version (3.0.2), ver 1.7.52 does not seem to work.
# [Mrjacobarussell] (2018-09-25 20-50)
#   Updating missing dotnet20, gdiplus, gecko, corefonts, msxml6
# [diogoborges14] (2018-12-01)
#   mspatcha
# [Dadu042] (2020-02-10 12-33)
#   Wine 3.0.2 -> 3.0.3 (more common on POL nowadays).
#   Note: I think that lines POL_Wine_OverrideDLL for riched20 and riched30 are useless.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="Office2010"
WINEVERSION="3.0.3"
TITLE="Microsoft Office 2010"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/Office/top.jpg" "http://files.playonlinux.com/resources/setups/Office/left.png" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 801
 
POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.microsoft.com" "Quentin PÂRIS" "$PREFIX"
 
POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"
 
if [ "$POL_OS" = "Linux" ]; then
        wbinfo -V || POL_Debug_Fatal "Please install winbind (or samba, on Arch Linux) before installing $TITLE"
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
POL_Call POL_Install_dotnet20
POL_Call POL_Install_gecko
POL_Call POL_Install_corefonts
POL_Call POL_Install_gdiplus
POL_Call POL_Install_riched20
POL_Call POL_Install_riched30
POL_Call POL_Install_msxml6
POL_Call POL_Install_mspatcha
# See http://forum.winehq.org/viewtopic.php?f=8&t=23126&p=95555#p95555
POL_Wine_OverrideDLL "native,builtin" "riched20"
POL_Wine_OverrideDLL "native,builtin" "riched30"
POL_Wine_OverrideDLL "native,builtin" "gdiplus"

# Fix a crash when loading a file

 
POL_Shortcut "WINWORD.EXE" "Microsoft Word 2010" "" "" "Office;WordProcessor;"
POL_Shortcut "EXCEL.EXE" "Microsoft Excel 2010" "" "" "Office;Spreadsheet;"
POL_Shortcut "POWERPNT.EXE" "Microsoft Powerpoint 2010" "" "" "Office;Presentation;"
POL_Shortcut "ONENOTE.EXE" "Microsoft OneNote 2010" "" "" "Network;InstantMessaging;" # No category for collaborative work?
POL_Shortcut "OUTLOOK.EXE" "Microsoft Outlook 2010" "" "" "Network;Email;" # Calendar;ContactManagement; ? :p
 
POL_Extension_Write doc "Microsoft Word 2010"
POL_Extension_Write docx "Microsoft Word 2010"
POL_Extension_Write xls "Microsoft Excel 2010"
POL_Extension_Write xlsx "Microsoft Excel 2010"
POL_Extension_Write ppt "Microsoft Powerpoint 2010"
POL_Extension_Write pptx "Microsoft Powerpoint 2010"
 
if [ "$POL_OS" = "Mac" ]; then
    POL_Shortcut_InsertBeforeWine "Microsoft Word 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
    POL_Shortcut_InsertBeforeWine "Microsoft Excel 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
    POL_Shortcut_InsertBeforeWine "Microsoft Powerpoint 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
    POL_Shortcut_InsertBeforeWine "Microsoft OneNote 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
    POL_Shortcut_InsertBeforeWine "Microsoft Outlook 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
fi
 
POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed successfully\n\nIf an installation Windows prevent your programs from running, you must remove and reinstall $TITLE')" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXkFAewAKCRDlMfrJqhPK
R4RMAJ90k0E2E2D8Q/ZxUENHU/IfKLst/gCffjLO4ag0f2fENlwOxtwIkQeEiv0=
=XQgU
-----END PGP SIGNATURE-----
