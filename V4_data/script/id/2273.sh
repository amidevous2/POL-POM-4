#!/usr/bin/env playonlinux-bash
# Date : (2015-03-07)
# Last revision : (2021-04-12)
# Wine version used : 5.0.4
# Distribution used to test : Linux Mint 20.1 Cinnamon
# Author : see changelog
# PlayOnLinux : 4.3.4
#
# CHANGELOG
# [Yaotl] (2021-04-09)
#   Completely revised.
# [jadedcyborg] (2017-04-18)
#   Completely revised.
# [edgimar] (2019-05-10)
#   First script.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="PDF-XChange Viewer"
PREFIX="pdfxcview"
WINEVERSION="5.0.4"
DOWNLOAD_URL="https://downloads.pdf-xchange.com/PDFXVwer.exe"
#MD5_CHECKSUM=""
EXE_NAME="PDFXVwer.exe"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2273
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Tracker Software Products" "https://www.tracker-software.com/product/pdf-xchange-viewer" "POL & POM Community" "$PREFIX"

POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_corefonts

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOAD_URL" #"$MD5_CHECKSUM"
    INSTALLER="$POL_System_TmpDir/$EXE_NAME"
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"

POL_System_TmpDelete
POL_Shortcut "PDFXCview.exe" "$TITLE" #"" "" "Office;PDF;"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYHgBowAKCRDlMfrJqhPK
R9CZAJ4huf8utONWAhvaBN43/yUzApTGoQCeKwfZ/yO76mzZm8UVPPW57bJuAG8=
=YPKU
-----END PGP SIGNATURE-----
