#!/bin/bash
 
# CHANGELOG
# [Quentin PÂRIS] (2012-05-17 17:22)
#   Updated to PlayOnLinux v4
# [Dadu042] (2020-01-29 21:00)
#   Wine Linux 1.2.3 -> 3.0.3
#   Improve POL_Shortcut
# [XHK6ceq] (2020-06-18 11:00)
#   Add install from local file.

# CHANGELOG
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Escape From Monkey Island"
PREFIX="Monkey4"
 
if [ "$POL_OS" = "Linux" ]; then
        WINEVERSION="3.0.3"
else
        WINEVERSION="1.2.3-16bits"
fi
 
POL_GetSetupImages
POL_SetupWindow_Init
POL_Debug_Init
POL_RequiredVersion "4.0.18" || POL_Debug_Fatal "$APPLICATION_TITLE 4.0.18 is required to install $TITLE"
 
POL_SetupWindow_presentation "$TITLE" "LucasArts" "http://www.lucasarts.com" "Quentin PÂRIS" "$PREFIX"
 
POL_SetupWindow_InstallMethod "CD"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
POL_System_TmpCreate "Monkey4"
 
if [ "$INSTALL_METHOD" = "CD" ]; then
        POL_SetupWindow_message "$(eval_gettext 'Please insert the first game media into your disk drive')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Install/Setup.exe"
        POL_System_CopyDirectory "$CDROM" "$POL_System_TmpDir" "2518368"
        chmod -R 777 "$POL_System_TmpDir"
        POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"
         
        POL_SetupWindow_message "$(eval_gettext 'Please insert the second game media into your disk drive')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Install/Setup.tab"
 
        POL_System_CopyDirectory "$CDROM" "$POL_System_TmpDir" "2518368"
        chmod -R 777 "$POL_System_TmpDir"
        POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"
         
        POL_Wine_WaitBefore "$TITLE" --allow-kill
 
        POL_SetupWindow_message "$(eval_gettext 'Please insert the first game media into your disk drive')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Install/Setup.exe"
        POL_Wine_InstallCDROMCustom "$POL_System_TmpDir"
 
        POL_Wine_WaitBefore "$TITLE" --allow-kill
        POL_Wine "$POL_System_TmpDir/Install/Setup.exe"
 
        POL_Wine_reboot
fi
 
POL_System_TmpDelete
POL_Shortcut "Monkey4.exe" "$TITLE" "" "" "Game;AdventureGame;"
POL_Call POL_Function_NoCDWarning
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXutGqQAKCRDlMfrJqhPK
R33jAJ4gCWXUr1hmFCh5pzi1hmSJNKB4lQCeNdYAQ48xyXK1v0nBaq6ubZYVGEM=
=mL0d
-----END PGP SIGNATURE-----
