#!/bin/bash
# Date : (2011-11-06 21-34)
# Last revision : see changelog
# Wine version used : 3.0.5
# Distribution used to test :
# Author : NSLW & Tutul (update)
# Playonlinux version used: 4.2.2

# CHANGELOG
# [SuperPlumus] (2012-04-08 07-36)
#   Change Wine version 1.3.7 -> 1.5.0
#   Add HW_OK=1 key in registry
# [SuperPlumus] (2013-06-23 19-37)
#   Update gettext messages
#   Update regedit -> POL_Wine regedit
# [petch] (2014-07-11 23-38)
#   Change Wine version 1.5.0 -> 1.7.22
# [Dadu042] (2019-06-02 20-18)
#   Change Wine version 1.7.22 -> 3.0.5
#   Fix regedit (-> regedit.exe)
 
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
 
TITLE="Google SketchUp 8"
PREFIX="GoogleSketchUp8"
WORKING_WINE_VERSION="3.0.5"
LOCALE="en_EN.utf8" #default localisation
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Google" "http://sketchup.google.com/" "NSLW" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"


POL_Wine_Direct3D "OpenGL" "enabled"
   
# Seem useless:
# POL_Call POL_Install_msxml3 
# POL_Call POL_Install_gecko
# POL_Call POL_Install_mshtml
# POL_Call POL_Install_msvc80

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
 
POL_SetupWindow_menu "$(eval_gettext 'What language do you want to install?')" "Language Selection" \
    "English|Deutsch|Español|Português (BR)|Français|???????|Italiano|Nederlands|???|????|????" "|"
case "$APP_ANSWER" in
    "English")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWEN.exe"
        LOCALE="en_EN.utf8";;
    "Deutsch")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWDE.exe"
        LOCALE="de_DE.utf8";;
    "Español")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWES.exe"
        LOCALE="es_ES.utf8";;
    "Português (BR)")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWPT-BR.exe"
        LOCALE="pt_BR.utf8";;
    "Français")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWFR.exe"
        LOCALE="fr_FR.utf8";;
    "???????")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWRU.exe"
        LOCALE="ru_RU.utf8";;
    "Italiano")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWIT.exe"
        LOCALE="it_IT.utf8";;
    "Nederlands")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWNL.exe"
        LOCALE="nl_NL.utf8";;
    "???") 
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWKO.exe"
        LOCALE="ko_KR.utf8";;
    "????")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWZH-TW.exe"
        LOCALE="zh_TW.utf8";;
    "????")
        DOWNLOAD_LINK="http://dl.google.com/sketchup/GoogleSketchUpWZH-CN.exe"
        LOCALE="zh_CN.utf8";;
    *)
        exit 1 ;;
esac
 
cd "$POL_System_TmpDir"
POL_Download "$DOWNLOAD_LINK" ""
POL_Wine_WaitBefore "$TITLE"
EXE_FILE="${DOWNLOAD_LINK##*/}"
POL_Wine start /unix ${EXE_FILE}
POL_Wine_WaitExit "$TITLE"
 
fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
 
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
 
fi
 
POL_SetupWindow_message "$(eval_gettext 'If you are using localised binary, you must 
have the correct locale package installed.\n\n
If the Google SketchUp language differs from your desktop setting you 
must prefix the launch by forcing your locale.\n
   - Go to : Configure > Google Sketchup (Shortcut) > Miscellaneous \n\n
   - Write and adapt the following line depending on your locale in the "Command to exec before running the program" field:\n\n
      export LANG=<set_your_locale_here>
')" "$TITLE"


cat << EOF > "RegModif.reg"
[HKEY_CURRENT_USER\Software\Google\SketchUp8\GLConfig\Display]
"HW_OK"="1"	
EOF
POL_Wine regedit.exe "RegModif.reg"


POL_Wine_SetVideoDriver
 
POL_System_TmpDelete
 
POL_Shortcut "SketchUp.exe" "$TITLE" # "SketchUp.png"
 
#POL_Shortcut_InsertBeforeWine "$TITLE" "export LANG=$LOCALE" # Force localisation
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPbWhwAKCRDlMfrJqhPK
R0QeAJ9VXnTl3PCv2DirHWhncgPcFTUqoQCgkf6vOZ+28mv9NCOS2f7ql5jeHY0=
=Eg31
-----END PGP SIGNATURE-----
