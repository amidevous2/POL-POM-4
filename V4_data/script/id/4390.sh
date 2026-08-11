#!/usr/bin/env PlayOnLinux-Bash
#===========================================================
# Information
#===========================================================
# Date: (2021-06-28 23-30)
# Last revision: (2021-06-28 23-30)
# Wine Version Used: 6.11
# Distribution used to test: Linux Mint 20.04 Focal Fossa x64
# Author: GuerreroAzul
# PlayOnLinux : 4.3.4
# Script licence : GPL3
# Program licence : Retail
#===========================================================


#===========================================================
# CHANGELOG
#===========================================================
# 2021-06-28: 
#-----------------------------------------------------------
# POL Version: 4.3.4
# Wine Version Used: 6.11
# Wine SO: Windows 10
# Wine Architecture: x86
#
# - English and Spanish language was entered.
#===========================================================


#===========================================================
# Running the Scripts
#-----------------------------------------------------------
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
POL_SetupWindow_Init

# Variable
#-----------------------------------------------------------
TITLE="Typing Master"
PREFIX="TypingMaster"
POLVERSION="4.3.4"
WINEVERSION="6.11"
OSVERSION="win10"
ARCHITECTURE="x86"
COMPANY="Typing Master"
SITEWEB="www.typingmaster.com"
AUTHOR="GuerreroAzul"
LENGM1="English"
LENGM2="Spanish"

# Select language
#-----------------------------------------------------------
POL_SetupWindow_menu "Select a language:" "Select Language" "$LENGM1;$LENGM2" ";"
#English
#-----------------------------------------------------------
if [ "$APP_ANSWER" = "$LENGM1" ]; then
POLVER_M1="won't work with"
POLVER_M2="!nPlease update!"
POLOS_M1="Please install winbind before installing"
INSTALL_MODE_M1="Select an installation mode:"
INSTALL_MODE_M2="Installation Mode"
INSTALL_MODE_S1="Attended Mode (Recommended)"
INSTALL_MODE_S2="Advanced Mode"
PREFIX_M1="Do you want to change the name of the unit?"
PREFIX_M2="Name of the unit"
PREFIX_M3="Enter the name of the unit:"
ARQUIT_M1="Do you want to change the type of Architecture?"
ARQUIT_M2="Architecture Type"
ARQUIT_M3="Select the type of Architecture:"
INSTALL_TYPE_S1="Internet download"
INSTALL_TYPE_S2="Local Installation"
INSTALL_LOCAL_M1="Please select the setup file to run."
INSTALL_START_M1="Installation in progress."

# Spanish
#-----------------------------------------------------------
else
POLVER_M1="no funcionara con"
POLVER_M2="!nPor favor actualizar!"
POLOS_M1="Por favor instalar winbind antes de comenzar"
INSTALL_MODE_M1="Seleccione un modo de instalación:"
INSTALL_MODE_M2="Modo de Instalación"
INSTALL_MODE_S1="Modo Atendido (Recomendado)"
INSTALL_MODE_S2="Modo Avanzado"
PREFIX_M1="Quiere cambiar el nombre de la unidad?"
PREFIX_M2="Nombre de la Unidad"
PREFIX_M3="Ingrese el nombre de la unidad:"
ARQUIT_M1="Quiere cambiar el tipo de Arquitectura?"
ARQUIT_M2="Tipo de Arquitectura"
ARQUIT_M3="Seleccione el tipo de Arquitectura:"
INSTALL_TYPE_S1="Descargar de internet"
INSTALL_TYPE_S2="Instalacion Local"
INSTALL_LOCAL_M1="Seleccione el archivo de instalación para ejecutar."
INSTALL_START_M1="Instalación en curso."
fi

#Presentation
#-----------------------------------------------------------
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$SITEWEB" "$AUTHOR" "$TITLE"

