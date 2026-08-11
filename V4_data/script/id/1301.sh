#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Logiciels concours Centrale Supelec"
WINEVERSION="1.7.26"
EDITOR="Various"
EDITOR_URL=""
PREFIX="CentraleSupelecPack"
TITLEc="Centrale Supelec"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "Quentin PÂRIS" "$PREFIX"
POL_SetupWindow_message "Notice: This script was made for a personal use. It might help students\n\nIt will install various programs for you." "$TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_LunaTheme

cd "$WINEPREFIX/drive_c" || POL_Debug_Fatal "Unable to go to the prefix"

install_part ()
{
	mkdir -p "$WINEPREFIX/drive_c/$1"
	cd "$WINEPREFIX/drive_c/$1" || POL_Debug_Error "Unable to change dir to $1"
	POL_Download "$2" "$3"
	POL_Wine_WaitBefore "$1"
	unzip "$4"
	cp DLL_VB_XP/* ./ || POL_Debug_Error "Unable to copy DLLs for $1. It might not work"
}

install_part "DeOSt" "http://www.lgep.supelec.fr/uploads/scm/logiciels/DeOSt.zip" "fffeead77d5a868621f95561e7300c5e" "DeOSt.zip"

install_part "Optigeo" "http://www.lgep.supelec.fr/uploads/scm/logiciels/Optigeo.zip" "0a1beb816a15511c8be55b4708c933ef" "Optigeo.zip"

install_part "Diffint" "http://www.lgep.supelec.fr/uploads/scm/logiciels/Diffint.zip" "8bd32cd3a3118be097263c90bec072bc" "Diffint.zip"

install_part "Anharm" "http://www.lgep.supelec.fr/uploads/scm/logiciels/Anharm.zip" "8fb3f74bb3abd236f29c9266b0ed17bd" "Anharm.zip"

install_part "Equadif" "http://www.lgep.supelec.fr/uploads/scm/logiciels/Equadif.zip" "3c44f8df9c567481b2073783c49dc37d" "Equadif.zip" 

install_part "Courbes" "http://www.lgep.supelec.fr/uploads/scm/logiciels/Courbes.zip" "f6a04a7bf8434c31ae1c164bf2a03cea" "Courbes.zip"

#cd "$WINEPREFIX/drive_c"

#POL_Download "http://www.jymagna.com/huc.exe" "f9b3a0fc0cc46a014ea0e59802880dc3"
#POL_Wine_WaitBefore "Huckel 95"
#POL_Wine "huc.exe"

#POL_Download "http://www.jymagna.com/G2D.exe" "f4dbc06d84168e1f22a3412ca839d959"
#POL_Wine_WaitBefore "Graphe 2D"
#POL_Wine "G2D.exe"

POL_Shortcut "deostv2.exe" "$TITLEc - DeOSt"
POL_Shortcut "optigeo_E11.exe" "$TITLEc - Optigeo"
POL_Shortcut "diffint_E13.exe" "$TITLEc - Diffint"
POL_Shortcut "anHarm_V2_E13.exe" "$TITLEc - Anharm"
POL_Shortcut "Equadif_E13.exe" "$TITLEc - Equadif"
POL_Shortcut "Courbes_E13.exe" "$TITLEc - Courbes"

#POL_Shortcut "Huckel95.exe" "$TITLEc - Huckel 95"
#POL_Shortcut "Graphe_2D.exe" "$TITLEc - Graphe 2D"


POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlwO4XkACgkQ5TH6yaoTykeKSACgpl4UCmzqKRpgnglj7XtDPLDA
ZqAAoK9TSH5RBcpWt84tjfTJt6ZLnSPu
=cdBj
-----END PGP SIGNATURE-----
