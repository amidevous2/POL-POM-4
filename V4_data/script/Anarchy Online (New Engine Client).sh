#!/bin/bash
# Date : (2019-12-04)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : KUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: 18.8.50_EP2 (found in 'version.id' file). 
#
# Middlewares used by this software : vcrun2010, DirectX 9.
#
# CHANGELOG
# [Dadu042] (2019-12-04)
#   First script.
# [Dadu042] (2020-07-17 10:00)
#   Wine 4.0.3 -> 4.0.4
# [Dadu042] (2020-08-03 10:00)  Once installed, the game does not run (crash).
#   [NEW] Can install from downloaded file.
#   [CHANGED] amd64 -> x86
# [Dadu042] (2020-08-03 13:00)  Runs OK (v18.8.53)
#   [CHANGED] win7 -> winxp, this let the EULA window appear and more.
#   [NEW] Allow to set the video memory size.
#
# KNOWN ISSUES:
#  - Wine x86 5.0.1, 5.13: there is a lot of debug lines 'fixme:d3d9:D3DPERF_SetMarker color'. Tried: d3dx9_47 + compiler.
#  - Wine x86 5.0.1: when the game does start (after login) the mouse cursor is locked at the top left of the screen. Workaround: ALT+TAB.
#
# KNOWN ISSUES (FIXED):
#  - Wine x86 4.0.4, 5.0.1: when trying to launch the game, nothing appears but the debug log file get larger. Seems related to: msvcrt.
#         0009:fixme:msvcrt:__clean_type_info_names_internal (0x1011552c) stub
#         0091:fixme:font:get_outline_text_metrics failed to read full_nameW for font L"Ani"!
#         0091:fixme:nls:GetThreadPreferredUILanguages 00000034, 0x33e7f4, 0x33e864 0x33e7fc
#         0091:fixme:nls:get_dummy_preferred_ui_language (0x34 0x33e7f4 0x33e864 0x33e7fc) returning a dummy value (current locale)
#         0091:fixme:heap:RtlSetHeapInformation (nil) 1 (nil) 0 stub
#         0091:fixme:msvcp:_Locinfo__Locinfo_ctor_cat_cstr (0x33fd1c 1 C) semi-stub
#         0091:fixme:ntdll:NtQueryInformationToken QueryInformationToken( ..., TokenElevationType, ...) semi-stub
#         0091:fixme:ntdll:NtQueryInformationToken QueryInformationToken( ..., TokenElevation, ...) semi-stub
#         0025:fixme:explorer:webbrowser_QueryInterface (0x7eca188c)->({00000003-0000-0000-c000-000000000046} 0x33e7bc) interface not supported
#         0025:fixme:explorer:webbrowser_QueryInterface (0x7eca188c)->({00000003-0000-0000-c000-000000000046} 0x33e754) interface not supported
#         0025:fixme:explorer:webbrowser_QueryInterface (0x7eca188c)->({00000019-0000-0000-c000-000000000046} 0x183060) interface not supported
#         0091:fixme:msvcrt:__clean_type_info_names_internal (0x78e1abb4) stub
#        Note: With Wine 5.13, this lead to a crash after two second. Tried: gecko, vcrun2010, d3dx9_43, IE8.  Fix: win7 -> winxp


     
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Anarchy Online (New Engine Client)"
PREFIX="Anarchy_Online_New_EC"
EDITOR="Funcom"
GAME_URL="https://en.wikipedia.org/wiki/Anarchy_Online"
AUTHOR="Dadu042"
STEAM_ID=""
WORKING_WINE_VERSION="5.0.3"
GAME_VMS="256"
SHORTCUT_FILENAME="AnarchyOnline.exe"
SOFTWARE_CATEGORIES="Game;RolePlaying;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
       
# Starting the script
POL_SetupWindow_Init
           
# Starting debugging API
POL_Debug_Init
          
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
        
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
 
# POL_SetupWindow_message "$(eval_gettext 'This game requires a fast 3D GPU (FYI: a iGPU Intel HD Graphics 530 does only become comfortable with low details).')" "$TITLE"
         
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
    
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
          
# Determine Architecture
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"
  
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
    
Set_OS "winxp"
  
# Installing mandatory dependencies
POL_Call POL_Install_corefonts
# POL_Call POL_Instatl_directmusic
  
# POL_Call POL_Install_d3dx9_47
# POL_Call POL_Install_d3dcompiler_47
   
# POL_Call POL_Install_msxml4
# POL_Call POL_Install_riched30
# POL_Call POL_Install_phzysx
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_d3dx11
# POL_Call POL_Install_mono210
   
## Sound problem fix - pulseaudio related
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
        
# Choose between Steam and other Digital Download versions
# POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL,DOWNLOAD"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
    
# POL_SetupWindow_message "Note: at the end of the installation, please do not run the game, and do not install DirectX 9." "$TITLE"
       
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
        
        POL_SetupWindow_check_cdrom "SETUP.EXE"
        POL_Wine start /unix "$CDROM/SETUP.EXE"
        POL_Wine_WaitExit "SETUP.EXE"
    
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
       
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
        cd "$WINEPREFIX/drive_c"
        POL_Download "http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe"
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
        POL_Wine start /unix "AnarchyOnline_EP2.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
   
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
    
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        # POL_Shortcut_Document "$TITLE" ""
           
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        APP_ANSWER=".EXE"
           
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE" # "/SILENT"
        POL_Wine_WaitExit "$TITLE"
  
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
     
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        # POL_Shortcut_Document "$TITLE" "Readme.txt"
     
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
     
################
#      GPU     #
################

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_menu_list "$LNG_GAME_VMS" "$TITLE" "64-128-256-320-384-512-640-768-896-1024-1536-1792-2048-3072-4096" "-" "256"
VRAM="$APP_ANSWER"
POL_Wine_Direct3D "VideoMemorySize" "$VRAM"

# Useless:  
# Ask if the graphic card has enough about memory size
# POL_SetupWindow_VMS $GAME_VMS

# Useful for Nvidia GPUs
# POL_Call POL_Install_physx

################
#      END     #
################
      
# POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a big useless POL/POM log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYAlYrgAKCRDlMfrJqhPK
RwDFAJ9va4FDZaZGSUa8lTwMMSzVDheAOQCgrmb9hatNBXxmfHREbOKqqxbOUio=
=pbbP
-----END PGP SIGNATURE-----
