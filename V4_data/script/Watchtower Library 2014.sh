#!/bin/bash
# Date : (2015-03-31 22-00)
# Last revision : (2015-04-02 07-37)
# Distribution used to test : Linux Mint 17
# Author: Vladislav Khomenko
# Wine version used: 1.7.35
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
# Variable
TITLE="Watchtower Library 2014"
PUBLISHER="Watchtower Bible and Tract Society of PA"
PREFIX="Watchtower"
URL="http://www.jw.org"
AUTHOR="Vladislav Khomenko"
DONE="FALSE"
WINEVERISON="1.7.35"
    
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
    
# Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 1959
POL_Debug_Init
    
# Presentation
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$URL" "$AUTHOR" "$PREFIX"
    
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERISON"
    
# Select Installation Method
POL_SetupWindow_InstallMethod "CD,LOCAL"
if [ "$INSTALL_METHOD" = "CD" ]
then
   POL_SetupWindow_cdrom
   POL_SetupWindow_check_cdrom "rs_data/PUBS"
   POL_Wine "$CDROM/Setup.exe"
elif [ "$INSTALL_METHOD" = "LOCAL" ]
then
   while [ "$DONE" = "FALSE" ]
   do
      POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"
      # Verify a the Setup.exe was selected and not another .exe
      if [ ${APP_ANSWER:(-9)} = "Setup.exe" ]
      then
         DONE="TRUE"
      else
         POL_SetupWindow_message "$(eval_gettext 'Setup.exe was not selected, Please select the setup file to run {Setup.exe}')" "$(eval_gettext 'File Selection Error')"
      fi
   done
   POL_Wine "$APP_ANSWER"
fi
    
# Wait for Installation to Exit
POL_Wine_WaitExit
    
POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed')" "Installation in progress"
    
# Create Shortcuts
POL_Shortcut "wtlibrary.exe" "$TITLE"
    
# Remove .lnk created on the desktop by wine installation application
test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
cd "${XDG_DESKTOP_DIR:-$HOME/Desktop}"
rm ./Watchtower*.lnk
    
# Close and Exit
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlUc1yMACgkQ5TH6yaoTykfrqACfXV+Bd6M52jJrmRhfqT/+OaZj
X+oAmwfBluwmEtrdLuusr2dfDei9CxAS
=DvyL
-----END PGP SIGNATURE-----
