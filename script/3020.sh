#!/bin/bash
#
# CHANGELOG
# [dvbtecman] (2016)
#   First script
# [Dadu042] (2020-01-01)
#   Wine 1.8.2 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
TITLE="TS-Doctor 2"

PREFIX="TSDoctor2"
WINEVERSION="2.22"

POL_SetupWindow_Init
POL_SetupWindow_SetID
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Cypheros" "http://www.cypheros.de/" "dvbtechman" "$PREFIX"
   
Set_OS winxp
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Install dependencies
POL_Call POL_Install_quartz

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
   
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "TS-Doctor 2.0"
    POL_SetupWindow_wait "Installation in progress." "TS-Doctor 2.0 installation"
    POL_Wine "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_System_TmpCreate "tsdoctor"
    POL_SetupWindow_menu "$(eval_gettext 'What language do you want to install?')" "Language Selection" \
        "English|Deutsch|Français" "|"
    case "$APP_ANSWER" in
         "English")
             DOWNLOAD_LINK="http://www.cypheros.de/download.php?f=TSDoctor2_Eng.exe";;
         "Deutsch")
             DOWNLOAD_LINK="http://www.cypheros.de/download.php?f=TSDoctor2_Ger.exe";;
         "Français")
             DOWNLOAD_LINK="http://www.cypheros.de/download.php?f=TSDoctor2_Fre.exe";;
    *)
        exit 1;;
    esac
   
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOAD_LINK" 
    POL_SetupWindow_wait "Installation in progress." "TS-Doctor 2.0 installation"
    EXE_FILE="${DOWNLOAD_LINK##*/}" # Get everything after last slash.
    mv "$EXE_FILE" "$POL_System_TmpDir/TSDoctor2_install.exe"
    POL_Wine "$POL_System_TmpDir/TSDoctor2_install.exe"
    POL_System_TmpDelete
fi

POL_Shortcut "TSDoctor.exe" "TS-Doctor 2.0"
   
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg2gpAAKCRDlMfrJqhPK
R6w1AJ98tPzS6vo+Krh//w55r/aYF2DERgCcDwNJPc4Js7gBzlTrXtfiQ+iqtFw=
=VO2l
-----END PGP SIGNATURE-----
