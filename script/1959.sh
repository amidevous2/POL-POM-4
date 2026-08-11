#!/bin/bash
# Date : 2014-01-25 13-47
# Last revision : 2014-01-25 13-47
# Wine version used : 1.7.11
# Distribution used to test : MAC OSX 10.9.1
# Author : William Blake
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Variable
TITLE="Watchtower Library"
PUBLISHER="Watchtower Bible and Tract Society of PA"
PREFIX="Watchtower"
URL="http://www.jw.org"
AUTHOR="William Blake"
DONE="FALSE"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

# Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 1959
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$URL" "$AUTHOR" "$PREFIX"

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

# Select Installation Method
POL_SetupWindow_InstallMethod "CD,LOCAL"
if [ "$INSTALL_METHOD" = "CD" ]
then
   POL_SetupWindow_cdrom
   POL_SetupWindow_check_cdrom "rs_data/PUBS"
   POL_Wine start /unix "$CDROM/Setup.exe"
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
   POL_Wine start /unix "$APP_ANSWER"
fi

# Wait for Installation to Exit
POL_Wine_WaitExit

POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed')" "Installation in progress"

# Create Shortcuts
POL_Shortcut "wtlibrary.exe" "$TITLE"

# Remove .lnk created on the desktop by wine installation application
rm ~/Desktop/Watchtower*.lnk

# Close and Exit
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMTdJ0ACgkQ5TH6yaoTykcfEwCfbW3dwUzgySb0o151kpFBS7wt
7EQAn09jQZgUgnVls07Gy0SEMsky2Dpq
=kMAU
-----END PGP SIGNATURE-----
