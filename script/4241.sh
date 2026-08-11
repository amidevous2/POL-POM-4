#!/bin/bash
# Date : (2020-10-15)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 20.04 64 bits (Linux kernel v5.4.0). GPU: AMD Vega 11.
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: v1.0.1 (downloaded from FilePlanet.com).
#
# Middlewares used by this software : Clickteam Multimedia Fusion v3.
#
# CHANGELOG
# [Dadu042] (2020-10-15 10-00). 
#   Initial script. OK with Wine 5.19.
#
# KNOWN ISSUES :
#  - Wine amd64 5.19: when running Setup.exe, selecting a .INI language file is impossible because these are not displayed (extension filter is corrupted). Workaround: in the file name box, do type '*.ini' then enter.
#  - Wine amd64 5.19: the 'Castilian Spanish' translation file (ZIP) fail to extract. Perhaps because there is a strange character in a file name.
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 5.0.2: x


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Treasure Adventure Game"
PREFIX="Treasure_Adventure_Game"
EDITOR="Robit Studios"
GAME_URL="http://robitgames.com/"
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="256"
SHORTCUT_FILENAME="treasure*.exe"
SOFTWARE_CATEGORIES="Game;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE="read_me.txt"


# Starting the script
POL_SetupWindow_Init
                         
# Starting debugging API
POL_Debug_Init
        
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

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

POL_System_SetArch "auto"

# Download Wine if necessary then create prefix
POL_Wine_PrefixCreate


POL_System_TmpCreate "$PREFIX"
             
Set_OS "win7"

#######################################
#  Hacks                              #
#######################################

#######################################
#  Installing mandatory dependencies  #
#######################################

# POL_Call POL_Install_vcrun2008
# POL_Call POL_Install_corefonts

# Disable DirectX 11
# POL_Wine_OverrideDLL "" "d3d11"


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
POL_SetupWindow_InstallMethod "LOCAL"

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
        POL_Download "http://www2.tky.3web.ne.jp/~yosshin/my_works/CH170523.ZIP"
           
        # mv .exe GameInstaller.exe
        # mv X.rar gameinstaller.rar
        mv CH170523.ZIP gameinstaller.zip
           
        # POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        # POL_System_unrar x "gameinstaller.rar" "$WINEPREFIX/drive_c/game/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        POL_System_unzip "gameinstaller.zip" -d "$WINEPREFIX/drive_c/game/"
             
        # Extract without sub-folder.
        # unzip "gameinstaller.zip" -j -d "$WINEPREFIX/drive_c/"
             
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
         
        # cd  "$WINEPREFIX/drive_c/game/"
        # POL_Wine start /unix "GameInstaller.exe" # "/SILENT"
        # POL_Wine_WaitBefore "$TITLE"
     
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
           
        APP_ANSWER=".ZIP"
     
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


        POL_Shortcut "setup.exe" "$TITLE - Setup" "" "" "$SOFTWARE_CATEGORIES"

           
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

##############################
# Add Languages translations #
##############################

POL_SetupWindow_menu "$(eval_gettext 'The default game language is english.\nDo you want to automatically download a translation file ?')" "$TITLE" "$(eval_gettext 'No')~$(eval_gettext 'Castilian Spanish')~$(eval_gettext 'Chinese')~$(eval_gettext 'French')~$(eval_gettext 'German')~$(eval_gettext 'Deutch')~$(eval_gettext 'Polish')~$(eval_gettext 'Brazilian Portuguese')" "~"

cd "$WINEPREFIX/drive_c/game/"

if [ "$APP_ANSWER" == "$(eval_gettext 'French')" ]; then
        POL_Download "http://robitgames.com/tag-fan-translations/french_dialogue.ini"
	sed -i 's/english_dialogue.ini/french_dialogue.ini/' config.ini
elif [ "$APP_ANSWER" == "$(eval_gettext 'German')" ]; then
        POL_Download "http://robitgames.com/tag-fan-translations/german_dialogue.ini"
	sed -i 's/english_dialogue.ini/german_dialogue.ini/' config.ini
elif [ "$APP_ANSWER" == "$(eval_gettext 'Dutch')" ]; then
        POL_Download "http://robitgames.com/tag-fan-translations/dutch_dialogue.ini"
	sed -i 's/english_dialogue.ini/dutch_dialogue.ini/' config.ini
elif [ "$APP_ANSWER" == "$(eval_gettext 'Brazilian Portuguese')" ]; then
        POL_Download "http://robitgames.com/tag-fan-translations/brazilian_portuguese_dialogue.ini"
	sed -i 's/english_dialogue.ini/brazilian_portuguese_dialogue.ini/' config.ini
elif [ "$APP_ANSWER" == "$(eval_gettext 'Chinese')" ]; then
        POL_Download "http://robitgames.com/tag-fan-translations/chinese_dialogue.zip"
        POL_System_unzip "chinese_dialogue.zip" -d "$WINEPREFIX/drive_c/game/"	
	sed -i 's/english_dialogue.ini/tchinese_dialogue.ini/' config.ini
	cp readme.txt read_me.txt
elif [ "$APP_ANSWER" == "$(eval_gettext 'Polish')" ]; then
        POL_Download "http://robitgames.com/tag-fan-translations/polish_dialog.zip"
        POL_System_unzip "polish_dialog.zip" -d "$WINEPREFIX/drive_c/game/"
	sed -i 's/english_dialogue.ini/polish_dialogue.ini/' config.ini
	cp read_me_PL.txt read_me.txt
elif [ "$APP_ANSWER" == "$(eval_gettext 'Castilian Spanish')" ]; then
        POL_Download "http://robitgames.com/tag-fan-translations/TAG%20-%20Dilogo%20en%20Castellano.zip"
        # POL_System_unzip "TAG%20-%20Dilogo%20en%20Castellano.zip" -d "$WINEPREFIX/drive_c/game/"
        # Extract without sub-folder:
	mv TAG%20-%20Dilogo%20en%20Castellano.zip game.zip
        unzip "game.zip" -j -d "$WINEPREFIX/drive_c/game/"
	sed -i 's/english_dialogue.ini/spanish_dialogue.ini/' config.ini

fi


#######################################
#  Hacks                              #
#  Editing configuration files        #
#######################################


POL_SetupWindow_message "$(eval_gettext 'Installation is finished.')" "$TITLE"

# POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
             
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX4g3xwAKCRDlMfrJqhPK
R+XuAKCjdQgzl8LYdRbRPMDC+Dxw6w6RAwCfTA2E+bhn2gTpXF1GTAbYhFfws/U=
=E17U
-----END PGP SIGNATURE-----
