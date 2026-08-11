#!/usr/bin/env playonlinux-bash
# Date : (2020-10-17 16-56)
# Last revision : (2020-10-17 16-56)
# Wine version used : 5.10-staging
# Distribution used to test : Debian
# Author : Sylv1
# PlayOnLinux : 4.3.4

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
POL_SetupWindow_Init # <-- début

TITLE="Atelier Scientifique Jeulin" 
PREFIX="Atelier_Scientifique"
WINE_VERSION="5.9"
POL_System_SetArch "x86"


POL_System_TmpCreate "$PREFIX" # Création du dossier temporaire

POL_SetupWindow_presentation "$TITLE" "Jeulin" "https://www.jeulin.fr" "Sylv1" "$TITLE"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

# condition de InstallMethod choisi (début)
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Sélectionnez le fichier d'installation .zip ou .msi." "Atelier Scientifique installation"
	EXTENSION=$(echo "$APP_ANSWER" | cut -d '.' -f 2)
	case $EXTENSION in

		'zip')
		unzip "$APP_ANSWER" -d "$POL_System_TmpDir/"
		INSTALLER="$POL_System_TmpDir/AtelierScientifiqueElevePhy_FR_7_0_1.msi"
		;;

		'msi')
		INSTALLER="$APP_ANSWER"
		;;

		*)
		POL_SetupWindow_message "Le fichier sélectionné n'est ni un .zip ni un .msi. FIN" "Erreur"
		exit
		;;

	esac

elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "https://www.jeulin.fr/media/pim/assets/DocumentsPDF/std.lang.all/e-/pc/Atelier-Scientifique-eleve-PC.zip"
	unzip "$POL_System_TmpDir/Atelier-Scientifique-eleve-PC.zip" -d "$POL_System_TmpDir"
    INSTALLER="$POL_System_TmpDir/AtelierScientifiqueElevePhy_FR_7_0_1.msi"
fi
# fin de la condition

POL_Wine_SelectPrefix "$PREFIX" 
POL_Wine_PrefixCreate "$WINE_VERSION"
POL_Call POL_Install_msls31
POL_Call POL_Install_riched20
Set_OS "winxp"
POL_Wine_OverrideDLL builtin d3d8 d3d9 dinput dinput8 dsound
POL_Wine_OverrideDLL native d3dim d3drm d3dx9_24 d3dx9_25 d3dx9_26 d3dx9_27 d3dx9_28 d3dx9_29
POL_Wine_OverrideDLL native d3dx9_30 d3dx9_31 d3dx9_32 d3dx9_33 d3dx9_34 d3dx9_35 d3dx9_36 d3dx9_37
POL_Wine_OverrideDLL native d3dx9_38 d3dx9_39 d3dx9_40 d3dx9_41 d3dx9_42 d3dx9_43 d3dxof
POL_Wine_OverrideDLL native dciman32 ddrawex devenum dmband dmcompos dmime dmloader dmscript dmstyle
POL_Wine_OverrideDLL native dmusic dmusic32 dplay dplayx dpnaddr dpnet dpnhpast dpnlobby dswave
POL_Wine_OverrideDLL native dxdiagn msdmo qcap quartz

 
POL_SetupWindow_wait "Installation in progress." "Atelier Scientifique Jeulin installation"
POL_Wine  msiexec /i "$INSTALLER"

 
POL_System_TmpDelete
 
POL_Shortcut "EsaoStudio.exe" "$TITLE"


POL_SetupWindow_Close # <-- fin
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX4whegAKCRDlMfrJqhPK
R4SaAKCH6BWUmAwd7fWtopsIRLMpYBplngCcDC1TyG6gRsj3gc/jSdXLHWrQ9fc=
=kmj7
-----END PGP SIGNATURE-----