# POL Validations
#-----------------------------------------------------------
POL_RequiredVersion $POLVERSION || POL_Debug_Fatal "$TITLE $POLVER_M1 $APPLICATION_TITLE $VERSION $POLVER_M2"

#Linux Validations
if [ "$POL_OS" = "Linux" ]; then
    wbinfo -V || POL_Debug_Fatal "$POLOS_M1 $TITLE!"
fi

#Mac Validations
if [ "$POL_OS" = "Mac" ]; then
    POL_Call POL_GetTool_samba3
    source "$POL_USER_ROOT/tools/samba3/init"
fi


#!/usr/bin/env PlayOnLinux-Bash

# Information
#===========================================================
# Wine Version Used: 6.11
# Distribution used to te
# PlayOnLinux : 4.3.4
# Program licence : Retail
#===========================================================
# CHANGELOG
# Wine Version Used: 6.11
# Wine SO: Windows 10
# Wine Architecture: x86
#
# - English and Spanish language was entered.
#===========================================================

#===========================================================
# Running the Scripts
#-----------------------------------------------------------
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
POL_SetupWindow_Init

# Variable
#-----------------------------------------------------------
TITLE="Typing Master"
PREFIX="TypingMaster"
POLVERSION="4.3.4"
WINEVERSION="6.11"
OSVERSION="win10"
ARCHITECTURE="x86"
COMPANY="Typing Master"
SITEWEB="www.typingmaster.com"
AUTHOR="GuerreroAzul"
LENGM1="English"
LENGM2="Spanish"

# Select language
#-----------------------------------------------------------
POL_SetupWindow_menu "Select a language:" "Select Language" "$LENGM1;$LENGM2" ";"
if [ "$APP_ANSWER" = "$LENGM1" ]; then
    POLVER_M1="won't work with"
    POLVER_M2="!nPlease update!"
    POLOS_M1="Please install winbind before installing"
# Spanish
#-----------------------------------------------------------
else
    POLVER_M1="no funcionara con"
    POLVER_M2="!nPor favor actualizar!"
    POLOS_M1="Por favor instalar winbind antes de comenzar"
fi

#Presentation
#-----------------------------------------------------------

# POL Validations
POL_RequiredVersion $POLVERSION || POL_Debug_Fatal "$TITLE $POLVER_M1 $APPLICATION_TITLE $VERSION $POLVER_M2"

#Linux Validations
if [ "$POL_OS" = "Linux" ]; then
    wbinfo -V || POL_Debug_Fatal "$POLOS_M1 $TITLE!"
fi

#Mac Validations
if [ "$POL_OS" = "Mac" ]; then
    POL_Call POL_GetTool_samba3
    source "$POL_USER_ROOT/tools/samba3/init"
fi

#wine Setup And Installation
#-----------------------------------------------------------
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OS"
POL_System_SetArch "$ARQUITECTURE"
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Installation of Libraries
#-----------------------------------------------------------

# Theme Windows
POL_Call POL_Install_LunaTheme
POL_Call POL_Install_corefonts

# Installation of various Libraries
POL_Call POL_Install_gdiplus
POL_Call POL_Install_mspatcha

# Installation of Graphic Libraries
POL_Call POL_Install_riched20
POL_Call POL_Install_riched30
POL_Call POL_Install_msxml6
POL_Wine_OverrideDLL "native,builtin" "riched30"

#Local Installation
#-----------------------------------------------------------
POL_SetupWindow_browse "$(eval_gettext '$INSTALL_LOCAL_M1')" "$TITLE"
SetupIs="$APP_ANSWER"

#Installation started
POL_Wine "$SetupIs"

#End Scripts
#-----------------------------------------------------------
POL_System_TmpDelete
POL_SetupWindow_Close
#===========================================================
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYO49UQAKCRDlMfrJqhPK
R60BAJ93w+x7Gm7P3k+bvpTYMBQS289RUACdG2Lq64WzrKk1XsCJaxUeEDMReMg=
=PsX1
-----END PGP SIGNATURE-----
