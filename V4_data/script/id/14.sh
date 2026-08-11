#!/bin/bash
# Date : (2009-07-07 19-30)
# Last revision : see changelog
# Wine version used : see script
# Distribution used to test : N/A
# Author : Asimov and SuperPlumus
# Contributor: freedumb2000 vi2nano
  
# CHANGELOG
# [Dadu042] (2020-02-22 07-35)
#  Wine 1.9.20-staging (outdated) -> 3.20 (latest compatible with POL/POM v4.2.x)
#  Improved POL_Shortcut
#  Translate comments french -> english
# [vi2nano] (2016-10-14 06-45)
#	Updated for Legion
#	Updated wine version to 1.9.20-staging
#	Added Override for msvcp140(native,builtin)
#	added XP as default OS
#	commented out dotnet30sp1 install. It's no longer required also (md5 mismatch was inevitable)
#	commented Fichier Config.wtf for now. DX11 seems to be working a little better in wine, no need to force it to default to DX9.
# [vi2nano] (2016-06-18 16-38)
#   Updated Wine Version to 1.9.12 (Works with new 6.2.4 patch)
#   Added dotnet30sp1 to fix errors logging into Battle.net.
#   Added a few message windows during install to point users in the right direction setting ptrace_scope
#    and regarding installation of libldap (ArchLinux doesn't include it in base system their may be Distros also)
# [Petch] (2015-12-04 23-17)
#   Add POL_SetupWindow_SetID
# [freedumb200] (2014-11-14 17-15)
#   Update Wine version to 1.7.29 (known to work with Draenor).
#   Added dbghelp dll override to fix a crsh in the BattleNet client.
# [SuperPlumus] (2013-05-12 15-55)
#   Update Wine version to 1.5.29 to fix bug #2284
#   Add --allow-kill in POL_Wine_WaitExit
# [SuperPlumus] (2013-05-19 20-47)
#   gettext
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="World of Warcraft"
PREFIX="WorldOfWarcraft"
WORKING_WINE_VERSION="3.20"
  
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/wow/top.jpg" "http://files.playonlinux.com/resources/setups/wow/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 14
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Blizzard Entertainment" "http://www.blizzard.com" "Asimov and SuperPlumus" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86" # Don't know if it can work in x64
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_System_TmpCreate "$PREFIX"
  

POL_Call POL_Install_gecko
#POL_Call POL_Install_dotnet30sp1
POL_SetupWindow_message "$(eval_gettext 'If this fails check the debug, if missing libldap.so, and please install libldap from your Repo')" "$TITLE"
  
Set_OS "winxp"
POL_Wine_OverrideDLL "dbghelp"
POL_Wine_OverrideDLL "native,builtin" "msvcp140"
  
POL_SetupWindow_InstallMethod "CD,DVD,LOCAL"
  
if [ "$INSTALL_METHOD" = "CD" ]
then
  
# The CDs number can change among the packages released.
POL_SetupWindow_menu "$(eval_gettext 'Which version do you have?')" "$TITLE" "4 CDs~5 CDs" "~"
NOMBRE_CD="$APP_ANSWER"
  
POL_SetupWindow_message "$(eval_gettext 'Please insert game media 1 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/* "$POL_System_TmpDir"
  
POL_SetupWindow_message "$(eval_gettext 'Please insert game media 2 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome 2.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/*.mpq "$POL_System_TmpDir"
  
POL_SetupWindow_message "$(eval_gettext 'Please insert game media 3 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome 3.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/*.mpq "$POL_System_TmpDir"
  
POL_SetupWindow_message "$(eval_gettext 'Please insert game media 4 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome 4.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/*.mpq "$POL_System_TmpDir"
  
  
if [ "$NOMBRE_CD" = "5 CDs" ]; then
POL_SetupWindow_message "$(eval_gettext 'Please insert game media 5 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome 5.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/*.mpq "$POL_System_TmpDir"
fi
  
cd "$POL_System_TmpDir"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "Installer.exe"
POL_Wine_WaitExit "$TITLE" --allow-kill
  
fi
if [ "$INSTALL_METHOD" = "DVD" ]
then
  
POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/* "$POL_System_TmpDir"
  
cd "$POL_System_TmpDir"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "Installer.exe"
POL_Wine_WaitExit "$TITLE" --allow-kill
  
fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
  
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE" --allow-kill
  
  
fi
  
POL_Wine_SetVideoDriver
  
POL_SetupWindow_VMS
  
  
POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"
  
# Fichier Config.wtf
#cd "$WINEPREFIX/drive_c/$PROGRAMFILES/World of Warcraft/WTF"
#cat << EOF > Config.wtf
#SET gxApi "D3D9"
#SET ffxDeath "0"
#SET SoundOutputSystem "1"
#SET SoundBufferSize "150"
#SET MasterSoundEffects "0"
#EOF
  
# AddOn ApplyToForehead (avoid WOW crashes on the settings screen)
mkdir -p "$WINEPREFIX/drive_c/$PROGRAMFILES/World of Warcraft/Interface"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/World of Warcraft/Interface"
wget "$SITE/divers/ApplyToForehead.zip"
unzip "ApplyToForehead.zip"
rm "ApplyToForehead.zip"
  
POL_Wine_InstallFonts
Set_SoundDriver alsa
  
POL_System_TmpDelete
  
POL_Shortcut "Wow.exe" "$TITLE" "" "" "Game;"
POL_Shortcut_InsertBeforeWine "$TITLE" "mkdir -p \"$WINEPREFIX/drive_c/$PROGRAMFILES/World of Warcraft/WTF/\""
POL_Shortcut_InsertBeforeWine "$TITLE" "cp \"$WINEPREFIX/drive_c/Config.wtf\" \"$WINEPREFIX/drive_c/$PROGRAMFILES/World of Warcraft/WTF/Config.wtf\""
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX0CvxQAKCRDlMfrJqhPK
R7UeAJsGczJYVLyMGFBHQWFxH7w2gA4wUwCfY2u7UOQyLXyKfWQ+Cz2wtAtOF1w=
=qspR
-----END PGP SIGNATURE-----
