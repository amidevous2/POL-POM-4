#!/usr/bin/env bash
 
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
WINE_VERSION="6.15-staging"
TITLE="iSpy surveilance system"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "iSpy surveilance system" "iSpy" "https://www.ispyconnect.com" "Kukulo" "iSPY surveillance system"
POL_Wine_SelectPrefix "iSPY"
POL_Wine_PrefixCreate "$WINE_VERSION"
POL_System_TmpCreate "GENERAL_IE_OCX"
POL_Call POL_Install_mfc42
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ] 
then
        cd "$POL_System_TmpDir"
        POL_Download "https://ispyfiles.azureedge.net/downloads/iSpy_7_2_1_0.zip" "f66ffbb738c96e6d069007151e21c317"
        POL_Wine_WaitBefore "$TITLE"
        POL_System_unzip "$POL_System_TmpDir/iSpy_7_2_1_0.zip"
        POL_Wine "$POL_System_TmpDir/iSpySetup.exe"
elif [ "$INSTALL_METHOD" = "LOCAL" ] 
then
          POL_SetupWindow_browse "$(eval_gettext 'Please select the install file.')" "$TITLE"
        SETUP_PATH="$APP_ANSWER"
         POL_Wine_WaitBefore "$TITLE"
        POL_Wine "$SETUP_PATH"
fi
 
POL_Wine_WaitExit "$TITLE"
POL_Call POL_Install_dotnet45
POL_Shortcut "iSpy.exe" "iSpy Surveilance system"
POL_System_TmpDelete
Set_OS "win7"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYTM6CQAKCRDlMfrJqhPK
Ry0aAJ9hz4UVY/hUfWTtOudyv2i2/C8a+wCeMKaYJl+NXI6ILmPWNFIpvDNX3Co=
=lPQr
-----END PGP SIGNATURE-----
