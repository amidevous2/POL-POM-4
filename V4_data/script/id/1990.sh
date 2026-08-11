#!/bin/bash
# Date : (2014-03-04 09:55)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Xubuntu 20.04
# Author : Grolm
 
# CHANGELOG
#
# --- 2014-03-10 ---
# Add UserSettings creation for liveeu beside live in Documents
# Point to temporary hosted top.png and left.png (googleusercontent.com)
#
# --- 2014-03-11 ---
# Add missing eval_gettext
#
# Move Prefix creation after setup download/selection
#
# Remove POL_Wine_WaitExit and start /unix
#
# Remove png icon extraction
#
# Add a check before CA installation on /usr/share/ca-certificates and
# /etc/ca-certificates.conf. Ask for CA manual installation if test failed.
#
# --- 2014-03-21 ---
# Point to realease Installer instead of Beta one.
#
# Move Certificate installation before setup as setup now directly runs the launcher
#
# Certificate installation download the certificate from tbs.
#
# Dirty hack to wait for setup to finish but do not wait for launcher.
#
# Minor text improvments
#
# --- 2014-04-01 ---
# Udpate Certificate installation to support fedora based distributions
#
# --- 2014-04-04 ---
# Switch to wine 1.7.15
# Install certificate in prefix registry instead on linux system
#
# --- 2014-04-07 --- (Wine 1.7.15, Xubuntu 13.10 and Fedora 20)
# Run tested on Xubuntu 13.10 : run at 50 FPS with a Quad core Intel Core i7-2600K CPU with a NVIDIA GF104 [GeForce GTX 460] GPU at 1920x1080 with NVIDIA driver 331.20.
#
# Add POL_Debug_Init after POL_SetupWindow_Init
# Change Prefix from TESO to TheElderScrollsOnline
# Change default user settings to have a more stable game
#
# --- 2020-10-12 Dadu042 ---
# Wine 1.7.15 -> 3.0.3 (max stable version allowed by POL v4.2). Installer now does start, not tested further.
# Note: perhaps removing the "  " of the strings following cert.reg may help.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="The Elder Scrolls Online"
PREFIX="TheElderScrollsOnline"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Grolm"
GAME_VMS="512"
GAME_URL="http://elderscrollsonline.com"
GAME_EDITOR="Bethesda (Zenimax online)"
SETUP="Install_ESO.exe"
SETUP_URL="https://elderscrolls-a.akamaihd.net/products/BNA_Launcher/${SETUP}"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1990
POL_Debug_Init
 
# Presentation
POL_SetupWindow_presentation \
    "${TITLE}" \
    "${GAME_EDITOR}" \
    "${GAME_URL}" \
    "Grolm" \
    "${PREFIX}"
 
# Select Install Method
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
# Create Temp space
POL_System_TmpCreate "${PREFIX}"
 
# Installation
if [ "${INSTALL_METHOD}" = "LOCAL" ]
then
    cd "${HOME}"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the installation file to run.')" "${TITLE} installation"
    SETUP_FILE="${APP_ANSWER}"
else
    cd "${POL_System_TmpDir}"
    POL_Download "${SETUP_URL}"
    SETUP_FILE="${POL_System_TmpDir}/${SETUP}"
fi
 
[ -f "${SETUP_FILE}" ] || exit 1

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"


# Dependencies
POL_Call POL_Install_vcrun2010
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS ${GAME_VMS}
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
 
