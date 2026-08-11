#!/bin/bash
# Author : Tinou/MulX
# 
# Changelog
#
# [MulX] (2010-08-17)
#         Syntax error
# [Quentin PÂRIS] (2012-05-12 13:48)
#         Update to PlayOnLinux V4
#         CD-ROM support is removed because it's broken
# [Quentin PÂRIS] (2012-05-24 21:05)
#         Download from Guild Wars's website
# [Quentin PÂRIS] (2015-08-09)
#         Changed Donwload link to match new link from offical site and checksum
# [Dadu042] (2019-07-03 16:24)
#         Upgrade from Wine 1.7.39 to 2.22 according to appdb.winehq.org and my trouble with the GUI (windows reduced) of the installer (POL 4.3.4, XUbuntu 18.04).
#         Update the checksum of GwSetup.exe
# [Dadu042] (2020-09-16 15:00)
#         Upgrade from Wine 2.22 to 3.20 (not tested. Latest supported by POL v4.2)
#         Improve POL_Shortcut


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Guild Wars"
WINEVERSION="3.20"
PREFIX="GuildWars"
  
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "Guild Wars" "NCsoft" "http://www.guildwars.com" "Quentin PÂRIS, MulX" "$PREFIX"
  
# Use current wine
  
POL_Wine_SelectPrefix "GuildWars"
POL_Wine_PrefixCreate "$WINEVERSION"
[ "$POL_OS" = "Mac" ] && Set_Managed Off
  
POL_SetupWindow_InstallMethod "DVD,DOWNLOAD"
  
mkdir -p "$WINEPREFIX/drive_c/GW"
cd "$WINEPREFIX/drive_c/GW" || POL_Debug_Fatal "Unable to change directory"
 
POL_Download "http://cloudfront.guildwars2.com/client/GwSetup.exe" "c40f85e2a44d44bdbee81406d7570b90"
 
POL_Wine_WaitBefore "$TITLE"
unzip gwsetup.zip
POL_Wine --ignore-errors "GwSetup.exe"
  
  
# POL_Wine regedit Gw.reg
  
if [ "$INSTALL_METHOD" = "CD" ]; then
        # TO do
        echo "Not supported yet"
fi
  
if [ "$INSTALL_METHOD" = "DVD" ]; then
        POL_SetupWindow_message "$(eval_gettext 'Please insert the DVD-ROM')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_System_cp "$CDROM/Data/Gw/Gw.dat" "$WINEPREFIX/drive_c/$PROGRAMFILES/GUILD WARS/Gw.dat"
fi
  
  
# Fix a bug of the next command when answer is no.
touch "$WINEPREFIX/drive_c/$PROGRAMFILES/GUILD WARS/Gw.dat"
# Fix a bug when file created is not RW (read write allowed)
chmod +rw "$WINEPREFIX/drive_c/$PROGRAMFILES/GUILD WARS/Gw.dat"
  
POL_Shortcut "Gw.exe" "$TITLE" "" "" "Game;RolePlaying;"
POL_Wine_SetVideoDriver
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXzlDxQAKCRDlMfrJqhPK
R+JbAJ47DEWxfNhSqke53u9xDWad9FhHEwCeJtzzxKl2E81cAlamYQgcnASaRLk=
=wJRz
-----END PGP SIGNATURE-----
