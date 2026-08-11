#!/bin/bash
# Date : (2013-12-04)
# Last Revision : see changelog
# Wine version used : 1.5.22, 3.0.3
# Distribution used to test : Mint
# Author : MrTrip (phys1ks@gmail.com)
# Script licence : GPL v.2
# Program licence : Abandonware
# Depend :

#
# CHANGELOG
# [MrTrip] (2013-12-04)
#   Initial script
#   (posted only on: https://www.tribesnext.com/forum/index.php?topic=3300.0 ).
# [Dadu042] (2020-01-08 23:45)
#   (When tring to write a script, I found MrTrip's).
#   Note: Game name seems to have stabilized from TribesNEXT to TribesNext.
#   Wine 1.5.22 -> 3.0.3
#   POL_System_SetArch "x86"
#   Add Set_OS "winxp"
# [Dadu042] (2020-01-09 00:15)
#   Music now does play.

# KNOWN ISSUES:
#  - Wine x86 3.0.3, 3.20: intro videos not displayed (white background).
#  - Wine x86 3.0.3, 3.20: tiles visual effects on the menu's screens (moving the mouse does restore the background). Tried: d3dx9_43. Fix: game settings -> Video -> Disable vertical sync.

#
# KNOWN ISSUES (FIXED):
#  - Wine x86 3.0.3, 3.20: no music. Fix: amstream.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Tribes 2: TribesNext"
PREFIX="TribesNext"

POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Dynamix and TribesNEXT" "http://www.tribesnext.com" "MrTrip" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.20"

Set_OS "winxp"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_wait "Installing Required Libraries and such" "$TITLE"
# POL_Call POL_Install_d3dx9
POL_Call POL_Install_corefonts
POL_Call POL_Install_amstream
POL_Wine_InstallFonts

#############################################
#  Sound problem fix - pulseaudio related   #
#   to avoid some crashes with TribesNext   #
#############################################
 [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
 [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix


Set_Managed off
POL_SetupWindow_message "I will now install Tribes 2 for you and apply all updates. Please use all defaults! Do not register (the website is gone anyway). and DirectX 8 is optional but not needed." "$TITLE"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 if [ "$INSTALL_METHOD" = "LOCAL" ]
	then
		POL_SetupWindow_browse "Please select your Tribes2gsi.exe" "$TITLE"
		# POL_SetupWindow_wait "Running installer - please use all defaults!" "$TITLE"
		POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
		POL_Wine "$APP_ANSWER"
	        POL_Shortcut_Document "$TITLE" "Tribes*.pdf"
 elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
	then
		cd "$POL_System_TmpDir"
		POL_Download "http://xfer1.the-construct.net/tribes2/tribes2gsi.exe" "93460541ddd3bdff9b30829ba04f2186"
		POL_SetupWindow_wait "Downloading Installer - Please wait..." "$TITLE"
		POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
		POL_Wine "$APP_ANSWER"
	        POL_Shortcut_Document "$TITLE" "Tribes*.pdf"
 fi

POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_wait "Downloading required updates" "$TITLE"

# Download files
cd "$POL_System_TmpDir"
POL_Download "http://www.tribesnext.com/files/TribesNext_rc2a.exe" "3bec757215cd29b37d85b567edf8d693"

POL_Download "http://ftp.ruby-lang.org/pub/ruby/binaries/mswin32/unstable/ruby-1.9.0-2-i386-mswin32.zip" "01169969aae6e466f0c72f21ee77caf3"
# dead as of 2019-08-01
# POL_Download "ftp://ftp.ruby-lang.org/pub/ruby/binaries/mswin32/unstable/ruby-1.9.0-2-i386-mswin32.zip" "01169969aae6e466f0c72f21ee77caf3"

POL_SetupWindow_pulsebar "Installing Updates" "$TITLE"
POL_SetupWindow_set_text "Installing TribesNext"
POL_Wine start /unix "$POL_System_TmpDir/TribesNEXT_rc2a.exe"
POL_Wine_WaitExit "$TITLE"
POL_SetupWindow_pulse "25"

POL_SetupWindow_set_text "Applying Ruby fix"
cd "$POL_System_TmpDir"
unzip ruby-1.9.0-2-i386-mswin32.zip
mv "$WINEPREFIX/drive_c/Dynamix/Tribes2/GameData/msvcrt-ruby190.dll" "$WINEPREFIX/drive_c/Dynamix/Tribes2/GameData/msvcrt-ruby190.old"
cd bin
cp "msvcrt-ruby190.dll" "$WINEPREFIX/drive_c/Dynamix/Tribes2/GameData/"
POL_SetupWindow_pulse "75"

POL_SetupWindow_set_text "Overriding DLLs"
POL_Wine_OverrideDLL_App "Tribes2.exe" "native" "msvcrt"
POL_SetupWindow_pulse "90"

POL_SetupWindow_set_text "Removing temporary installer files"
#This fixes a stupid ass bug with POL selecting the Tribes2.exe from the tempinstall directory. I don't even know why T2 leaves that behind. Dumb dumb dumb.
cd $WINEPREFIX/drive_c/users/$USER/Temp/
rm -rf tempinstall
POL_SetupWindow_pulse "100"

POL_SetupWindow_message "The main setup is complete! Thanks to the community at TribesNext for making this possible! Special thanks to Dark Dragon DX, Plexor and Liukcairo for their testing and help in getting this running on Wine." "$TITLE"

POL_System_TmpDelete
POL_Shortcut "Tribes2.exe" "Tribes 2: TribesNext (online)" "" "-online" "Game;ActionGame;"
POL_Shortcut_InsertBeforeWine "Tribes 2: TribesNext (online)" "taskset 0x00000001"
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhZhqwAKCRDlMfrJqhPK
R+SkAKCNnkV7fnvq+nNDTgwJZXHFtSN3ywCeLDWGMKzA0hAV8Eum44CMI8BtpBE=
=KFYT
-----END PGP SIGNATURE-----
