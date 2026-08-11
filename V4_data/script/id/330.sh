#!/bin/bash
# Last revision : (2009-10-24 23-05)
# Distribution used to test: Archlinux
# Wine version used: 1.1.43
# Author: Kjella
# Maintener : Berillions
# Graphic Card : GeForce GTX275
# Drivers : 195.36.24

#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
FULLNAME="World in Conflict"
CODENAME="WorldInConflict"

if [ "$POL_LANG" == "fr" ]; then
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera\nterminée sous peine de devoir recommencer l'installation."
LNG_WAIT="Patientez durant l'installation"
LNG_WAIT_CP="Patientez pendant la préparation de l'installation..."
LNG_DLL="PlayOnLinux est en train de télécharger les .dll nécessairent au bon fonctionnement du jeu"
LNG_COPY="Copie de certains fichiers en cours, cela peut être long"
else
LNG_DLL="Downloading .dll"
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation
is finished or you will have to redo the installation."
LNG_WAIT="Wait during the installation"
LNG_WAIT_CP="Wait while the installation is prepared..."
LNG_COPY="Copying Data, it can be long"
fi

wget http://upload.wikimedia.org/wikipedia/en/thumb/4/48/Wic-win-cover.jpg/256px-Wic-win-cover.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"
 
#Presentation
POL_SetupWindow_presentation "$FULLNAME" "Massive Entertainment" "http://www.worldinconflict.com" "Kjella" "$CODENAME"

#Installation de Wine
POL_SetupWindow_install_wine "1.1.43"
Use_WineVersion "1.1.43"

#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

select_prefix "$REPERTOIRE/wineprefix/$CODENAME"
POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#Configuration de Wine
Set_OS winxp
 
wine "$CDROM/setup.exe"
POL_SetupWindow_message "$LNG_WAIT_END" "$FULLNAME"

# Download dlls
cd "$WINEPREFIX/drive_c/windows/system32"
if [ ! -e dxdiagn.dll ]; then
POL_SetupWindow_download "$LNG_DLL" "$FULLNAME" "http://www.depannagedisquedur.fr/dll/dxdiagn.dll"
fi

cd "$WINEPREFIX/drive_c/windows/temp"
cat << EOF > OGL.reg
#[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
#"UseGLSL"="disabled"

[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]
"d3d10"=""
"dxdiagn"="native,builtin"

#[HKEY_CURRENT_USER\Software\Wine\DirectSound]
#"DefaultBitsPerSample"="8"
#"DefaultSampleRate"="22050"
#"EmulDriver"="Y"
EOF
regedit OGL.reg

#POL_SetupWindow_message "$LNG_COPY" "$FULLNAME"
#POL_SetupWindow_wait_next_signal "Copy ..." "$FULLNAME"
#cp "$CDROM/bin/binkw32.dll" "$WINEPREFIX/drive_c/Program Files/Sierra Entertainment/World in Conflict/"
#cp "$CDROM/bin/dbghelp.dll" "$WINEPREFIX/drive_c/Program Files/Sierra Entertainment/World in Conflict/"
#cp "$CDROM/bin/mss32.dll" "$WINEPREFIX/drive_c/Program Files/Sierra Entertainment/World in Conflict/"
#cp "$CDROM/ldata/English/wicloc11.sdf" "$WINEPREFIX/drive_c/Program Files/Sierra Entertainment/World in Conflict/"
#cp "$CDROM/ldata/All/wicloc12.sdf" "$WINEPREFIX/drive_c/Program Files/Sierra Entertainment/World in Conflict/"
#POL_SetupWindow_detect_exit

#Création Icone
cd "$REPERTOIRE/tmp"
wget http://sd-1.archive-host.com/membres/images/51568577817080088/WiC.jpeg
mv "$REPERTOIRE/tmp/WiC.jpeg" "$REPERTOIRE/icones/32/$FULLNAME"

POL_SetupWindow_make_shortcut "$CODENAME" "$PROGRAMFILES/Sierra Entertainment/World in Conflict/" "wic.exe" "" "$FULLNAME"

Set_WineVersion_Assign "1.1.43" "$FULLNAME"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEoACgkQ5TH6yaoTykcvLwCffGFRCO0TONk0ndMv0UyZbJHp
tLIAn3XWJWF0Qm6z1qyZrn3ISNCldckR
=HNn2
-----END PGP SIGNATURE-----
