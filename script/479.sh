#!/bin/bash
# Date: (17/12/09)
# Last revision: (17/12/09)
# Distribution used to test: Ubuntu Jaunty
# Wine version used: 
# Author: david
# Game : IL-2 : Sturmovik
# 
#
# CHANGELOG
# [David] (2009-12-17)
#   First script.
# [Dadu042] (2019-12-21)
#   Wine 1.0.1 -> system version (I have tested with Wine 4.0.3)
#
#
# KNOWN ISSUES:
#  - Wine amd64 4.0.3: even with patch v4.12.1, the anticopy does not recognize the CD-ROM.
  
[ "$PLAYONLINUX" = "" ] && exit 0 
source "$PLAYONLINUX/lib/sources"

TITLE="IL2: Sturmovik"
SHORTCUT_FILENAME="il2.exe"
SOFTWARE_CATEGORIES="Game;"
   
# Function patching
patch()
{
cd $HOME
POL_SetupWindow_browse "Please select the patch file" "Patch selection" ""
wine "$APP_ANSWER"
}
 
#Initialisation
POL_SetupWindow_Init
 
#Presentation
POL_SetupWindow_presentation "IL-2 : Sturmovik" "Ubisoft" "http://www.ubi.com/" "David" "Sturmovik"

POL_Call POL_Function_NoCDWarning

POL_System_SetArch "x86"

#Installation de Wine
POL_Wine_PrefixCreate ""

#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
  
# Préparation de Wine
select_prefix "$REPERTOIRE/wineprefix/Sturmovik"
POL_SetupWindow_prefixcreate
 
# Notes
POL_SetupWindow_message "Please note that if you want to improve speed of the game, \n you can do it by enabling Virtual Desktop using wine configurator\nor disabling some graphical effects.\n\nYou don't need to install DirectX because the game manage \nan OpenGL driver.\n\nIf you play to the game with a keyboard, don't forget\nto disable the joystick :-)"
 
# Configuration de Wine
Set_GLSL "On"
Set_OS "winxp"
 
 
# Récupération de la variable d'environement PROGRAMFILES
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}
 
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
  
POL_SetupWindow_wait_next_signal "Installation in progress..." "IL-2 : Sturmovik"
wine "$CDROM/setup.exe"
POL_SetupWindow_detect_exit
 
        POL_SetupWindow_question "Do you have a post-installation patch you would like to install?" "Post-installation patch"
        PATCH=$APP_ANSWER
 
        if [ "$PATCH" = "TRUE" ]
        then
                patch
        fi
 
 
# Make icon
convert "$CDROM/il2.ico" "$REPERTOIRE/icones/32/IL-2 : Sturmovik.xpm"
  
# Create launcher 
# POL_SetupWindow_make_shortcut "Sturmovik" "$PROGRAMFILES/Ubi Soft/IL2 Sturmovik" "il2.exe" "$REPERTOIRE/icones/32/IL-2 : Sturmovik.xpm" "IL-2 : Sturmovik"
POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
POL_Shortcut "il2setup.exe" "$TITLE - Setup" "" "" "$SOFTWARE_CATEGORIES"
   
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXf+BuQAKCRDlMfrJqhPK
R5zFAKCd4wO7We1FZehAtqT9qMSg7i9yGgCcCKaJ8zCfUIGnHj9uHN2VFiNLBEk=
=3ZI5
-----END PGP SIGNATURE-----
