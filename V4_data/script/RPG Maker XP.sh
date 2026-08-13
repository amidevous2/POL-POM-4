#!/bin/bash
# Date                      : (2018-08-18)
# Last revision             : (2018-08-19)
# Wine version used         : 3.13
# Distribution used to test : Ubuntu 18.04.1 LTS
# Author                    : jelle619, based of ntzrmtthihu777's script
# Testers                   : jelle619

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="RPG Maker XP"
PREFIX="RPG_XP"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Enterbrain" "http://www.rpgmakerweb.com/" "ntzrmtthihu777" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.14"
POL_System_SetArch "x86"

POL_System_TmpCreate "$PREFIX"

# Install & configure libraries
POL_Call POL_Install_dinput
POL_Call POL_Install_dinput8
POL_Call POL_Install_directmusic
POL_Call POL_Install_directplay
POL_Call POL_Install_directx9
POL_Call POL_Install_dotnet20
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_gdiplus
POL_Call POL_Install_RegisterFonts
POL_Call POL_Install_ie6
POL_Wine_OverrideDLL "native,builtin" "d3d8" "d3d9"

# Fetch the program from the official source and install it
cd "$POL_System_TmpDir"
POL_Download "https://s3.amazonaws.com/prodcartassets/20/RPGXP_E.exe"
POL_SetupWindow_wait "Installation in progress." "$TITLE RTP installation"
POL_Wine start /unix "$POL_System_TmpDir/RPGXP_E.exe"
POL_Wine_WaitExit "RPGXP_E.exe"
POL_Wine_reboot

# Create a shortcut
POL_Shortcut "RPGXP.exe" "$TITLE"
POL_System_TmpDelete
POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPKt4wAKCRDlMfrJqhPK
R0rtAJ4qyjS36cWKmx+3yAzvc6/2uZG3owCfWeSyGv/ZJDMSHsDIvV6Tsd5kQJg=
=rGn5
-----END PGP SIGNATURE-----
