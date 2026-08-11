#!/bin/bash
# Date : (2008-05-23 20-13)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Debian Squeeze (Testing)
# Author : syberia303
#
# CHANGELOG
# [syberia303] (2008-05-23 20-13)
#   First script.
# [syberia303 ?] (2011-01-21 20-00)
#   ?
# [Dadu042] (2020-02-05 22:50)
#   Wine 1.3.5 -> 3.0.3
#   Script tested with a CD-ROM v1.05 (+ NoCD).
#   Update other functions (to POL v4).
#   Add patch function.

[ "$PLAYONLINUX" = "" ] && exit 0 
source "$PLAYONLINUX/lib/sources"
  
TITLE="Serious Sam : The Second Encounter"
PREFIX="SeriousSam-TheSecondEncounter"
WORKING_WINE_VERSION="3.0.3"
  
if [ "$POL_LANG" == "fr" ]; then

# N'est plus disponible depuis http://www.liflg.org/?catid=6&gameid=71 en date du 2020-02-05.
# LNG_WAIT_WARNING="Essayez de jouer en version native à Serious Sam via l'installeur\ndisponible à cette adresse: http://www.liflg.org/?catid=6&gameid=71"

LNG_CHOOSE_MEDIA="Choisissez votre méthode d'installation :"
LNG_MEDIA_DDV="Version Digital Download"
LNG_MEDIA_CD="Version CD"
LNG_CHOOSE_DDV="Veuillez sélectionner votre exécutable Digital Download de $TITLE"
LNG_INSTALL_RUN="Installation en cours..."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du programme sera\nterminée sous peine de devoir recommencer l'installation."
LNG_WAIT_HF="Are you serious?!"
else
LNG_CHOOSE_MEDIA="Choose your install method :"
LNG_MEDIA_DDV="Digital Download Version"
LNG_MEDIA_CD="CD Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"

# No longuer available from http://www.liflg.org/?catid=6&gameid=71 as of 2020-02-05.
# LNG_WAIT_WARNING="Try to play Serious Sam natively via the installer which is\navailable there: http://www.liflg.org/?catid=6&gameid=71"

LNG_INSTALL_RUN="Installation in progress..."
LNG_WAIT_END="Click on \"Next\" ONLY when the software installation is finished\nor you will have to install again the game."
LNG_WAIT_HF="Are you serious?!"
fi
  
# Starting the script
#POL_GetSetupImages "<ADRESSE_IMAGE_TOP>" "<ADRESSE_IMAGE_LEFT>" "$TITLE"
#POL_SetupWindow_InitWithImages
POL_SetupWindow_Init
  
# Presentation
POL_SetupWindow_presentation "$TITLE" "Croteam" "http://www.seriouszone.com/" "syberia303" "$PREFIX"
  
POL_SetupWindow_message "$LNG_WAIT_WARNING" "$TITLE"
  
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
  
# Downloading specific Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"
  
# Fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES
  
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_MEDIA_CD~$LNG_MEDIA_DDV" "~"
GAME_MEDIAVERSION="$APP_ANSWER"
 
if [ "$GAME_MEDIAVERSION" == "$LNG_MEDIA_CD" ]; then
POL_Call POL_Function_NoCDWarning
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
wine start /unix "$CDROM/Setup.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
 
elif [ "$GAME_MEDIAVERSION" == "$LNG_MEDIA_DDV" ]; then
 
cd "$HOME"
POL_SetupWindow_browse "$LNG_CHOOSE_DDV" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
wine start /unix "$SETUP_EXE"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
fi
 
 
POL_SetupWindow_auto_shortcut "$PREFIX" "SeriousSam.exe" "$TITLE" "$TITLE.png"
POL_Shortcut_Document "$LNG_NAME" "index.html"
  
POL_SetupWindow_message "$LNG_WAIT_HF" "$TITLE"

################
# Patch update #
################
  
POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ?')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"      
   
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjs+ggAKCRDlMfrJqhPK
R/BKAJ9hU1do82TEj1232Rq+ton81c8+AQCfbLdyuBZD8bGnFc5qJqO1ZPyJD5g=
=1Gon
-----END PGP SIGNATURE-----
