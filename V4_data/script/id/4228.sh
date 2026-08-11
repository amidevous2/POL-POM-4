#!/bin/bash
# Date : (2020-09-29)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 64 bits (Linux kernel v5.4.0). GPU: AMD Vega 11.
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: Launcher v2.3.3.0 (GenshinImpact_install_20200911204035.exe)
#                           v2.3.4.0 (GenshinImpact_install_20201014173947.exe). Game (login screen): OSRELWin1.0.1_R1135452_S1135452_D1135370.
#
# Middlewares used by this software : Unity 2017, vcrun2013, vcrun2015, QT5, DirectX 11.
#
#
# CHANGELOG
# [Dadu042] (2020-09-29 10-00). 
#   Initial script. Game fail to run because of the anti cheat software (mhyprot2.sys), that want admin rights.
# [Dadu042] (2020-10-25 10-00).
#   Update the file installer URL.
# [Dadu042] (2020-10-25 20-00).
#   Wine 5.0.2 -> 5.19-staging (because I have got some crashes some seconds afeer the game did start).
# [Dadu042] (2022-06-21 20-00).
#   Wine 5.19-staging -> 6.0.1 (not tested, just to avoid users to download 5.19-staging).
#
# KNOWN ISSUES :

#  Anti-cheat issue:
#  - Wine amd64 4.21, 5.0.2, 5.11-staging, 5.16, 5.18-staging: when clicking 'Play' (yellow button) the window just does reduce in the task bar. Tried: set OS to Win7/8/10. Enable game auto update, wininet.
#    Download file from: http://www.dll-found.com/wdfldr.sys_download.html  copy to  /home/YourUserName/PlayOnLinux's virtual drives/Genshin_Impact/drive_c/users/theuser/Temp/   and into the game folder, copied also in uppercase.
#
#    Tried: copying wdfldr.sys (set as Native) and WDFLDR.SYS into '/drive_c/windows/system32/'.
#
#    Immediate Wine 5.0.2 debug log is:
#    0198:fixme:heap:RtlSetHeapInformation 0x570000 0 0x22db80 4 stub
#    0198:fixme:heap:EnumSystemFirmwareTables (0x4649524d, 0000000000000000, 0)
#    0198:fixme:heap:RtlSetHeapInformation 0x790000 0 0x22f1b0 4 stub
#    019c:err:service:validate_context_handle Access denied - handle created with access 34, needed 10000
#    01a2:err:module:import_dll Library WDFLDR.SYS (which is needed by L"C:\\users\\theuser\\Temp\\mhyprot2.sys") not found
#    01a2:err:ntoskrnl:ZwLoadDriver failed to create driver L"\\Registry\\Machine\\System\\CurrentControlSet\\Services\\mhyprot2": c0000142
#    0199:fixme:ver:GetCurrentPackageId (0x99fb00 (nil)): stub
#
#    Wine 5.16:
#    0790:fixme:heap:RtlSetHeapInformation 0000000000890000 0 000000000021DFC0 4 stub
#    0790:fixme:heap:EnumSystemFirmwareTables (0x4649524d, 0000000000000000, 0)
#    0790:fixme:heap:RtlSetHeapInformation 0000000000AB0000 0 000000000021F080 4 stub
#    079c:err:service:validate_context_handle Access denied - handle created with access 34, needed 10000
#    07b8:err:module:import_dll Library WDFLDR.SYS (which is needed by L"C:\\users\\theuser\\Temp\\mhyprot2.sys") not found
#    07b8:err:ntoskrnl:ZwLoadDriver failed to create driver L"\\Registry\\Machine\\System\\CurrentControlSet\\Services\\mhyprot2": c0000142
#    0794:fixme:ver:GetCurrentPackageId (0000000000CBFBA0 0000000000000000): stub
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 5.0.2, 5.19: on the account creation screen (if you want to use Facebook nor Twitter), display is bad and the characters typed are not displayed. Fix: Wine 5.19-staging
#  - Wine amd64 5.19-staging: missing textures (displayed as blue areas). Fix: DXVK.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Genshin Impact"
PREFIX="Genshin_Impact"
EDITOR="miHoYo"
GAME_URL="https://en.wikipedia.org/wiki/Genshin_Impact"
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="512"
SHORTCUT_FILENAME="launcher.exe"
SOFTWARE_CATEGORIES="Game;RolePlaying;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE=""


# Starting the script
POL_SetupWindow_Init
                         
# Starting debugging API
POL_Debug_Init
        
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

############################################
#  Choose architecture: 32 bits or 64 bits #
############################################

# POL_SetupWindow_menu "$(eval_gettext 'What architecture do you want to use ?')" "$TITLE" "$(eval_gettext '64 bits (recommended)')~$(eval_gettext '32 bits')" "~"
 
# if [ "$APP_ANSWER" == "32 bits" ]; then
#	POL_System_SetArch "x86"
# elif [ "$APP_ANSWER" == "$(eval_gettext '64 bits (recommended)')" ]; then
#	POL_System_SetArch "amd64"
# fi

POL_System_SetArch "amd64"

# Download Wine if necessary then create prefix
POL_Wine_PrefixCreate "6.0.1"
# POL_Wine_PrefixCreate

