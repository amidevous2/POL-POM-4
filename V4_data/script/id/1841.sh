#!/bin/bash
# Date : (2013-03-01)
# Last revision : (2013-10-25 18:55)
# Wine version used : 1.6
# Distribution used to test : Mac OS X 10.8.4
# Author : Marking
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Setup some needed variables
TITLE="Sono Hanabira ni Kuchizuke wo 02 - Watashi no Ouji-sama"
PREFIX="SonoHana_02"
WINEVERSION="1.6"
EDITOR="Fuguriya"
GAME_URL="http://fuguriya.sakura.ne.jp"
AUTHOR="Marking"

INSTALL_JP='インストール'
END_JP='終了'
YES_JP='はい'
 
# Download images for installation script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
# Initialize the script, debugging, and set required version
POL_SetupWindow_Init
POL_RequiredVersion "4.1.6" || POL_Debug_Fatal "$APPLICATION_TITLE 4.1.6 is required to install $TITLE"
POL_SetupWindow_SetID 1841
POL_Debug_Init
  
# Setup presentation window
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Begin setting up the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
SONOHANA="$WINEPREFIX/drive_c/$PROGRAMFILES/ふぐり屋/その花びらにくちづけを　わたしの王子さま/"
 
# Ask user for either DVD or Local installation
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    # Ask user to find "Setup.exe"
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please locate installation program (Setup.exe)')" "$TITLE"
    LANG="ja_JP.UTF-8" POL_Wine start /unix "$APP_ANSWER"
         
    # Tell user what to do while the installation program is running
    POL_SetupWindow_message "$(eval_gettext 'When the install program starts, click on ${INSTALL_JP}. When a new window opens, click on ${INSTALL_JP}. When installation finishes, click on ${END_JP} and then on ${YES_JP}. Click Next when you are done installing.')" "Installation instructions"
         
elif [ "$INSTALL_METHOD" = "DVD" ]
then
    # Launches the installation program from CD/DVD
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom
    LANG="ja_JP.UTF-8" POL_Wine start /unix "$CDROM/Setup.exe"
 
    # Tell user what to do while the installation program is running
    POL_SetupWindow_message "$(eval_gettext 'When the install program starts, click on ${INSTALL_JP}. When a new window opens, click on ${INSTALL_JP}. When installation finishes, click on ${END_JP} and then on ${YES_JP}. Click Next when you are done installing.')" "Installation instructions"
fi
 
# Tells users which language they want to use
POL_SetupWindow_menu "Which language would you like to read this in?" "Select Language" "日本語 (Japanese)|English" "|"
 
#For Japanese language
if [ "$APP_ANSWER" = "日本語 (Japanese)" ]
then
    # Apply fjfix to fix the visual novel
    FJFIX_PATCH="fjfix.zip"
    cd "$SONOHANA"
    POL_Download "http://files.markinglifestyle.com/sh_files/fjfix.zip" "789634f517003c1619eca669a83306a0"
    POL_System_unzip $FJFIX_PATCH
    POL_Wine_WaitExit "the fjfix patch"
    POL_Wine "fjfix.exe" -f MGD
     
    # Renames the main EXE file if installing the original version
    mv "$SONOHANA/HANABIRA2.EXE" "$SONOHANA/HANA2.EXE" 
    # Create a shortcut for easy access
    POL_Shortcut "HANA2.EXE" "その花びらにくちづけを　わたしの王子さま"
    # Insert a command to run as a Japanese application
    POL_Shortcut_InsertBeforeWine "その花びらにくちづけを　わたしの王子さま" "LANG=ja_JP.UTF-8"
     
#For English language    
elif [ "$APP_ANSWER" = "English" ]
then
 
    # Apply the English patch
    POL_SetupWindow_browse "$(eval_gettext 'Please locate English translation patch file')" "$TITLE"
    cp "$APP_ANSWER" "$SONOHANA/SH_EN.EXE"
    cd "$SONOHANA"
    POL_Wine_WaitExit "the English patch"
    LANG="ja_JP.UTF-8" POL_Wine "SH_EN.EXE"
     
    # Apply fjfix to fix the visual novel
    FJFIX_PATCH="fjfix.zip"
    cd "$SONOHANA"
    POL_Download "http://files.markinglifestyle.com/sh_files/fjfix.zip" "789634f517003c1619eca669a83306a0"
    POL_System_unzip $FJFIX_PATCH
    POL_Wine_WaitExit "the fjfix patch"
    POL_Wine "fjfix.exe" -f MGD    
    # Renames the main EXE file if installing the original version
    mv "$SONOHANA/HANABIRA2.EXE" "$SONOHANA/HANA2.EXE" 
    # Create a shortcut for easy access
    POL_Shortcut "HANA2.EXE" "A Kiss for the Petals - My Dear Prince"
    # Insert a command to run as a Japanese application/fix font issues
    POL_Shortcut_InsertBeforeWine "A Kiss for the Petals - My Dear Prince" "LANG=ja_JP.UTF-8"    
fi
    POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJqo30ACgkQ5TH6yaoTykfCewCeK+4OE9FRSgvBzuJRGrLIRdXa
TxQAoJPnZFLowAgK0uE7jqrrv4cjrZII
=hMVO
-----END PGP SIGNATURE-----
