#!/bin/bash
# Date : (2015-04-21)
# Distribution used to test : Arch Linux 64-bit
# Author : Thimoteus
# Licence : GPLv3
# PlayOnLinux: 4.2.8
 
#
# CHANGELOG
# [Thimoteus] (2015-04-21)
#   First script.
# [Dadu042] (2020-01-03)
#  Wine 1.7.40 -> 3.0.3
# [Dadu042] (2021-08-10)
#  Wine 3.0.3 -> 4.0.4
#  Winxp (not supported any more) -> Win 7


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="ChampionsOnline"
WINEVERSION="4.0.4"
TITLE="Champions Online"
EDITOR="Perfect World Entertainment Inc."
GAME_URL="http://www.arcgames.com/en/games/champions-online"
AUTHOR="Thimoteus"
DOWNLOAD_URL="http://download.perfectworld.com/co/champions_online_setup.exe"
 
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
POL_Debug_Init
 
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Configuration
Set_OS "win7"
 
# Installation
POL_System_TmpCreate "$PREFIX"
cd $POL_System_TmpDir
POL_Download "$DOWNLOAD_URL" "c8bd9c356f9f4aca091b235ced50da7d"
 
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Do not run $TITLE or log in after installation. Close any open windows so that PlayOnLinux can finish the install. ')" "$TITLE"
 
POL_Wine "champions_online_setup.exe"
POL_Wine_WaitExit "$TITLE"
 
# Create Shortcut
POL_Shortcut "Champions Online.exe" "$TITLE" "" "" "Game;"
 
# Cleanup
POL_System_TmpDelete
 
POL_SetupWindow_message "$(eval_gettext 'NOTICE: $TITLE can take up to 15 minutes or longer to start for the first time. It only does this the first time the game has be ran.')" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYRLKawAKCRDlMfrJqhPK
R48VAJwKXtAQwkd8F5bq99SKkjBgPs2b3QCfWfeRxZcxwYJYWivLVONdmG1KSYM=
=0s5k
-----END PGP SIGNATURE-----
