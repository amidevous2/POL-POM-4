#!/bin/bash
# Date : (2019-11-22)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : Ubuntu Studio 18.04 x64
# Author : siliconsensor
 
# CHANGELOG
# [siliconsensor] (2019-11-24)
#   First script.
 
# KNOWN ISSUES:
#  - Error message after the first installation ("If your program is running, just ignore this message").
#    But the installation continues without problems
 
      
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="XV-Editor"
PREFIX="XVEditor"
EDITOR="Roland"
GAME_URL="https://www.roland.com/fr/"
AUTHOR="siliconsensor"
WORKING_WINE_VERSION="3.15"
SOFTWARE_CATEGORIES="Audio;Midi;"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_INFO="Si à un moment vous voyez :\n\nError in POL_Wine\nWine semble avoir planté\nSi votre programme est en cours d'exécution, ignorez simplement ce message\n\nAlors il faudra juste cliquer sur Suivant pour poursuivre l'installation."
LNG_CHOOSE_MEDIA="Comment voulez-vous installer ce logiciel ?"
LNG_LOCAL_EXE="À partir du fichier xv_editor_v157.exe sur mon PC."
LNG_DOWNLOAD_EXE="Télécharger depuis le site de Roland."
LNG_CHOOSE_LOCAL_EXE="Veuillez selectionner le fichier xv_editor_v157.exe."
LNG_INSTALL_ON="Installation en cours..."
LNG_SHORTCUTS_CHOOSE="Choisissez le ou les raccourci(s) à installer\n(installation manuelle toujours possible ensuite)."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_INFO="If at some point you see:\n\nError in POL_Wine\nWine seems to have crashed\nIf your program is running, just ignore this message\n\nThen just click Next to continue the installation."
LNG_CHOOSE_MEDIA="How would you like to install this software?"
LNG_LOCAL_EXE="From the file xv_editor_v157.exe on my PC."
LNG_DOWNLOAD_EXE="Download from Roland website."
LNG_CHOOSE_LOCAL_EXE="Please select the file xv_editor_v157.exe."
LNG_INSTALL_ON="Installation in progress..."
LNG_SHORTCUTS_CHOOSE="Choose the shortcut(s) to install\n(manual installation always possible later)."
LNG_SUCCES="$TITLE has been installed successfully."
fi
 
# Starting the script
POL_SetupWindow_Init
 
#POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "$AUTHOR" "$PREFIX"
 
# Information
POL_SetupWindow_message "$LNG_INFO" "$TITLE"
 
# create temporary directory
POL_System_TmpCreate "xv_editor_tmp"
 
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_LOCAL_EXE~$LNG_DOWNLOAD_EXE" "~"
 
#POL_SetupWindow_InstallMethod "$LNG_LOCAL_EXE,$LNG_DOWNLOAD_EXE"
if [ "$APP_ANSWER" == "$LNG_LOCAL_EXE" ]
then
    POL_SetupWindow_browse "$LNG_CHOOSE_LOCAL_EXE" "$TITLE"
    INSTALLER1="$APP_ANSWER"
elif [ "$APP_ANSWER" == "$LNG_DOWNLOAD_EXE" ]
then
    # download the installer to the temporary directory
    cd "$POL_System_TmpDir"
    POL_Download "https://static.roland.com/assets/media/exe/xv_editor_v157.exe" ""
    INSTALLER1="$POL_System_TmpDir/xv_editor_v157.exe"
fi
 
Use_WineVersion "$WORKING_WINE_VERSION"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
Set_OS "win2k"
Set_Desktop "On" "1024" "768"
 
POL_SetupWindow_wait "$LNG_INSTALL_ON" "$TITLE"
 
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/"
 
# Creating Install directory
POL_Wine "$INSTALLER1"
 
# Running setup.exe
INSTALLER2="$WINEPREFIX/drive_c/$PROGRAMFILES/Install/setup.exe"
POL_Wine "$INSTALLER2"
 
# Install shortcuts
POL_SetupWindow_checkbox_list "$LNG_SHORTCUTS_CHOOSE" "$TITLE" "XV-2020 Editor~XV-5050 Editor~XV-5080 Editor~XV Librarian" "~"
 
POL_SetupWindow_wait "$LNG_INSTALL_ON" "$TITLE"
 
if [ "$(echo $APP_ANSWER | grep -o "XV-2020 Editor")" != "" ]
then
    POL_Shortcut "XV-2020Editor.exe" "XV-2020 Editor"
fi
if [ "$(echo $APP_ANSWER | grep -o "XV-5050 Editor")" != "" ]
then
    POL_Shortcut "XV-5050Editor.exe" "XV-5050 Editor"
fi
if [ "$(echo $APP_ANSWER | grep -o "XV-5080 Editor")" != "" ]
then
    POL_Shortcut "XV-5080Editor.exe" "XV-5080 Editor"
fi
if [ "$(echo $APP_ANSWER | grep -o "XV Librarian")" != "" ]
then
    POL_Shortcut "XVLibrarian.exe" "XVLibrarian"
fi
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgJz7gAKCRDlMfrJqhPK
RygrAKCPCz8PyWwVXXZvIui4khZMY/P+tQCcCKLz58lgCwrtDxj+3rMtbLqumhQ=
=W5YD
-----END PGP SIGNATURE-----
