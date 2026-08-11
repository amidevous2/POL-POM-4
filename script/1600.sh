#!/usr/bin/env playonlinux-bash
# Date : (2013-03-01 17-00)
# Last revision : (2019-03-02 16-07)
# Wine version used : 4.0
# Distribution used to test : Ubuntu 12.10 with Nvidia Geforce 9800 GT 512MB using nvidia-experimental-310 driver Intel® Core™2 Duo CPU E4400 @ 2.00GHz×2 (lathis), Ubuntu 18.04 x64 with Nvidia Geforce GTX 1070, Intel Core i7-7700K @ 4.20GHz (LinuxScripter)
# Author : lahtis lahtis@gmail.com, LinuxScripter
# Script licence : GPLv.2
# Program licence : Retail
# Support France and English CD/DVD-version.
   
# CHANGELOG
# [SuperPlumus] (2013-07-24 09-13)
#   Update gettext messages
#   Clean code
#   Fix POL_Install_directplay call (missing POL_Call)
#   Fix $PLAYONLINUX variable check presence
# [LinuxScripter] (2018-05-02 21-15)
#   Reorganized the script to make it look cleaner and more uniform
#   Added MD5 sum to the patch file
#   Removed the unnecesseary mv command
# [LinuxScripter] (2019-03-02 16-07)
#   Using newer wine version
#   Changed the download links sicne the old ones expired
   
[ -z "$PLAYONLINUX" ] && exit
source "$PLAYONLINUX/lib/sources"
   
TITLE="Freelancer"
PREFIX="Freelancer"
WORKING_WINE_VERSION="4.0"
EDITOR="Microsoft game studios"
GAME_URL="http://www.microsoft.com/games/freelancer/default.aspx"
AUTHOR="lahtis, LinuxScripter"
   
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1600
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
   
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$PREFIX"
Set_OS "winxp"
 
POL_SetupWindow_VMS "128"
POL_Call POL_Function_SetResolution
POL_Call POL_Install_directplay
 
 
POL_SetupWindow_menu "What is your language version?" "Languages" "english|french" "|"
LANGUAGEVERSION="$APP_ANSWER"
    if [ "$APP_ANSWER" == "english" ]; then
        SETUPFILE="SETUP.EXE"
            LANG="Install Freelancer."
        elif [ "$APP_ANSWER" == "french" ]; then
        SETUPFILE="install.exe"
            LANG="Programme d'installation Freelancer."    
    fi
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "00000000.016"
POL_Wine start /unix "$CDROM/$SETUPFILE"
POL_Wine_WaitExit "$(eval_gettext '$LANG')"
#Patching the game to add support for more resolutions, first time the game will run at 1024x458 but now you can change it to match the virtual desktop
rm --force "$WINEPREFIX/drive_c/Program Files/Microsoft Games/Freelancer/EXE/d3d8.dll"
cd "$POL_System_TmpDir"
POL_Download "http://download.fileplanet.com/ftp1/062004/UnofficialFLSPPatch1.4.zip?st=hnULf7zeAqFzZz3vBBtAow&e=1551549858"
unzip "UnofficialFLSPPatch1.4.zip"
cd "./Fl"
cp --recursive -f "Data/*.*" "$WINEPREFIX/drive_c/Program Files/Microsoft Games/Freelancer/DATA"
cp -f "Exe/nameresources.dll" "$WINEPREFIX/drive_c/Program Files/Microsoft Games/Freelancer/EXE"
cd "$POL_System_TmpDir"
POL_Download "http://adoxa.altervista.org/freelancer/jflp.exe"
POL_Wine start /unix "jflp.exe"
POL_Wine_WaitExit "jflp.exe"
        
POL_Shortcut "Freelancer.exe" "$TITLE" "$TITLE.png"
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlx6yV0ACgkQ5TH6yaoTykc2IQCgpPsRcNcnckKsHa86/U2VR+i7
5TkAn1xGXhSyuyI/cSkWUDeJc2SBBkDA
=r/Kd
-----END PGP SIGNATURE-----
