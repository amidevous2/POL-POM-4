#!/bin/bash
# Date : (2014-06-19 21-00)
# Last revision : (2014-06-19 21-03)
# Wine version used : 1.7.20
# Distribution used to test : Debian testing (jessie)m 2014-06
# Author : nconrads
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "GOG.com - La Mulana" "Mozilla" "http://www.mozilla.com" "YourNickname" "MozillaFirefox"
 
POL_Wine_SelectPrefix "GOG_LaMulana"
POL_Wine_PrefixCreate
 
POL_System_TmpCreate "GOG_LaMulana"
 
POL_SetupWindow_InstallMethod "LOCAL"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the unpatched (2.0.0) La Mulana installation executable." "GOG.com - La Mulana Installation"
    POL_SetupWindow_wait "Installation in progress." "GOG.com - La Mulana (2.0.0) Installation"
    POL_Wine start /unix "$APP_ANSWER"
    POL_SetupWindow_browse "Please select the La Mulana patch installation executable (2.0.2)." "GOG.com - La Mulana Installation"
    POL_SetupWindow_wait "Installation in progress." "GOG.com - La Mulana (2.0.2) Installation"
    POL_Wine start /unix "$APP_ANSWER"

# Would like to offer the download method for this script,
# but uncertain if POL supports delegation to a browser
# where the login is already handled.
#elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
#then
#    cd "$POL_System_TmpDir"
    # This bit clearly requires 
#    POL_Download "https://secure.gog.com/downlink/la_mulana/en1installer0"
#    POL_SetupWindow_wait "Installation in progress." "Mozilla Firefox installation"
#    POL_Wine start /unix "$POL_System_TmpDir/Firefox Setup 7.0.exe"
fi


# Addons necessary for best experience
POL_Call POL_Install_xact

# Clean-up of temporary files
POL_System_TmpDelete


POL_Shortcut "LaMulanaWin.exe" "GOG.com - La Mulana"

 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhTmnwAKCRDlMfrJqhPK
RymaAJ0ULLmDVdTqw0/uw02m3VzitffS3QCdEZ8HyftITvy8OsMdCgJEP5V9Pdk=
=xauL
-----END PGP SIGNATURE-----
