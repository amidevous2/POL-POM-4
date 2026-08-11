#!/bin/bash
# Date : (2011-10-14 18-20)
# Last revision : (2013-12-10 09-56)
# Wine version used : 1.3.19
# Author : SuperPlumus
 
# CHANGELOG
# [SuperPlumus] (2013-12-10 09-56)
#   Update gettext messages
# Dadu042] (2019-11-04)
#   Wine 1.3.19 -> 2.22
#   Fix download URL.
#   Software does download and installs but it fail to launch (nothing appear). Tried: Wine 2.22, 3.0.3, 4.02
 
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
 
TITLE="Windows Media Player 10"
PREFIX="WMP10"
WORKING_WINE_VERSION="2.22"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.windowsmediaplayer.com" "SuperPlumus" "$PREFIX"
 
POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
Set_OS "winxp"
 
POL_System_TmpCreate "$PREFIX"
 
POL_Call POL_Install_wsh57
 
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
 
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    cd "$POL_System_TmpDir"
    # Dead URL 2019-11-04
    # POL_Call POL_Softpedia_Download "http://www.softpedia.com/dyn-postdownload.php?p=4121&t=4&i=1" "e57645c5ab34485d56d019aaa17c3150"

    # Direct link does not download 2019-11.04
    # POL_Call POL_Softpedia_Download "http://softpedia-secure-download.com/dl/be0e390dc06e7c906a9ff3e4364b94c3/5dc01b25/100004121/software/multimedia/player/MP10Setup.exe" "e57645c5ab34485d56d019aaa17c3150"
    
    # OK as of 2019-11-04
    POL_Download "https://download.microsoft.com/download/7/2/6/7268fac5-e084-48c6-ae26-7cc03cefb602/mp10setup.exe" "93f733c630b734563db8e9d4ae7c8db3"
    
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "MP10Setup.exe"
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
fi
 
# On attend la fin de premier setup (qui a la fin, va lancer le 2eme setup)
INSTALL_ON="1"
until [ "$INSTALL_ON" == "" ]; do
sleep 15
INSTALL_ON=`ps aux | grep "MP10Setup" | grep -v "grep"`
done
 
# On attend la fin du 2eme setup
INSTALL_ON="1"
until [ "$INSTALL_ON" == "" ]; do
sleep 15
INSTALL_ON=`ps aux | grep "setup_wm" | grep -v "grep"`
done
 
# On attend que l'installateur lance le player, pour ensuite le killer, pour permettre de terminer l'installation
sleep 30
killall "wmplayer.exe"
 
POL_Wine_WaitExit "$TITLE"
 
POL_Wine regedit /D "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Cdr4_2K"
POL_Wine regedit /D "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Cdralw2k"
 
# Installation des codecs
POL_Call POL_Install_wmpcodecs
 
POL_System_TmpDelete
 
POL_Shortcut "wmplayer.exe" "$TITLE"
 
POL_SetupWindow_message "$(eval_gettext 'Installation finished.')" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcAj/AAKCRDlMfrJqhPK
R1AeAKCuHUK+BcPjeTqUb87bOtbP6YDyHQCfa/f0b3KYr0Z771Z2zpT4wvNNkvk=
=bMHg
-----END PGP SIGNATURE-----
