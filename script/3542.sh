#!/bin/bash
# Date : (2019-06-12 14-10)
# Last revision : (2019-06-25 21-35)
# Wine version used : see below
# Distribution used to test : XUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested : version 1.00.000 (see in the file Setup.ini on the DVD). v1.1 according "version" file (once installed). And on the main screen: v1.1
#
# Game based on: DirectX 9, DRM TAGES (need Administrator account), Mozilla Xulrunner, Python, Pynche.
#
# CHANGELOG
# [Dadu042] (2019-06-12 14-10)
#   First script (Wine 4.0.3).
# [Dadu042] (2019-06-25 21-35)
#   ?
# [Dadu042] (2020-01-19 10:40)
#   Wine 4.0.1 -> 4.0.3.
#   Add POL_RequiredVersion
#
#
# KNOWN ISSUES:
# - Wine 3.0.5: Error 1158 when reinstalling (after a fail) with overwrite instead of erase.
# - Wine 4.0.1 and 3.21: Crash when the installer (InstallShield wizard) start working. 'msiexec.exe' does crash, log: Unhandled exception: unimplemented function msls31.dll.LssbFDonePresSubline called in 32-bit code (0x7b43f51c). Cause: POL_Install_riched30
# - Wine 3.0.3 and .5: Files of the games are not created (only folders created). In fact files are deleted by the installer when the button Finish is clicked.
# - wine 3.x: No music ( -> https://wiki.winehq.org/MIDI )
# - Wine 3.x and 4.x: "Error. File not found <OK>" when the installer (/english/setup.exe) does start. Fixed I don't remember how.


# - Wine 3.x.x: "Windows installer: File source not found: 1. Check if this file exist..." Trick: Instead to run \splash.exe  run \english\setup.exe
#
## - Wine 3.21: Once installed (+ NoCD). Game (simon4.exe) crash as soon started.

# Workaround about 'no files, only folders names' :
# 1. Copy 'drive_c/Program Files/Simon the Sorcerer - Chaos happens/' to a other folder name, then exit installer, then remove the old, then rename.
#
# 001f:fixme:ntoskrnl:KeInitializeTimerEx stub: 0x1127f8 0
# 0009:err:module:import_dll Library xul.dll (which is needed by L"C:\\Program Files\\Simon the Sorcerer - Chaos happens\\game.exe") not found
# 0009:err:module:attach_dlls Importing dlls for L"C:\\Program Files\\Simon the Sorcerer - Chaos happens\\game.exe" failed, status c0000135
#
# 2. Apply a NO CD. Run 'simon4.exe' instead of 'game.exe' (default).
# [06/25/19 10:10:06] - Running wine-3.0.5 simon4.exe (Working directory : /home/dadu042/.PlayOnLinux/wineprefix/simon_sorcerer_4_chaos_happens/drive_c/Program Files/Simon the Sorcerer - Chaos happens)
# 001f:fixme:ntoskrnl:KeInitializeTimerEx stub: 0x112818 0
# 0009:fixme:wbemprox:wbem_services_CreateInstanceEnum unsupported flags 0x00000030
# 0009:fixme:wbemprox:enum_class_object_Next timeout not supported
# 0009:fixme:win:EnumDisplayDevicesW ((null),0,0x32e988,0x00000000), stub!
# 0009:fixme:win:EnumDisplayDevicesW ((null),0,0x32e7f8,0x00000000), stub!
# 0009:fixme:ddraw:ddraw7_Initialize Ignoring guid {aeb2cdd4-6e41-43ea-941c-8361cc760781}.
# 0009:err:winediag:MIDIMAP_drvOpen No software synthesizer midi port found, Midi sound output probably won't work.
# 0041:fixme:ntdll:NtLockFile I/O completion on lock not implemented yet
# 0041:fixme:win:EnumDisplayDevicesW ((null),0,0x8cddc8,0x00000000), stub!
# 0041:fixme:d3dx:d3dx9_effect_init Failed to parse effect, hr 0x80004005.
# wine: Unhandled exception 0x80000003 in thread 41 at address 0x7b420023:0x7b43defc (thread 0041), starting debugger...


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Simon the Sorcerer 4 - Chaos Happens"
PREFIX="simon_sorcerer_4_chaos_happens"
WORKING_WINE_VERSION="4.0.3"
AUTHOR="Dadu042"
EDITOR="Playlogic Entertainment"
GAME_URL="https://pcgamingwiki.com/wiki/Simon_the_Sorcerer_4:_Chaos_Happens"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Call POL_Function_NoCDWarning

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"