# Thawte's certificate installation
cd "${POL_System_TmpDir}"
cat <<EOF > cert.reg
[HKEY_LOCAL_MACHINE\Software\Microsoft\SystemCertificates\My\Certificates\808D62642B7D1C4A9A83FD667F7A2A9D243FB1C7]
"Blob"=hex:03,00,00,00,01,00,00,00,14,00,00,00,80,8d,62,64,2b,7d,1c,4a,9a,83,\
  fd,66,7f,7a,2a,9d,24,3f,b1,c7,20,00,00,00,01,00,00,00,a0,04,00,00,30,82,04,\
  9c,30,82,03,84,a0,03,02,01,02,02,10,47,97,4d,78,73,a5,bc,ab,0d,2f,b3,70,19,\
  2f,ce,5e,30,0d,06,09,2a,86,48,86,f7,0d,01,01,05,05,00,30,81,a9,31,0b,30,09,\
  06,03,55,04,06,13,02,55,53,31,15,30,13,06,03,55,04,0a,13,0c,74,68,61,77,74,\
  65,2c,20,49,6e,63,2e,31,28,30,26,06,03,55,04,0b,13,1f,43,65,72,74,69,66,69,\
  63,61,74,69,6f,6e,20,53,65,72,76,69,63,65,73,20,44,69,76,69,73,69,6f,6e,31,\
  38,30,36,06,03,55,04,0b,13,2f,28,63,29,20,32,30,30,36,20,74,68,61,77,74,65,\
  2c,20,49,6e,63,2e,20,2d,20,46,6f,72,20,61,75,74,68,6f,72,69,7a,65,64,20,75,\
  73,65,20,6f,6e,6c,79,31,1f,30,1d,06,03,55,04,03,13,16,74,68,61,77,74,65,20,\
  50,72,69,6d,61,72,79,20,52,6f,6f,74,20,43,41,30,1e,17,0d,31,30,30,32,30,38,\
  30,30,30,30,30,30,5a,17,0d,32,30,30,32,30,37,32,33,35,39,35,39,5a,30,4a,31,\
  0b,30,09,06,03,55,04,06,13,02,55,53,31,15,30,13,06,03,55,04,0a,13,0c,54,68,\
  61,77,74,65,2c,20,49,6e,63,2e,31,24,30,22,06,03,55,04,03,13,1b,54,68,61,77,\
  74,65,20,43,6f,64,65,20,53,69,67,6e,69,6e,67,20,43,41,20,2d,20,47,32,30,82,\
  01,22,30,0d,06,09,2a,86,48,86,f7,0d,01,01,01,05,00,03,82,01,0f,00,30,82,01,\
  0a,02,82,01,01,00,b7,8b,cf,75,5b,9f,25,da,7e,39,b0,93,db,38,d3,a9,23,d0,82,\
  fa,e9,24,7e,5c,0b,8e,83,f8,e6,7a,59,e6,a3,c5,98,a7,99,d2,44,ff,00,a6,a5,39,\
  04,8a,da,29,88,ea,db,a2,f3,1c,99,15,26,c2,b1,f4,fc,e1,0c,47,a9,09,11,06,0a,\
  20,92,b9,c7,a0,04,8c,5c,94,19,ab,5b,25,2c,1d,62,7e,70,0d,ce,61,6c,dd,2b,82,\
  c9,ce,5d,48,5f,f7,c2,be,bc,41,23,1e,4f,29,5d,d7,4f,bc,f4,c5,2a,fc,63,e6,7c,\
  26,4e,99,a7,79,41,9e,10,4a,7a,79,c9,c6,86,f7,86,95,d2,26,ce,3c,18,2a,d6,7c,\
  ce,af,cd,ad,bb,f7,82,2c,70,26,37,45,e5,0f,47,22,c6,01,28,bd,2e,83,5c,6a,a4,\
  47,c1,e7,d0,d8,6b,81,46,3f,21,17,f5,07,c5,43,5a,a6,67,2c,b8,7b,60,11,b5,83,\
  ee,f5,74,0a,72,71,44,3d,58,fe,e8,1a,ab,38,c3,59,db,7f,6e,38,7d,76,c7,72,69,\
  98,36,96,57,d3,66,1c,d2,54,91,04,2e,54,19,b0,dc,3d,b5,22,5e,86,d5,2a,7e,20,\
  df,5d,e6,7a,b1,65,fe,c5,02,4e,31,2d,02,03,01,00,01,a3,82,01,1c,30,82,01,18,\
  30,12,06,03,55,1d,13,01,01,ff,04,08,30,06,01,01,ff,02,01,00,30,34,06,03,55,\
  1d,1f,04,2d,30,2b,30,29,a0,27,a0,25,86,23,68,74,74,70,3a,2f,2f,63,72,6c,2e,\
  74,68,61,77,74,65,2e,63,6f,6d,2f,54,68,61,77,74,65,50,43,41,2e,63,72,6c,30,\
  0e,06,03,55,1d,0f,01,01,ff,04,04,03,02,01,06,30,32,06,08,2b,06,01,05,05,07,\
  01,01,04,26,30,24,30,22,06,08,2b,06,01,05,05,07,30,01,86,16,68,74,74,70,3a,\
  2f,2f,6f,63,73,70,2e,74,68,61,77,74,65,2e,63,6f,6d,30,1d,06,03,55,1d,25,04,\
  16,30,14,06,08,2b,06,01,05,05,07,03,02,06,08,2b,06,01,05,05,07,03,03,30,29,\
  06,03,55,1d,11,04,22,30,20,a4,1e,30,1c,31,1a,30,18,06,03,55,04,03,13,11,56,\
  65,72,69,53,69,67,6e,4d,50,4b,49,2d,32,2d,31,30,30,1d,06,03,55,1d,0e,04,16,\
  04,14,d4,0d,65,3f,7a,bd,34,c6,fe,47,e7,4c,0d,c0,bd,f2,de,15,ab,71,30,1f,06,\
  03,55,1d,23,04,18,30,16,80,14,7b,5b,45,cf,af,ce,cb,7a,fd,31,92,1a,6a,b6,f3,\
  46,eb,57,48,50,30,0d,06,09,2a,86,48,86,f7,0d,01,01,05,05,00,03,82,01,01,00,\
  56,fe,53,5c,e1,c7,9e,bc,a7,ed,7e,53,6d,6a,14,4b,51,8c,40,5e,80,5f,aa,a4,e8,\
  2f,ef,38,c8,04,c9,ca,3e,cf,df,3a,58,4e,b0,d4,b6,63,c5,29,57,fa,02,05,9a,45,\
  4d,68,db,2a,1b,d4,34,3d,9f,00,c3,5a,cb,95,49,a5,6e,e1,b0,c5,fc,41,4d,41,4a,\
  6f,d3,77,c8,d7,38,8d,e4,19,de,18,f3,1f,15,65,83,6d,45,0c,53,f9,0a,9a,2e,a5,\
  5d,bf,6f,32,81,18,92,19,6a,55,00,ad,63,1c,52,06,7e,55,d9,29,68,ae,4a,7c,18,\
  9a,79,88,6b,23,23,d8,27,38,2a,29,87,76,ca,fb,c7,b6,62,23,1f,ed,7a,56,4c,dd,\
  9c,32,5b,f5,3d,0c,46,18,95,3b,2a,23,68,83,64,41,d9,00,6d,0f,19,24,15,68,72,\
  bd,c5,71,67,6e,ac,4c,db,90,eb,51,a5,1a,62,07,d0,be,6a,00,47,3c,72,2f,ec,4f,\
  61,3e,73,85,ce,5a,0a,b7,ba,c0,1c,13,75,e3,22,39,28,dd,6d,1d,09,46,9d,4f,ba,\
  e8,40,81,91,c6,a4,ce,94,72,1b,01,cf,2a,6e,15,67,95,89,ae,7d,b7,b7,cd,f9,0a,\
  3d,75,b6,6b,3c,25
