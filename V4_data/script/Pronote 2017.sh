#!/usr/bin/env playonlinux-bash
# Date : (2017-11-25 16-38)
# Last revision : (n/a)
# Wine version used : 1.6.2
# Distribution used to test : Linux Mint 18.2 Sonya
# Author : vivi5421
  
 [ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Pronote 2017"
PREFIX="pronote2017"
WINE_VERSION="1.6.2"
  
# Controle de version
POL_SetupWindow_Init
POL_Debug_Init
  
# Presentation
POL_SetupWindow_presentation "$TITLE" "Index Education" "http://www.index-education.com/" "vivi5421" "$PREFIX"
  
  
# Choix du fichier de la source d'installation
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select installation file')" "$TITLE" "$BIN"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    # Téléchargement de Pronote
    FILE="Install_PRNclient_FR_2017.0.2.4_win32.exe"
    POL_Download "http://tele3.index-education.com/telechargement/pn/v2017.0/exe/$FILE"
    INSTALLER="$POL_System_TmpDir/$FILE"
fi

POL_SetupWindow_message "IMPORTANT: Do not install shortcut using the application and do not launch client with the installer. A PlayOnLinux shortcut will be installed with correct settings and won't block the script." "$TITLE"

  
# Configuration du disque virtuel
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"
POL_Call POL_Install_msxml6
POL_Wine_OverrideDLL "native,builtin" "msxml6"
Set_OS win7
  
  
POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "$INSTALLER"
  
  
# Raccourci pour Pronote
POL_Shortcut "Client PRONOTE.exe" "$TITLE"
  
  
# Fermeture de l'assistant d'installation
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNU2gQAKCRDlMfrJqhPK
R0oYAJ9MEApICtOgu25IvgvCfq7vsr6bvwCggs36XR3jDVDMTi+eGvglsBHw8+g=
=ynbY
-----END PGP SIGNATURE-----
