#!/bin/bash

# CHANGELOG
# [Quentin PÂRIS] (2012-04-29 13-09)
#   Updated to PlayOnLinux v4
# [SuperPlumus] (2015-08-02 20-13)
#   Update wine version to 1.7.48
#   Fix bug (incorrect argumentas) in POL_Wine_InstallCDROMCustom
#   Update title variable
#   Partial clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Star Wars: Jedi Knight: Jedi Academy"
PREFIX="JediKnightAcademy"
STEAM_ID="6020"

POL_GetSetupImages "" "$SITE/setups/jka/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_RequiredVersion "4.0.18" || POL_Debug_Fatal "$APPLICATION_TITLE 4.0.18 is required to install $TITLE"

POL_SetupWindow_presentation "$TITLE" "LucasArts" "http://www.lucasarts.com" "Quentin PÂRIS" "$PREFIX"

POL_SetupWindow_InstallMethod "CD,STEAM"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.7.48"

POL_System_TmpCreate "JediKnightAcademy"

if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please insert the first game media into your disk drive')" "$TITLE"
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "GameData/Setup.exe"
    POL_System_CopyDirectory "$CDROM" "$POL_System_TmpDir" "2522356"
    chmod -R 777 "$POL_System_TmpDir"
    POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"

    POL_SetupWindow_message "$(eval_gettext 'Please insert the second game media into your disk drive')" "$TITLE"
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "GameData/data3.cab"

    POL_System_CopyDirectory "$CDROM" "$POL_System_TmpDir" "2522356"
    chmod -R 777 "$POL_System_TmpDir"
    POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"

    POL_Wine_WaitBefore "$TITLE"

    POL_SetupWindow_message "$(eval_gettext 'Please insert the first game media into your disk drive')" "$TITLE"
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "GameData/Setup.exe"
    POL_Wine_InstallCDROMCustom "p" "$POL_System_TmpDir"

    POL_Wine "$POL_System_TmpDir/GameData/Setup.exe"

    POL_Wine_reboot
elif [ "$INSTALL_METHOD" = "STEAM" ]; then
    POL_Call POL_Install_steam
    POL_Call POL_Install_steam_flags "$STEAM_ID"
    POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam" || POL_Debug_Fatal "Unable to change directory : \$WINEPREFIX/drive_c/\$PROGRAMFILES/Steam"
    POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
    POL_Wine_WaitExit "$TITLE"
fi

POL_System_TmpDelete
POL_Shortcut "JediAcademy.exe" "Jedi Knight Academy"

POL_SetupWindow_message "Installation is finished\n\nYou need to patch the game to run it" "$TITLE"
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXd4rMgAKCRDlMfrJqhPK
Rw4kAJ0cSct3bCq4cSoW2REof7JcUfw8MACfYgXRlqr0E0B8wrPN45CuT+20Ykw=
=hwNu
-----END PGP SIGNATURE-----
