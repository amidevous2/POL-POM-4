#!/bin/bash
#Date : (2011-05-18)
# Last revision : (2011-05-21)
# Wine version used : 2.22
# Distribution used to test : Opensuse 11.4 64 bits
# Author : Ang1fr
 
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
 
TITLE="Perfect World International"
TITLE1="Update Perfect World International"
PREFIX="PerfectWorld"
WORKING_WINE_VERSION="2.22"
 
rm "$REPERTOIRE/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/PWI/top.jpg" "http://files.playonlinux.com/resources/setups/PWI/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages

POL_SetupWindow_presentation "$TITLE" "Perfect World Entertainment" "http://www.perfectworld.com" "Ang1fr" "$PREFIX"
 
if [ "$POL_LANG" == "fr" ] ; then
CHOOSE="Sélectionner le fichier client Perfect World"
INSTALLATION="Veillez patienter pendant l'installation..."
GAME_VMS="Quelle est la taille de votre mémoire vidéo ?"
END="$TITLE à été installé avec succès !"
else #English messages
CHOOSE="Select the client file Perfect World."
INSTALLATION="Please wait during the installation..."
GAME_VMS="How much video ram is ?"
END="$Title installation is a succes ! "
fi
 
# Use current wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"
 
select_prefixe "$REPERTOIRE/wineprefix/$PREFIX/"
 
#Installing mandatory dependencies
POL_Call POL_Install_vcrun6
 
#Installation
POL_SetupWindow_browse "$CHOOSE" "$TITLE"
 
SETUP_EXE="$APP_ANSWER"
wine start /unix "$SETUP_EXE"
POL_SetupWindow_message "$INSTALLATION" "$TITLE"
 
#asking about memory size of graphic card
POL_SetupWindow_menu_list "$GAME_VMS" "$TITLE" "128-256-320-384-512-640-768-896-1024-1792-2048" "-" "256"
VMS="$APP_ANSWER"
 
cd "$PREFIX/drive_c/windows/temp/"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg
 
#Setting mandatory wine modifications
cd $REPERTOIRE/tmp/
echo "[HKEY_CURRENT_USER\Software\Wine\DirectSound]" > $REPERTOIRE/tmp/directsound.reg
echo "\"DefaultSampleRate\"=\"48000\"" >> $REPERTOIRE/tmp/directsound.reg
regedit $REPERTOIRE/tmp/directsound.reg
 
echo "[HKEY_CURRENT_USER/Software/Wine/Drivers]" > $REPERTOIRE/tmp/Drivers.reg
echo "\"Audio\"=\"alsa\"" >> $REPERTOIRE/tmp/Drivers.reg
regedit $REPERTOIRE/tmp/Drivers.reg
 
 
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > "$REPERTOIRE/tmp/Direct3D.reg"
echo "\"DirectDrawRenderer\"=\"opengl\"" >> "$REPERTOIRE/tmp/Direct3D.reg"
echo "\"Nonpower2Mode \"=\"repack\"" >> "$REPERTOIRE/tmp/Direct3D.reg"
echo "\"OffscreenRenderingMode\"=\"fbo\"" >> "$REPERTOIRE/tmp/Direct3D.reg"
echo "\"PixelShaderMode\"=\"enabled\"" >> "$REPERTOIRE/tmp/Direct3D.reg"
echo "\"RenderTargetLockMode\"=\"auto\"" >> "$REPERTOIRE/tmp/Direct3D.reg"
echo "\"UseGLSL\"=\"disabled\"" >> "$REPERTOIRE/tmp/Direct3D.reg"
regedit "$REPERTOIRE/tmp/Direct3D.reg"
 
 
POL_SetupWindow_auto_shortcut "$PREFIX" "Launcher.exe" "$TITLE" "$TITLE.png" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_auto_shortcut "$PREFIX" "patcher.exe" "$TITLE1" "$TITLE.png" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE1"
 
POL_SetupWindow_message "$END"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcnMWQAKCRDlMfrJqhPK
R95cAKCNHuQm7BaVyvCLroJ8xRcOhebV0wCfX/NnCtTt5P6hnsl4hrDUu/ym800=
=9zTb
-----END PGP SIGNATURE-----
