#!/usr/bin/env playonlinux-bash
# CHANGELOG
# **PlayOnLinux 4.2.8**
# Wine version used: 1.7.28
# Distribution used to test: openSUSE 13.2 x86_64
# MemoriesOnTV3 version used to test: 3.1.8
# Author: Ueliton
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Variables -------------
AUTHOR="Ueliton"
BINU_SERVER="http://media.binu.com/12630290/stream"
PREFIX="MemoriesOnTV3"
TITLE="MemoriesOnTV3"
WORKING_WINE_VERSION="1.7.28"
# --------------------------
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
# -------------------------- 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2547
# Enable debugging
POL_Debug_Init
# Presentation ---------
POL_SetupWindow_presentation "$TITLE" "Codejam Pte Ltd" "www.codejam.com" "$AUTHOR" "$PREFIX"
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
    POL_Download "$BINU_SERVER/98566923206-333ac5d90817d691/motv318.exe" "3f7d50933113954fddc294775648bb2b"
    POL_SetupWindow_message "$(eval_gettext 'Please do not restart.')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine motv318.exe
fi
    
# Installation Method LOCAL --------------------
if [ "$INSTALL_METHOD" = "LOCAL" ]
  then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
    POL_SetupWindow_message "$(eval_gettext 'Please do not restart.')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
fi

# Selection and configuration of DLL language ----------------
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/MemoriesOnTV3"
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
# Delete temp directory ----------------
POL_System_TmpDelete
# Create a launcher ---
POL_Shortcut "Motv.exe" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlVvilYACgkQ5TH6yaoTykdgAwCfVT4cmxLvhEgIDjAxuhVFHWLk
pvsAmgJzJGvE8l+kpa3HuCkyYUgQXHCk
=+81/
-----END PGP SIGNATURE-----
