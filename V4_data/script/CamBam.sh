#!/usr/bin/env playonlinux-bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "CamBam" "cambam.info"
 
POL_System_TmpCreate "CamBam"
POL_Call POL_Install_dotnet40
Set_OS "winxp"
Set_Desktop "On" "1024" "768"
POL_Wine_OverrideDLL "native" "msvcrt"
POL_Wine_OverrideDLL "builtin" "d3d8"
POL_Wine_OverrideDLL "builtin" "d3d9"
POL_Wine_OverrideDLL "native" "d3dim"
POL_Wine_OverrideDLL "native" "d3drm"
POL_Wine_OverrideDLL "native" "d3dx8"
POL_Wine_OverrideDLL "native" "d3dx9_24"
POL_Wine_OverrideDLL "native" "d3dx9_25"
POL_Wine_OverrideDLL "native" "d3dx9_26"
POL_Wine_OverrideDLL "native" "d3dx9_27"
POL_Wine_OverrideDLL "native" "d3dx9_28"
POL_Wine_OverrideDLL "native" "d3dx9_29"
POL_Wine_OverrideDLL "native" "d3dx9_30"
POL_Wine_OverrideDLL "native" "d3dx9_31"
POL_Wine_OverrideDLL "native" "d3dx9_32"
POL_Wine_OverrideDLL "native" "d3dx9_33"
POL_Wine_OverrideDLL "native" "d3dx9_34"
POL_Wine_OverrideDLL "native" "d3dx9_35"
POL_Wine_OverrideDLL "native" "d3dx9_36"
POL_Wine_OverrideDLL "native" "d3dx9_37"
POL_Wine_OverrideDLL "native" "d3dx9_38"
POL_Wine_OverrideDLL "native" "d3dx9_39"
POL_Wine_OverrideDLL "native" "d3dx9_40"
POL_Wine_OverrideDLL "native" "d3dx9_41"
POL_Wine_OverrideDLL "native" "d3dx9_42"
POL_Wine_OverrideDLL "native" "d3dx10_33"
POL_Wine_OverrideDLL "native" "d3dx10_34"
POL_Wine_OverrideDLL "native" "d3dx10_35"
POL_Wine_OverrideDLL "native" "d3dx10_36"
POL_Wine_OverrideDLL "native" "d3dx10_37"
POL_Wine_OverrideDLL "native" "d3dx10_38"
POL_Wine_OverrideDLL "native" "d3dx10_39"
POL_Wine_OverrideDLL "native" "d3dx10_40"
POL_Wine_OverrideDLL "native" "d3dx10_41"
POL_Wine_OverrideDLL "native" "d3dx10_42"
POL_Wine_OverrideDLL "native" "d3dxof"
POL_Wine_OverrideDLL "native" "dciman32"
POL_Wine_OverrideDLL "native" "ddrawex"
POL_Wine_OverrideDLL "native" "devenum"
POL_Wine_OverrideDLL "builtin" "dinput"
POL_Wine_OverrideDLL "builtin" "dinput8"
POL_Wine_OverrideDLL "native" "dmband"
POL_Wine_OverrideDLL "native" "dmcompos"
POL_Wine_OverrideDLL "native" "dmime"
POL_Wine_OverrideDLL "native" "dmloader"
POL_Wine_OverrideDLL "native" "dmscript"
POL_Wine_OverrideDLL "native" "dmstyle"
POL_Wine_OverrideDLL "native" "dmsynth"
POL_Wine_OverrideDLL "native" "dmusic"
POL_Wine_OverrideDLL "native" "dmusic32"
POL_Wine_OverrideDLL "native" "dnsapi"
POL_Wine_OverrideDLL "native" "dplay"
POL_Wine_OverrideDLL "native" "dplayx"
POL_Wine_OverrideDLL "native" "dpnaddr"
POL_Wine_OverrideDLL "native" "dpnet"
POL_Wine_OverrideDLL "native" "dpnhpast"
POL_Wine_OverrideDLL "native" "dpnlobby"
POL_Wine_OverrideDLL "builtin" "dsound"
POL_Wine_OverrideDLL "native" "dswave"
POL_Wine_OverrideDLL "native" "dxdiagn"
POL_Wine_OverrideDLL "native" "msdmo"
POL_Wine_OverrideDLL "native" "qcap"
POL_Wine_OverrideDLL "native" "quartz"
POL_Wine_OverrideDLL "native" "streamci"
POL_Wine_OverrideDLL "native" "mscoree"
 
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "CamBam"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://www.cambam.info/downloads/CamBamPlus-1.0.msi"
    INSTALLER="$POL_System_TmpDir/CamBamPlus-1.0.msi"
fi
 
POL_Wine_SelectPrefix "CamBam"
POL_Wine_PrefixCreate
 
POL_SetupWindow_wait "Installation in progress." "CamBam installation"
POL_Wine "$INSTALLER"
 
POL_System_TmpDelete
 
POL_Shortcut "CamBam.exe" "CamBam"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCY+rKDwAKCRDlMfrJqhPK
R8TcAJ9Cq7ZJmAHIixRb4sbIRz1bDUtzRwCdG7D3drKs5P4Mq0vN1GnLoRCH0d4=
=p2rq
-----END PGP SIGNATURE-----
