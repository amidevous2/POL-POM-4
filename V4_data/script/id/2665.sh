#!/bin/bash
 
# CHANGELOG
# [Quentin PÂRIS] (2015-11-26 22-01)
#   Initial version
# [Dadu042] (2020-01-02)
#   Wine 2.8-staging (outdated) -> 3.0.3 (OK with POL v4.2.x)
# [Dadu042] (2020-01-02)
#   Wine 3.0.3 -> 4.0.4 (REQ POL v4.3.x)



[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="Office2013"
WINEVERSION="4.0.4"
TITLE="Microsoft Office 2013"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/Office/top.jpg" "http://files.playonlinux.com/resources/setups/Office/left.png" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2665
 
POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.microsoft.com" "Quentin PÂRIS" "$PREFIX"
 
POL_RequiredVersion 4.3 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"
 
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

Set_OS "win7" 

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
# POL_Call POL_Install_msxml6
 
POL_Shortcut "WINWORD.EXE" "Microsoft Word 2013" "" "" "Office;WordProcessor;"
POL_Shortcut "EXCEL.EXE" "Microsoft Excel 2013" "" "" "Office;Spreadsheet;"
POL_Shortcut "POWERPNT.EXE" "Microsoft Powerpoint 2013" "" "" "Office;Presentation;"
POL_Shortcut "ONENOTE.EXE" "Microsoft OneNote 2013" "" "" "Network;InstantMessaging;" # No category for collaborative work?
POL_Shortcut "OUTLOOK.EXE" "Microsoft Outlook 2013" "" "" "Network;Email;" # Calendar;ContactManagement; ? :p
 
POL_Extension_Write doc "Microsoft Word 2013"
POL_Extension_Write docx "Microsoft Word 2013"
POL_Extension_Write xls "Microsoft Excel 2013"
POL_Extension_Write xlsx "Microsoft Excel 2013"
POL_Extension_Write ppt "Microsoft Powerpoint 2013"
POL_Extension_Write pptx "Microsoft Powerpoint 2013"
 
if [ "$POL_OS" = "Mac" ]; then
    POL_Shortcut_InsertBeforeWine "Microsoft Word 2013" "source \"$POL_USER_ROOT/tools/samba3/init\""
    POL_Shortcut_InsertBeforeWine "Microsoft Excel 2013" "source \"$POL_USER_ROOT/tools/samba3/init\""
    POL_Shortcut_InsertBeforeWine "Microsoft Powerpoint 2013" "source \"$POL_USER_ROOT/tools/samba3/init\""
    POL_Shortcut_InsertBeforeWine "Microsoft OneNote 2013" "source \"$POL_USER_ROOT/tools/samba3/init\""
    POL_Shortcut_InsertBeforeWine "Microsoft Outlook 2013" "source \"$POL_USER_ROOT/tools/samba3/init\""
fi
 
POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed successfully\n\nIf an installation Windows prevent your programs from running, you must remove and reinstall $TITLE')" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYnrksgAKCRDlMfrJqhPK
R9WbAJ9IG/9Nt+YOwo9AIN1i9TKdxwKYTQCfQq1YezX+fEj7sQqG4gn1ojcFXhM=
=Kgq0
-----END PGP SIGNATURE-----
