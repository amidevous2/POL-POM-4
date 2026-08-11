#!/bin/bash
# Date : (2009-06-13)
# Last revision : (2010-04-15)
# Wine version used : 1.1.42
# Distribution used to test : Debian Sid
# Author : Berillions
#
# CHANGELOG
# [Berillions] (2009-06-13)
#   First script.
# [Berillions] (2010-04-15)
# [Dadu042] (2019-11-25)
#   Wine 1.1.43 (outdated) -> 3.0.3 (untested).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
Title="F.E.A.R"
Prefix="F.E.A.R"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_WAIT_CP="Preparation de l'installation"
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera terminée\nsous peine de devoir recommencer l'installation."
LNG_WAIT_WMF="Appuyez sur \"Suivant\" pour commencer l'installation des codecs sons."
LNG_MEM="La taille de votre mémoire graphique?"
else
LNG_WAIT_CP="Preparation of Installation"
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_WAIT_WMF="Click on \"Next\" to install sound codecs."
LNG_MEM="How much memory do your graphic card have got?"
fi
 
# Presentation
cd $REPERTOIRE/tmp
rm *.jpg
wget http://upload.wikimedia.org/wikipedia/en/1/15/FEAR_DVD_box_art.jpg --output-document="$REPERTOIRE/tmp/$Prefix.jpg"
convert "$REPERTOIRE/tmp/$Prefix.jpg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpg"
 
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpg"
POL_SetupWindow_presentation "$Title" "Monolith Productions" "http://www.whatisfear.com/" "Berillions" "$Prefix"
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

# Install Wine
POL_SetupWindow_install_wine "3.0.3"
#Use_WineVersion "1.1.42"
 
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
#POL_SetupWindow_prefixcreate
 
# Fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
 
 #Install Directx9
POL_Call POL_Install_d3dx9
 
# Setup Wine
Set_OS winxp
 
# Set VRAM
POL_SetupWindow_menu_list "$LNG_MEM" "$Title" "32 64 128 256 384 512 768 896 1024 2048" " "
VMS="$APP_ANSWER"
 
# Set Direct3D into the registry
cd "$WINEPREFIX/drive_c/windows/temp"
cat << EOF > OGL.reg
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"VideoMemorySize"="$VMS"
"OffscreenRenderingMode"="fbo"
EOF
regedit OGL.reg

# Set fonts
cat << EOF > Fonts50.reg
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Hardware Profiles\\Current\\Software\\Fonts]
"LogPixels"=dword:00000050
EOF
regedit Fonts50.reg
 
POL_SetupWindow_wait_next_signal "Installing Game" "$Title"
cd $CDROM
wine ./setup.exe
POL_SetupWindow_detect_exit 

POL_SetupWindow_message "$LNG_WAIT_WMF" "$Title"

POL_SetupWindow_wait_next_signal "Installing WMFADist.exe" "$Title"
cd "$CDROM/support"
wine ./WMFADist.exe
POL_SetupWindow_detect_exit
 
POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
 
# Make icon
cd "$REPERTOIRE/tmp"
wget http://sd-1.archive-host.com/membres/images/51568577817080088/FEAR.jpg
mv "$REPERTOIRE/tmp/FEAR.jpg" "$REPERTOIRE/icones/32/$Title"
 
POL_SetupWindow_make_shortcut "$Prefix" "$PROGRAMFILES/Sierra/FEAR" "FEAR.exe" "" "$Title"

# Set Fonts
cd "$WINEPREFIX/drive_c/windows/temp"
cat << EOF > Fonts60.reg
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Hardware Profiles\\Current\\Software\\Fonts]
"LogPixels"=dword:00000060
EOF
regedit Fonts60.reg
 
Set_WineVersion_Assign "3.0.3" "$Title"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXrAqIQAKCRDlMfrJqhPK
R+IWAJsFcF++kWSA2Ir9J97Pl3/NYhb8iwCeIdqLfLPb5eLp7C9HV0YCIEpt45g=
=dUcw
-----END PGP SIGNATURE-----
