#!/usr/bin/env playonlinux-bash
# Date : (2013-09-29)
# Last revision : (2019-12-11 02-23)
# Distribution used to test : Linux Mint 19.2 Cinnamon - 64-bit
# Author : Michael Weimann
# PlayOnLinux : 4.3.4

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="ElsterFormular"
PREFIX="ElsterFormular"
WINEVERSION="4.0.3"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1838
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "ELSTER ®" "https://www.elster.de/elfo_home.php" "Michael Weimann" "$PREFIX"

POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_corefonts
POL_Call POL_Install_vcrun2012
POL_Call POL_Install_vcrun2013
POL_Call POL_Install_vcrun2019

#Set_OS "win10"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "Please select the installation file to run." "$TITLE installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    POL_SetupWindow_menu "Select version: | Version auswählen:" "$TITLE" "Privatanwender|Unternehmer/Selbständige/Arbeitgeber|Komplett" "|"
    if [ "$APP_ANSWER" = "Privatanwender" ]; then
        MSIFileName="ElsterFormularPrivat.msi"
    elif [ "$APP_ANSWER" = "Unternehmer/Selbständige/Arbeitgeber" ]; then
        MSIFileName="ElsterFormularUnternehmerSelbstaendige.msi"
    elif [ "$APP_ANSWER" = "Komplett" ]; then
        MSIFileName="ElsterFormularKomplett.msi"
    fi
    POL_Download "https://download.elster.de/aktuell/$MSIFileName" ""
    INSTALLER="$POL_System_TmpDir/$MSIFileName"
fi

ARGS=()
case "$INSTALLER" in
*.exe)
    ARGS+=("start" "/unix")
    ;;
*.msi)
    ARGS+=("msiexec" "/i")
    ;;
esac

POL_Wine_WaitBefore "$TITLE"
POL_Wine "${ARGS[@]}" "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "pica.exe" "$TITLE" "" "" "Office;Tax;"

cd "$WINEPREFIX/drive_c"
POL_Download "https://download.elster.de/download/anleitung/Handbuch_ElsterFormular.pdf"
POL_Shortcut_Document "$TITLE" "$WINEPREFIX/drive_c/Handbuch_ElsterFormular.pdf"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXfDGSwAKCRDlMfrJqhPK
R5K9AJwOWTOWjmRvBERs4WDBLcYHT7MJ9ACcCluxPpQ7hLY1E1A7R6MXohN4Few=
=fflH
-----END PGP SIGNATURE-----