# Fix the issue: 'when installing, game does does create folders but none files'. To check before to quit the installer because sometimes it does it before exiting.
POL_Call POL_Install_gecko

# Fix Installshield's 'error 1158' (when launching setup.exe)
POL_Call POL_Install_mfc42

# Necessary (otherwise no picture when game is launched)
POL_Call POL_Install_d3dx9
POL_Call POL_Install_d3dx9_43


# Indispensable ?:
# POL_Call POL_Install_mono210
# POL_Call POL_Install_dotnet20sp2
# POL_Call POL_Install_vcrun2005

# Seems not indispensable:
# POL_Call POL_Install_msxml4

# Required ?
# POL_Call POL_Install_xmllite


# Warning: makes 'msiexec.exe' crash at launching of InstallShield wizard (unimplemented function msls31.dll)
# However seems required... (as seen in the POL install log).
# POL_Call POL_Install_riched30
# POL_Call POL_Install_riched20

#######################################
# Create a 'virtual desktop' (window) #
#######################################

POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1024x768-1152x864-1280x720-1280x800-1280x900-1280x1024-1360x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "1024x768"
    
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
  
Set_Desktop "On" "$WIDTH" "$HEIGHT"
  
Set_WineWindowTitle "$TITLE"

###############
# Go          #
###############
 
POL_SetupWindow_InstallMethod "LOCAL,DVD"

# Workaround the issue 'no files, only folders names' :
POL_SetupWindow_message "To do: After the installer will finish, but before to click the Finish button, you will have to make a copy of the folder created (because all files will be deleted by the installer).\n\nLocation:\n~/.PlayOnLinux/wineprefix/simon_sorcerer_4_chaos_happens/drive_c/Program Files/Simon the Sorcerer - Chaos happens" "$TITLE"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom

	POL_SetupWindow_menu_list "$(eval_gettext "Choose the localization available on your DVD")" "$TITLE" "english-french-german-italian-spanish" "-" "english"
	localization_dvd="$APP_ANSWER"

        POL_SetupWindow_check_cdrom "$localization_dvd/Simon the Sorcerer.msi"
        
	# To avoid "Windows installer: File source not found: 1. Check if this file exist..."
	# POL_Wine start /unix "$CDROM/splash.exe"
	#
	# -s toggles silent installation.
	POL_Wine start /unix "$CDROM/$localization_dvd/setup.exe"

	POL_Wine_WaitExit "InstallShield"
        cd "$POL_System_TmpDir"
fi

# Workaround the issue 'no files, only folders names' :
POL_SetupWindow_message "To do: \n 1. You will have to delete the original game folder, then rename your copy (to the original name). \n2. Create manually the shortcut (to 'simon4.exe').\n3. Warning: Without a 'NoCD' applied, you will have the error message 'The Games Company: This account has not administration rights. ...' when trying to run the game." "$TITLE"
# 
# Note: even once the workaround above done (+ NoCD), under Wine 3.0.5 the game crash as soon launched.

# Useless because of the issue 'no files, only folders names' :
# POL_Shortcut "game.exe" "$TITLE - Launcher" ""
# POL_Shortcut "simon4.exe" "$TITLE - (ran by Launcher)" ""

# POL_Shortcut_Document "$TITLE" "*.pdf"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiQlHAAKCRDlMfrJqhPK
R3gLAJ9LQT52MfR6wYN1YEvpIO59AFh/eACfWkNWrkqW01AFIkZ/5m+NL6IDZ3o=
=YjJH
-----END PGP SIGNATURE-----
