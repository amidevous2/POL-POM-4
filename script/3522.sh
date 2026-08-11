#!/usr/bin/env playonlinux-bash
# Date : (2019-05-22 12-38)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 18.04.4 (64 bits)
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software versions used to write this script: 427385-hyxd-1.0.19-overseas-setup.exe (2019-07)
#                                              439464-hyxd-1.0.21-overseas-setup.exe (2020-05)
#                                              439485-hyxd-1.0.22-overseas-setup.exe (2020-08)
#                                              479093-hyxd-1.0.26-overseas-setup.exe (2020-12)
#
# Game based on: DirectX 9 (v43) and 10 (v43), Visual C++ 2010.
#
#
# CHANGELOG:
# [Dadu042] (2019-05-22 20-50)
#   Installation does start (it download 5 Gb). Not tried further. Software installer is in chinese.
# [Dadu042] (2019-07-02 10-07)
#   Remove WORKING_WINE_VERSION because the current problem is to manage to pass the freezed login window.
# [Dadu042] (2020-05-24 18-00)
#   Wine system version -> 5.0
#   Game does launch but is unplayable because of no keyboard access. Not tried: a gamepad.
#   Note (languages): the installer is Chinese only, user licences too, then in the game multiple languages are available.
# [Dadu042] (2020-06-10 18-00)
#   64 bits -> 32 bits
#   Wine 5.0 -> 5.0.1
#   Disable wininet and vcrun2010 (seems useless)
# [Dadu042] (2020-06-17 17-00)
#   Wine 5.0.1 -> 5.10
#   Add vcrun2008, to fix the 'no keyboard' issue (does not work with Wine 5.0.1).
# [Dadu042] (2020-06-17 18-00)
#   Keyboard issue again on the same computer. The game does not use vcrun2008 but vcrun2010.
#   Remove vcrun2008
# [Dadu042] (2020-07-02 12-00)
#   Add argument '-d3d9' (seems to remove the few debug lines about DirextX 11). Wrong: it was because of DXVK.
# [Dadu042] (2020-09-08 12-00)
#   Wine 5.0.1 -> 5.0.2. Same 'no keyboard issue'.
#   Note: I reinstalled with OS set as 'winxp' instead of 'win7', after confirming login (window displayed on a black background), the screen does freeze. Tried: Gecko, xmllite.
# [Dadu042] (2021-01-05 12-00). Note: I managed to run the game on vanilla Wine 5.22 with game v1.0.26 (for Win 7).
#   Arch 32 bits
#   Add comments.
#
#
# KNOWN ISSUES: 
# - wine 4.0.4, 5.0.2, 5.12: Each time the game does launch, user has to approve the 'Privacy and user agreement'.
# - wine 4.0.4, 4.21-staging 5.0, 5.7, 5.0.1, 5.0.2, 5.10, 5.13-staging, 5.16, 5.17-staging: once the game is started (waiting for new users), keyboard does not work anymore. Tried: xact.
# - wine 4.0.4, 5.0, 5.7: lot of these lines in the debug log ' :fixme:d3d_shader:shader_sm4_read_instruction_modifier Unhandled modifier ...'. Tried: POL_Install_d3dx9_43 + compiler.
# 
#
# Log:  007a:err:ole:CoGetClassObject class {745057c7-f353-4f2d-a7ee-58434477730e} not registered
#       issue related to ?: https://bugs.winehq.org/show_bug.cgi?id=37868
#
# KNOWN ISSUES FIXED:

# - wine 4.0.4: Launcher does not launch anything. Run Hyxd.exe instead.
# - (2019-07) Wine 4.0.1, 4.8, 4.11: When starting the game for the first time, the little window where to login (trough Google/Facebook) does not respond. Note: it is possible to workaround the little window by clicking fast at the button at the top right ('Log in via Browser'). Fix (2020-05): Wine 4.0.4, 4.21, 5.0
# - wine 5.22 64bits: game fail to run, nothing does appear, even with DXVK (v1.7.3) installed. Workaroud: reinstall game in 32bits prefix.
#
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
      
TITLE="Knives Out"
PREFIX="knives_out"
WORKING_WINE_VERSION="5.22"
AUTHOR="Dadu042"
EDITOR="NetEase Games"
GAME_URL="http://knivesout.163.com"
GAME_VMS="256"
 
POL_SetupWindow_Init
POL_Debug_Init
      
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
 
POL_Wine_SelectPrefix "$PREFIX"
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"        # Knives Out v1.0.26 does not run if installed in 64 bits mode (Wine 5.22).
# POL_System_SetArch "auto"

# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_Wine_PrefixCreate $WORKING_WINE_VERSION
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"

#######################################
#  Installing mandatory dependencies  #
#######################################
 
# Inspired from the Lutris script (2019-07-03)
# POL_Call POL_Install_vcrun2010
# POL_Call POL_Install_wininet


################
#      GPU     #
################
            
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
             
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
              
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx   # I'm not sure if it works fine (Dadu042, 2020-06)

###############
# Main part   #
###############
      
POL_SetupWindow_InstallMethod "LOCAL"
      
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
fi
 
POL_Shortcut "launcher.exe" "$TITLE - Launcher (do not use: it fail to run)" ""  "-d3d9" "Game;Shooter;"
POL_Shortcut "hyxd.exe" "$TITLE (Hyxd.exe)"  "" "-d3d9" "Game;Shooter;"
 
# POL_Shortcut_Document "$TITLE" "doc.pdf"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a huge log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX/SUTAAKCRDlMfrJqhPK
R7TXAKCYtG/VhnrjwptbO+m8EJ+1jH9khACgsl3ZjrDZIP7QBGRJGTPgtfY8PBU=
=YAXP
-----END PGP SIGNATURE-----
