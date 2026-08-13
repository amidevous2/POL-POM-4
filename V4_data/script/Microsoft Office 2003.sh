#!/bin/bash
# Date : (2009-06-25 11-00)
# Last revision : (2016-2-13)
# Wine version used : 1.8.1
# Distribution used to test : Not tested (yet)
# Author : Tinou (Revised by MTres19)
# Licence : Retail

# CHANGELOG
# [Tinou] (2009)
#   First script.
# [MTres19] (2016)
#   Wine 1.1 -> 1.8.1
#   ...
# [Dadu042] (2019-11-02)
#   Wine 1.8.1 -> 2.22.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Microsoft Office 2003"
PREFIX="Office2003"
WINEVERSION="2.22"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microsoft" "www.microsoft.com" "Tinou" "$PREFIX"

[ "$POL_OS" = "Linux" ] && wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE"
if [ "$POL_OS" = "Mac" ]
    then
        # Samba support
        POL_Call POL_GetTool_samba3
        source "$POL_USER_ROOT/tools/samba3/init"
fi

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Function_FontsSmoothRGB

POL_SetupWindow_InstallMethod "LOCAL,DVD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
    then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
        POL_SetupWindow_WaitBefore "$TITLE"
        POL_Wine "$APP_ANSWER"
fi

if [ "$INSTALL_METHOD" = "DVD" ]
    then
        POL_SetupWindow_cdrom
        cd "$CDROM"
        POL_SetupWindow_WaitBefore "$TITLE"
        POL_Wine "setup.exe"
fi

POL_Shortcut "WINWORD.EXE" "Microsoft Word"
POL_Shortcut "EXCEL.EXE" "Microsoft Excel"
POL_Shortcut "POWERPNT.EXE" "Microsoft PowerPoint"
POL_Shortcut "ONENOTE.EXE" "Microsoft OneNote"
POL_Shortcut "INFOPATH.EXE" "Microsoft InfoPath"
POL_Shortcut "MSPUB.EXE" "Microsoft Publisher"
POL_Shortcut "OUTLOOK.EXE" "Microsoft Outlook"
POL_Shortcut "MSACCESS.EXE" "Microsoft Access"

if [ "$POL_OS" = "Mac" ]
    then
        POL_Shortcut_InsertBeforeWine "Microsoft Word 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
        POL_Shortcut_InsertBeforeWine "Microsoft Excel 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
        POL_Shortcut_InsertBeforeWine "Microsoft Powerpoint 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
        POL_Shortcut_InsertBeforeWine "Microsoft OneNote 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
        POL_Shortcut_InsertBeforeWine "Microsoft Outlook 2010" "source \"$POL_USER_ROOT/tools/samba3/init\""
fi

POL_Wine_reboot
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXb4NxQAKCRDlMfrJqhPK
R/8RAKCseFkI9yeyuo35qS9sF5+OC3otKgCfVk2rxLCB0nSSRKIv+JqLljGH0L4=
=96a0
-----END PGP SIGNATURE-----
