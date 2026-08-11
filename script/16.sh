#!/bin/bash
# Distribution used to test : Fedora 12, Arch Linux
# Depend : ImageMagick, unzip
 
# CHANGELOG
# [SuperPlumus] (2013-06-08 18-02)
#   gettext
# [ZeNity_] (2016-10-02 15-11)
#   Add Best Seller Edition support
#   Add alternative CD files as parameters to POL_Wine_InstallCDROM command
#   Replace playd2.mpq by D2Video.mpq in order to differentiate CD 2 & 3
#   Update Wine version to 1.8.4 (last stable)
#   Remove Set_Desktop command as it is more about user's personal preference
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Diablo II"
PREFIX="DiabloII"
WINEVERSION="4.5"
PATCHTITLE="Blizzard Updater v2.72"
PATCHLINK="http://ftp.blizzard.com/pub/diablo2/patches/PC"
PATCHFILE="D2Patch_113d.exe"
PATCHFILESUM="ce7313b0c35261a2a5f528cd6e2693b5"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_Call POL_Install_corefonts


POL_SetupWindow_presentation "$TITLE" "Blizzard" "www.blizzard.com" "Tinou" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"
 
if [ "$POL_SELECTED_FILE" ]; then
    SetupFile="$POL_SELECTED_FILE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$SetupFile"
else
    POL_SetupWindow_InstallMethod "CD,LOCAL"
 
    if [ "$INSTALL_METHOD" = "CD" ]; then
        POL_SetupWindow_menu "$(eval_gettext 'Which game version do you have?')" "$TITLE" "Original Edition~Best Seller Edition" "~"
        Version="$APP_ANSWER"
 
        POL_Call POL_Wine_InstallCDROM "1" "w" "install.exe" "installer.exe"
        POL_Wine_WaitBefore "$TITLE"
 
        POL_Wine start /unix "$CDROM_SETUP"
 
        POL_Call POL_Wine_InstallCDROM "2" "w" "d2music.mpq" "Installer Tome 2.mpq" "Installer_Tome_2.mpq"
 
        POL_Call POL_Wine_InstallCDROM "3" "w" "D2Video.mpq" "Installer Tome 3.mpq" "Installer_Tome_3.mpq"
 
        if [ "$Version" = "Best Seller Edition" ]; then
            POL_Call POL_Wine_InstallCDROM "01" "w" "install.exe" "installer.exe"
        fi
    fi
 
    if [ "$INSTALL_METHOD" = "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SetupFile="$APP_ANSWER"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine start /unix "$SetupFile"
    fi
fi
 
POL_Wine_WaitExit "$TITLE"
 
POL_Download_Resource "$PATCHLINK/$PATCHFILE" "$PATCHFILESUM"
POL_Wine start /unix "$POL_USER_ROOT/ressources/$PATCHFILE"
POL_Call POL_Wine_InstallCDROM "2" "w" "d2music.mpq" "Installer Tome 2.mpq" "Installer_Tome_2.mpq"
POL_Wine_WaitExit "$PATCHTITLE"

POL_Shortcut "Diablo II.exe" "$TITLE"
POL_Shortcut_QuietDebug "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXdGTKQAKCRDlMfrJqhPK
R7AdAJ9G7YVjgIPZcaj6JAnF3rtPVZlf0QCfdQ9xpm3W7/2qovBpqLEk5Ybk+uw=
=Dxsv
-----END PGP SIGNATURE-----
