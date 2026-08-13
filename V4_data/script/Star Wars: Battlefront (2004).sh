#!/bin/bash
# Date : (2014)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : KUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: local v1.2 from GOG.com


# CHANGELOG
# [Quentin P] (2014 ?)
#   Initial writting.
# [Dadu042] (2019-11-15 21:14)
#   Add install from local (tested GOG.com release, game v1.2), and from DVD.
#   Note: according https://appdb.winehq.org/objectManager.php?sClass=application&iId=3007
#         game from GOG (v1.2) allows Wine v4, while game 1.0 to 1.1 (from CD) prefers Wine 2.22 max.

# KNOWN ISSUES:
#  - Wine amd64 2.22: after selecting the .EXE (installer v1.2 from GOG), a mini window does open but nothing more. Fix: SetArch amd64 -> x86.
#  - Wine x86 2.22: loading is slow.
#  - Wine x86 2.22, 3.0 + LaunchBF.exe: only a white rectangle does appear (+ sound), lots of 'fixme:mshtml' in the log.
#  - Wine x86 3.15, 3.21, 4.0, 4.0.2: large jerkiness from the login window (video display and mouse cursor are jerky). Fix: Wine 4.19
#  - Wine x86 3.0.3: fail to save progress (of a profile). Log error: 'err:ole:CoGetClassObject class {ef985e71-d5c7-42d4-ba4d-2d073e2e96f4} not registered'. Fix: install mdac28 should help but install does fail ( https://github.com/Winetricks/winetricks/issues/1061 ).
#  - Wine x86 3.0.3, 3.0.5: after the status voices (ie: 'captured command post.') are played too late after the battle is won. Fix: Wine 3.10

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Star Wars - Battlefront (2004)"
PREFIX="StarWarsBattlefront2004"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "LucasArts" "" "Tinou" "$PREFIX"
 
POL_Call POL_Function_NoCDWarning

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.0.3"
POL_System_SetArch "x86"
Set_OS "winxp"

# Fix for 'err:ole:CoGetClassObject no class object {ca503b60-b176-11d4-a094-d0c0bf3a560c} could be created for context 0x1'
# Fix for 'err:ole:CoGetClassObject class {ef985e71-d5c7-42d4-ba4d-2d073e2e96f4} not registered'
POL_Call POL_Install_mdac28

POL_SetupWindow_InstallMethod "DVD,LOCAL,CD"
 
if [ "$INSTALL_METHOD" = "DVD" ]; then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Gamedata/Setup.exe"
        cd "$CDROM"
        POL_Wine --ignore-errors "$CDROM/Gamedata/Setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then        
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine  --ignore-errors  "$SETUP_EXE" # "/SILENT"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "CD" ]; then
POL_SetupWindow_message "PlayOnLinux will temporarily copy the three cdrom in you home directory.\nPlease ensure you have enought disk space\n\nPlease mount the first CD-ROM" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "LaunchBF.exe"
ORIGINAL_CDROM="$CDROM"
TEMP="$HOME/.PlayOnLinux/tmp/bf"
chmod 777 $TEMP -R
rm $TEMP -R
mkdir -p $REPERTOIRE/wineprefix/$PREFIXE_
mkdir -p $TEMP
cd "$REPERTOIRE/wineprefix/$PREFIXE_"
 
select_prefixe "$(pwd)"
POL_SetupWindow_prefixcreate
cd $WINEPREFIX/dosdevices
rm ./*
ln -s ../drive_c c:
ln -s / z:
ln -s $REPERTOIRE/tmp/jka d:
 
cd $TEMP
POL_SetupWindow_wait_next_signal "PlayOnLinux is copying the first CD-ROM" "$TITLE"
cp $CDROM//* ./ -r
chmod 777 $TEMP/ -R
 
POL_SetupWindow_detect_exit
POL_SetupWindow_message "Please insert the second CD-ROM" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "GameData/data3.cab"
 
POL_SetupWindow_wait_next_signal "PlayOnLinux is copying the second CD-ROM" "$TITLE"
cd $TEMP
cp $CDROM/* ./ -r
chmod 777 $TEMP -R
 
POL_SetupWindow_detect_exit
POL_SetupWindow_message "Please insert the third CD-ROM" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "GameData/data4.cab"
 
POL_SetupWindow_wait_next_signal "PlayOnLinux is copying the third CD-ROM" "$TITLE"
cd $TEMP
cp $CDROM/* ./ -r
chmod 777 $TEMP -R
 
POL_SetupWindow_detect_exit
 
POL_SetupWindow_wait_next_signal "PlayOnLinux is installing $TITLE ..." "$TITLE"
wine $TEMP/GameData/Setup.exe
 
POL_SetupWindow_detect_exit
POL_SetupWindow_reboot
 
POL_SetupWindow_wait_next_signal "Cleaning temp directory" "$TITLE"
chmod 777 $TEMP -R
rm $TEMP -R
cd $WINEPREFIX/dosdevices
rm ./d:
ln -s $ORIGINAL_CDROM ./d:
POL_SetupWindow_detect_exit

fi

POL_Shortcut "battlefront.exe" "$TITLE" "" "" "Game;Shooter;"
# POL_Shortcut "LaunchBF.exe" "$TITLE multiplayer" "" "" "Game;Shooter;"
POL_Shortcut_QuietDebug "$TITLE"

################
#      GPU     #
################
  
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXdVw4AAKCRDlMfrJqhPK
R1TtAJsGAC8rYyVX72sUqwSwSj5pjiHKbACgjVBfjQ6m7jWlZ4eR0QGL1jS4MZo=
=8OSy
-----END PGP SIGNATURE-----
