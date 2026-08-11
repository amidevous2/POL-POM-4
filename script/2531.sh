#!/usr/bin/env playonlinux-bash
# CHANGELOG
# [Ueliton] (2015-06-03) UTC-3 14:28
# Correction, script not working
# Changed PREFIX and TITLE(Thank you [petch])
# Added install method Local
# Changed URL link download of version 4.1.2
# Added versions 4.1.0
# Added translations
# **PlayOnLinux 4.2.8**
# Wine version used: 1.7.28
# Distribution used to test: openSUSE 13.2 x86_64
# MemoriesOnTV versions used to test: 4.1.0 and 4.1.2
# Author: Ueliton
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Variables -------------
AUTHOR="Ueliton"
BINU_SERVER="http://media.binu.com/12630290/stream"
PREFIX="MemoriesOnTV4"
TEXT_INSTRUCTIONS="$(eval_gettext '\nDuring installation please deselect Creation of Icon Launcher/Desktop\n\nDO NOT let RESTART.')"
TITLE="Memories On TV"
WORKING_WINE_VERSION="1.7.28"
# --------------------------
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
# -------------------------- 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2531
# Enable debugging
POL_Debug_Init
# Presentation ---------
POL_SetupWindow_presentation "$TITLE" "Codejam Pte Ltd" "www.codejam.com" "$AUTHOR" "$PREFIX"
# INFO -------------------
POL_SetupWindow_message "$(eval_gettext 'INFO: This install MemoriesOnTV version 4.\n\nIf you have registration code from earlier versions to 3...\n\nYou can find the installer on PlayOnLinux / Mac for PictureToTV, MemoriesOnTV2 or MemoriesOnTV3.')" "$TITLE" 
# Managing prefix and Wine version -----
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# Creating Temp directory ----------------
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
# --------------------------
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
# Installation Method DOWNLOAD -------------
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
  then
      POL_SetupWindow_menu "$(eval_gettext 'What version do you want to install?')" "Version Selection" \
      "4.1.2|4.1.0" "|"
      case "$APP_ANSWER" in
          "4.1.2")
              DOWNLOAD_LINK="$BINU_SERVER/98566924702-1e5186bca8f75fca/motv412.exe"
              MD5SUM="277a4be8e2c6746332f04791e853f03f";;
          "4.1.0")
              DOWNLOAD_LINK="$BINU_SERVER/98566923396-96ea64f3a1aa2fd0/motv410.exe"
              MD5SUM="d1ea7b849cb22b7fc1edc7b5c7b6f47c";;
          *)
      esac
  POL_Download "$DOWNLOAD_LINK" "$MD5SUM"
  EXE_FILE="${DOWNLOAD_LINK##*/}"
  POL_SetupWindow_message "$TEXT_INSTRUCTIONS" "$TITLE"
  POL_Wine_WaitBefore "$TITLE"
  POL_Wine ${EXE_FILE}
fi
# Installation Method LOCAL --------------------
if [ "$INSTALL_METHOD" = "LOCAL" ]
  then
      cd "$HOME"
      POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
      POL_SetupWindow_message "$TEXT_INSTRUCTIONS" "$TITLE"
      POL_Wine_WaitBefore "$TITLE"
      POL_Wine "$APP_ANSWER"
fi
# Selection and configuration of DLL language ----------------
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/MemoriesOnTV4"
mv MotvLOC.dll MotvLOC_old.dll

POL_SetupWindow_menu "$(eval_gettext 'Please select a language:')" "$TITLE" \
"Default(English)|Dutch|French|German|Hungarian|Italian|Portuguese|Russian|Spanish|Turkish" "|"

case "$APP_ANSWER" in
    "Default(English)")
        mv MotvLOC_old.dll MotvLOC.dll;;
    
    "Dutch")
        POL_Download "$BINU_SERVER/98566921347-5bd53571b9788463/MotvLOC.dll" "36fecb8db3888ef75ddfdca19394b3f8";;
 
    "French")
        POL_Download "$BINU_SERVER/98566922123-5e1b18c4c6a6d316/MotvLOC.dll" "53c8f62a2d3d2385dc5b62ad5636a59e";;
 
    "German")
        POL_Download "$BINU_SERVER/98566922572-3bd318565e4adbe5/MotvLOC.dll" "ad4f646965049ffeeef9892768c8f41b";;
 
    "Hungarian")
        POL_Download "$BINU_SERVER/98566921834-3341f6f048384ec7/MotvLOC.dll" "96acbeea725f6539263e9d716a379985";;
 
    "Italian")
        POL_Download "$BINU_SERVER/98566921653-ec6826e925952de7/MotvLOC.dll" "e65ac42b6b06866dd558d5916e918b9d";;
 
    "Portuguese")
        POL_Download "$BINU_SERVER/98566921226-69421f032498c970/MotvLOC.dll" "ca4791dad5f5b19148f52c2e4fd5c71a";;
 
    "Russian")
        POL_Download "$BINU_SERVER/98566921112-a45a1d12ee0fb7f1/MotvLOC.dll" "2829de4f938f8b60408b4fd2fdce3759";;
 
    "Spanish")
        POL_Download "$BINU_SERVER/98566922293-50905d7b2216bfec/MotvLOC.dll" "c48fb0066e9c45293487cf955196befd";;
 
    "Turkish")
        POL_Download "$BINU_SERVER/98566920860-a9be4c2a4041cadb/MotvLOC.dll" "b3047242bf07affee0d4ce84bfc00b2b";;
    *)
esac
# Delete temp directory --------------------------
POL_System_TmpDelete
# Create a launcher
POL_Shortcut "Motv.exe" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlVvjAQACgkQ5TH6yaoTykcG5ACgrRnAOvGI9LmiN6sKvQxtS441
VjkAnjOhT24Vqa598U4iIfpNwLqscFw2
=ZGL/
-----END PGP SIGNATURE-----