# POL_System_TmpCreate "$PREFIX"
             
Set_OS "win7"

#######################################
#  Hacks                              #
#######################################



#######################################
#  Installing mandatory dependencies  #
#######################################

# Avoid game freeze when doing ALT+TAB
POL_Wine_DirectInput "MouseWarpOverride" "force"


# POL_Call POL_Install_vcrun2013
# POL_Call POL_Install_d3dx11

# Disable DirectX 11
# POL_Wine_OverrideDLL "" "d3d11"


################
#      GPU     #
################

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Minimum memory size requiered for the graphic card.
POL_SetupWindow_VMS $GAME_VMS

# Asking about memory size of graphic card
# POL_SetupWindow_menu_list "How much memory does your graphics board have?" "$TITLE" "64-128-256-320-384-512-640-768-896-1024-1536-1792-2048-3072-4096" "-" "256"
# VRAM="$APP_ANSWER"
# POL_Wine_Direct3D "VideoMemorySize" "$VRAM"

# Useful for Nvidia GPUs
# POL_Call POL_Install_physx



#######################################
# Create a 'virtual desktop' (window) #
#######################################
  
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1368x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
    
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
  
Set_Desktop "On" "$WIDTH" "$HEIGHT"
  
Set_WineWindowTitle "$TITLE"


#############################################
#  Sound problem fix - pulseaudio related   #
#############################################
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix


#######################################
#  Main part of this script           #
#######################################
                 
# Choose between Steam and other Digital Download versions
# POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL,DOWNLOAD"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

# POL_SetupWindow_message "Warning: do not install Punk Buster nor DirectX." "$TITLE"
# POL_SetupWindow_message "Warning: do not install DirectX (nor the icons)." "$TITLE"
# POL_SetupWindow_message "Warning: do not install Visual C++ 2013 redistribuable\n nor Direct X." "$TITLE"
# POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"

# POL_SetupWindow_message "$(eval_gettext 'Note: at the end of the first installer (it does installs the downloader program), do not click RUN, instead close the window, then you will run the game from POL/POM.')" "$TITLE"


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
                      
elif [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_SetupWindow_cdrom
                      
        # POL_Call POL_Function_NoCDWarning
               
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
                     
        POL_Wine_WaitExit "$TITLE"
                  
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                     
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"

elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
             
        # POL_SetupWindow_message "$(eval_gettext '\n\nNote: this script will download the demo .')" "$TITLE"
        # POL_Download "https://genshinimpact.mihoyo.com/client_app/launcher/GenshinImpact_install_20200911204035.exe"
        POL_Download "https://genshinimpact.mihoyo.com/client_app/launcher/GenshinImpact_install_20201014173947.exe"
           
        mv GenshinImpact_install_20201014173947.exe GameInstaller.exe
        # mv X.rar gameinstaller.rar
        # mv X.zip gameinstaller.zip
           
        # POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        # POL_System_unrar x "gameinstaller.rar" "$WINEPREFIX/drive_c/game/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        # POL_System_unzip "gameinstaller.zip" -d "$WINEPREFIX/drive_c/game/"
             
        # Extract without sub-folder.
        # unzip "gameinstaller.zip" -j -d "$WINEPREFIX/drive_c/"
             
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
         
        cd  "$WINEPREFIX/drive_c/game/"
        POL_Wine "GameInstaller.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
     
        # POL_SetupWindow_message "$(eval_gettext '\n\nNote: do NOT install DirectX.')" "$TITLE"
  
        # cd "$WINEPREFIX/drive_c"
        # rm GameInstaller.exe
             
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
             
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                  
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
             
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.MSI')~$(eval_gettext '.EXE')" "~"
           
        APP_ANSWER=".EXE"
     
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the installation file (.EXE)')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
   
        # POL_SetupWindow_message "Note: please answer NO to all the questions that will appear." "$TITLE"
   
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
                 
        # Restore screen resolution (game's default is 640x480 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                   
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
  
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"


elif [ "$APP_ANSWER" == "$(eval_gettext '.MSI')" ]; then
       # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine msiexec /i  "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
                   
        # Restore screen resolution (game's default is 640x480 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                   
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
             
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
      
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
             
        # POL_SetupWindow_message "$(eval_gettext '\n\nWARNING: the file name must not have SPACES in its name !.')" "$TITLE"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/game/"
           
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
             
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
           
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/game/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
            
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
fi
fi

################
# Patch update #
################
 
# POL_SetupWindow_menu "$(eval_gettext 'Do you have a official patch-update to install ?')" "$TITLE" "$(eval_gettext 'No')~$(eval_gettext 'Yes')" "~"      
             
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi

#######################################
#  Hacks                              #
#  Editing configuration files        #
#######################################




POL_SetupWindow_message "$(eval_gettext 'Installation is finished.')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a huge log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"
             
# POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYqeWPQAKCRDlMfrJqhPK
R0m/AJwMeoPwSj5quZPrgqED66YNGF1/cgCgoVypUqFgKNkmlivqRMyo9e7QlsU=
=e+Lp
-----END PGP SIGNATURE-----