EOF
regedit cert.reg
 
# Point My Documents to Documents and create default configuration for OPENGL
mkdir -p "${HOME}/Documents/Elder Scrolls Online/live"{,eu}
cat <<EOF > "${HOME}/Documents/Elder Scrolls Online/live/UserSettings.txt"
SET GraphicsDriver.7 "OPENGL"
SET RequestedNumThreads "0"
SET BACKGROUND_AUDIO "1"
EOF
cp "${HOME}/Documents/Elder Scrolls Online"/live{,eu}/UserSettings.txt
rm -rf "${WINEPREFIX}/drive_c/users/${USER}/My Documents"
ln -sf "${HOME}/Documents" "${WINEPREFIX}/drive_c/users/${USER}/My Documents"
 
# Setup
POL_SetupWindow_message \
    "$(eval_gettext "Follow default setup up to the 'Installation Options' screen, then:\n 1. Select your region.\n 2. Leave only checked the DirectX checkbox.")" \
    "${TITLE}"
 
POL_Wine_WaitBefore "${TITLE}"
POL_Wine start /unix "${SETUP_FILE}"
sleep 5
# Wait for the Setup to exit. It is a dirty way to do it but POL_Wine without
# start /unix never exit. And with it the POL_Wine_WaitExit method does not work
# with the new eso setup either.
while ps -C "${SETUP}" && ! ps -C "Bethesda.net_Launcher.exe"
do
    echo "Waiting for ${SETUP_FILE} process to finish or Launcher to start."
    sleep 1
done
 
# Remove Windows desktop lnk
rm "${WINEPREFIX}/drive_c/users/${USER}/Desktop/${TITLE}"*.lnk
 
# Create Shortcut
POL_Shortcut \
    "Bethesda.net_Launcher.exe" \
    "${TITLE}" \
    "${TITLE}.png" \
    "" \
    "Game;RolePlaying;"
 
# Remove Temp Space
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX4R4WwAKCRDlMfrJqhPK
R8PyAJ0eQl1BR96iZk6fJ51uiq3B19ypSACfddJ02vKkZSCoy5DMKQU9X9X0smk=
=knTR
-----END PGP SIGNATURE-----
