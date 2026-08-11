#!/bin/bash
# Date : (2019-09-03)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED : v2.0.0.2 (from GOG.com)
#
# Middlewares used by this software : DirectX 9, Visual C++ 2008, Nvidia Physx, MSVCP90 +  MSVCR90.
#
# CHANGELOG
# [Dadu042] (2019-09-03)
#   First script.
# [Dadu042] (2020-07-25)
#   [CHANGED] amd64 -> x86
#   [CHANGED] Wine 4.0.2 -> 5.0.1
#   [ADDED] vcrun2008, physx
# [Dadu042] (2020-07-25 23:00)
#   [CHANGED] Audio Pulse -> Alsa
#
#
# KNOWN ISSUES:
#  - Wine amd64 5.0.1, 5.12, 5.13: does launch until a black screen with a bold mouse cursor, not intro videos played. Tried: wmpcodecs, wmp9, wmp10
#       Workaround: rename 'SB_Logo.wmv' to something else.
#       '002b:fixme:msvcp:_Locinfo__Locinfo_ctor_cat_cstr (0EC5F80C 1 C) semi-stub'. Fix: POL_Install_msvc90. Then I get again the mouse cursor on black screen:
#       '0036:fixme:d3d:state_linepattern_w Setting line patterns is not supported in OpenGL core contexts.' Tried: argument '-force-d3d9', override 'Vision90.dll', POL_Install_d3dcompiler_42, directx9, dxfullsetup, xact, devenum, quartz (fix the 100% cpu issue).
#
#  - Wine amd64 5.0.1: 'fixme:d3d:state_linepattern_w Setting line patterns is not supported in OpenGL core contexts.'  Tried: directx9, vcrun2008, d3dx9_42.dll, 
#  - Wine amd64 4.21, 5.7: crash when launching (winedbg: Internal crash).
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 4.0.2, 4.0.4, 3.0.3: crash when launching. Tried: install vcrun2008, d3dx9_43 + compiler. Fix: Wine 4.15
#         registers OnAssetManagerFinishedInitializationDwine: Unhandled page fault on read access to 0x00000000 at address 0xad97e6 (thread 002a), starting debugger...
#         0033:fixme:dbghelp:elf_search_auxv can't find symbol in module
#  - Wine amd64 4.15: crash when launching. Tried: install Xact, dsound.
#      0009:err:module:load_so_dll failed to load .so lib "/home/walter/.PlayOnLinux/wine/linux-amd64/4.15/bin/../lib/wine/x3daudio1_7.dll.so": libFAudio.so.0: Ne peut ouvrir le fichier d'objet partagé:
#      Auc0009:err:module:import_dll Loading library X3DAudio1_7.dll (which is needed by L"C:\\GOG Games\\ArcaniA\\Arcania.exe") failed (error c000007a).
#      Fix : install libFaudio.so



[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Arcania"
PREFIX="arcania"
EDITOR="Nordic Games"
GAME_URL="https://pcgamingwiki.com/wiki/Arcania:_Gothic_4"
AUTHOR="Dadu042"
STEAM_ID="39690"
WORKING_WINE_VERSION="5.0.2"
GAME_VMS="512"
SHORTCUT_FILENAME="Arcania.exe"
SOFTWARE_CATEGORIES="Game;AdventureGame;"

# Starting the script
POL_SetupWindow_Init
   
# Starting debugging API
POL_Debug_Init
  
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"

# POL_SetupWindow_message "$(eval_gettext 'This game requires a fast 3D GPU (ie: Intel HD Graphics 4440 is not enough).')" "$TITLE"
 
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Determine Architecture
POL_System_SetArch "x86"
  
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"



#############################################
#  Sound problem fix - pulseaudio related   #
#############################################1
 [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
 [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix



Set_OS "win7"

POL_Call POL_Install_corefonts
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_dotnet40
POL_Call POL_Install_d3dx9_42

# Installing mandatory dependencies
# POL_Call POL_Install_d3dx11

# POL_Call POL_Install_mono210



# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Useful for Nvidia GPUs
POL_Call POL_Install_physx



# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL"

# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" == "DVD" ];then
        POL_SetupWindow_cdrom

        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"

elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
        POL_Download "https://www.villagers-and-heroes.com/VHSetup.exe"
        POL_Wine "VHSetup.exe" "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
 
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"

if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE" 
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
#	POL_Shortcut_Document "$TITLE" "Readme.txt"
         
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
         
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
fi
fi
 
POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a big useless POL/POM log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX2oq4gAKCRDlMfrJqhPK
RwEhAJ9ocxVOmnaANhllFxSvF+6zwziIgwCgpFm85k7fWVkeLNMrMmogLxgFcTQ=
=xKIS
-----END PGP SIGNATURE-----
