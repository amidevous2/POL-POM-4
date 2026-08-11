#!/bin/bash
# Date : (200?-??-?? ??-??)
# Last revision : (2009-06-08 13-05)
# Wine version used : ?
# Distribution used to test : ?
# Author : otty
# Licence : ?
# Depend : unzip

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

if [ "$POL_LANG" == "fr" ]; then
LNG_DX9_DL="Téléchargement de la mise a jour DirectX9.0c pour Wine..."
LNG_DX9_FIX="Téléchargement des correctifs DirectX pour ce jeu..."
LNG_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?\n(minimum pour ce jeu : 256)"
LNG_WARNING_VMS="Ce jeu ne fonctionnera correctement qu'avec une\ncarte graphique ayant plus de 64Mo de mémoire."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu\nsera terminée sous peine de devoir recommencer l'installation." 
elif [ "$POL_LANG" == "de" ]; then 
LNG_DX9_DL="Lade Wine DirectX9.0c Update herunter..."
LNG_DX9FIX_DL="Lade Wine DirectX9.0c Fix herunter..."
LNG_WAIT_END="Klicke ERST auf \"Weiter\" wenn die Spielinstallation abgeschlossen ist. Ansonsten muss die Installation wiederholt werden.\nDie Microsoft .NET 2.0 Framework Installation kann fehlschlagen - dies ist aber nicht schlimm."
LNG_VMS="Wieviel Grafikspeicher besitz die Grafikkarte?(Minimum für NWN2 : 128)"
LNG_WARNING_VMS="Warnung: Die Grafikkarte hat zu wenig Speicher!"
else
LNG_DX9_DL="Downloading Wine DirectX9.0c Update..."
LNG_DX9FIX_DL="Downloading DirectX Fix..."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation.\nMicrosoft .NET 2.0 Framework installation may fail during install.\nDon't panic, this is not fatal. Just continue installation."
LNG_VMS="How much memory does your graphics board have?\n(minimum for this game : 256)"
LNG_WARNING_VMS="warning, your graphic card do not have enough memory to play this game."

fi

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

cd $REPERTOIRE/tmp
rm *.jpg
wget $SITE/setups/nwn2/left.jpg
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpg"
POL_SetupWindow_presentation "NeverWinter Nights 2" "Atari" "http://www.atari.com" "otty" "NWN2"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

select_prefixe "$REPERTOIRE/wineprefix/NWN2/"
POL_SetupWindow_prefixcreate

if [ ! -e $REPERTOIRE/ressources/ ]; then
mkdir -p $REPERTOIRE/ressources/
fi
cd $REPERTOIRE/ressources/

if [ ! -e $REPERTOIRE/ressources/D3DX9_XX_dll_\(32Bit_All\).zip ]; then
POL_SetupWindow_download "$LNG_DX9_DL" "$FULL_NAME" "http://mulx.playonlinux.com/files/D3DX9_XX_dll_(32Bit_All).zip"
fi
if [ ! -e $REPERTOIRE/ressources/microsoft.vc80.crt.zip ]; then
POL_SetupWindow_download "$LNG_DX9_DL" "Never Winter Nights 2" "http://www.sweetpotatosoftware.com/files/microsoft.vc80.crt.zip"
fi
if [ ! -e $REPERTOIRE/ressources/d3dx9_30.dll ]; then
POL_SetupWindow_download "$LNG_DX9FIX_DL" "Never Winter Nights 2" "http://theocratie.com.free.fr/dll/d3dx9_30.dll"
fi
if [ ! -e $REPERTOIRE/ressources/devenum.dll ]; then
POL_SetupWindow_download "$LNG_DX9FIX_DL" "Never Winter Nights 2" "http://theocratie.com.free.fr/dll/devenum.dll"
fi
if [ ! -e $REPERTOIRE/ressources/dxdiagn.dll ]; then
POL_SetupWindow_download "$LNG_DX9FIX_DL" "Never Winter Nights 2" "http://theocratie.com.free.fr/dll/dxdiagn.dll"
fi

cd $WINEPREFIX/drive_c/windows/temp/
unzip $REPERTOIRE/ressources/D3DX9_XX_dll_\(32Bit_All\).zip 

Set_OS "winxp"
wine c:\\windows\\temp\\D3DX9_XX_dll_\(32Bit_All\)\\Install\\DXSETUP.exe

cd $CDROM
wine setup.exe

POL_SetupWindow_message "$LNG_WAIT_END" "Never Winter Nights 2"

TEMP = "$REPERTOIRE/tmp"
echo "[HKEY_CURRENT_USER\Software\Wine\Direct3D]" > $TEMP/nwn.reg
echo "\"DirectDrawRenderer\"=\"opengl\"" >> $TEMP/nwn.reg
echo "\"OffscreenRenderingMode\"=\"fbo\"" >> $TEMP/nwn.reg
echo "\"UseGLSL\"=\"enabled\"" >> $TEMP/nwn.reg

POL_SetupWindow_menu_list "$LNG_VMS" "NWN2" "32-64-128-256-384-512-768-1024-2048" "-" "128"
VMS="$APP_ANSWER"
if [ "$VMS" -lt "128" ]; then
POL_SetupWindow_message "$LNG_WARNING_VMS" "NWN2" "$PLAYONLINUX/themes/tango/warning.png"
fi

echo "\"VideoMemorySize\"=\"$VMS\"" >> $TEMP/nwn.reg
regedit $TEMP/nwn.reg

echo "[HKEY_CURRENT_USER\Software\Wine\DllOverrides]" > $TEMP/nwn2.reg
echo "\"devenum\"=\"native,builtin\"" >> $TEMP/nwn2.reg
echo "\"dxdiagn\"=\"native,builtin\"" >> $TEMP/nwn2.reg
echo "\"d3dx9_30\"=\"native,builtin\"" >> $TEMP/nwn2.reg

regedit $TEMP/nwn2.reg

Set_Managed "On"
Set_DXGrab "On"
Set_GLSL "On" 

cd $REPERTOIRE/ressources/
unzip microsoft.vc80.crt.zip
cd ./Microsoft.VC80.CRT
cp * "$WINEPREFIX/drive_c/Program Files/Atari/Neverwinter Nights 2/"

cp -v "$REPERTOIRE/ressources/d3dx9_30.dll" "$WINEPREFIX/drive_c/Program Files/Atari/Neverwinter Nights 2/"
cp -v "$REPERTOIRE/ressources/devenum.dll" "$WINEPREFIX/drive_c/Program Files/Atari/Neverwinter Nights 2/"
cp -v "$REPERTOIRE/ressources/dxdiagn.dll" "$WINEPREFIX/drive_c/Program Files/Atari/Neverwinter Nights 2/"

POL_SetupWindow_reboot

POL_SetupWindow_make_shortcut "NWN2" "$PROGRAMFILES/Atari/Neverwinter Nights 2/" "nwn2main.exe" "nwn.ico" "NeverWinter Nights 2"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEwACgkQ5TH6yaoTykdR1ACgjEzklvys6BfvB/0mg+u/P1jh
XuMAnjgPMFXOJG86frhv/N4+9IFtjpIJ
=To0F
-----END PGP SIGNATURE-----
