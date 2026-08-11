#!/bin/bash
# Date : (2010-05-23)
# Last revision : (2010-05-23)
# Wine version used : 1.0.1
# Distribution used to test : Ubuntu 9.10
# Author : Marco Gerards
# Licence : GPLv3
# Depend : none

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Zeus: Master of Olympus"
AUTHOR="Marco Gerards"
PREFIX="Zeus"
PREFIXDIR="$REPERTOIRE/wineprefix/$PREFIX"
WORKINGWINEVERSION="1.0.1"

wget http://upload.wikimedia.org/wikipedia/en/8/8e/Master_of_Olympus_-_Zeus_Coverart.png --output-document="$REPERTOIRE/tmp/leftnotscaled.png"
convert "$REPERTOIRE/tmp/leftnotscaled.png" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

# Note: http://sierra-online.co.uk does not work anymore
POL_SetupWindow_presentation "$TITLE" "Sierra" "http://sierra-online.co.uk" "$AUTHOR" "$PREFIX"
select_prefix "$PREFIXDIR"

# Let the user select a CDROM
POL_SetupWindow_cdrom

# Check if this CDROM is the correct CDROM
POL_SetupWindow_check_cdrom "/ZEUS.ICO"

# To make sure the user has the same environment as the game was
# tested with.
POL_SetupWindow_install_wine "$WORKINGWINEVERSION"

Use_WineVersion "$WORKINGWINEVERSION"

POL_SetupWindow_prefixcreate

if [ -e "$CDROM/version.txt" ] ; then
  VERSION=`cat "$CDROM/version.txt" | grep version`
  VERSION=${VERSION:24:7}
else
  # The version of Zeus sold in Europe does not have a version.txt.
  # Hopefully this covers all versions of the game.
  VERSION="EU"
fi

# The USA version of the Game has an additional message box and uses
# by default a different path to install to.
if [ "$VERSION" = "1.0.0.0" ] ; then
  APPNAME="Zeus"
cat <<EOF >>"$WINEPREFIX/drive_c/Zeus.iss"
[InstallShield Silent]
Version=v5.00.000
File=Response File

[DlgOrder]
Dlg0=SdLicense-0
Count=9
Dlg1=SdWelcome-0
Dlg2=SdSetupTypeEx-0
Dlg3=SdAskDestPath-0
Dlg4=MessageBox-0
Dlg5=AskOptions-0
Dlg6=MessageBox-1
Dlg7=AskYesNo-0
Dlg8=SdFinishReboot-0

[SdLicense-0]
Result=1

[SdWelcome-0]
Result=1

[SdSetupTypeEx-0]
Result=Full Install

[SdAskDestPath-0]
szDir=C:\Sierra\Zeus
Result=1

[Application]
Name=Zeus
Version=1.0
Company=Sierra On-Line

[MessageBox-0]
Result=1

[AskOptions-0]
Result=1
Sel-0=0
Sel-1=1

[MessageBox-1]
Result=1

[AskYesNo-0]
Result=0

[SdFinishReboot-0]
Result=1
BootOption=0

EOF
elif [ "$VERSION" = "1.1.0.0" ] ; then
  APPNAME="Zeus"
cat <<EOF >>"$WINEPREFIX/drive_c/Zeus.iss"

[InstallShield Silent]
Version=v5.00.000
File=Response File

[DlgOrder]
Dlg0=SdLicense-0
Count=11
Dlg1=SdWelcome-0
Dlg2=SdSetupTypeEx-0
Dlg3=SdAskDestPath-0
Dlg4=MessageBox-0
Dlg5=MessageBox-1
Dlg6=MessageBox-2
Dlg7=AskYesNo-0
Dlg8=MessageBox-3
Dlg9=AskYesNo-1
Dlg10=SdFinishReboot-0

[SdLicense-0]
Result=1

[SdWelcome-0]
Result=1

[SdSetupTypeEx-0]
Result=Full Install

[SdAskDestPath-0]
szDir=C:\Sierra\Zeus
Result=1

[Application]
Name=Zeus
Version=1.0
Company=Sierra On-Line

[MessageBox-0]
Result=1

[MessageBox-1]
Result=1

[MessageBox-2]
Result=1

[AskYesNo-0]
Result=0

[MessageBox-3]
Result=1

[AskYesNo-1]
Result=0

[SdFinishReboot-0]
Result=1
BootOption=0

EOF
elif [ "$VERSION" = "EU" ] ; then
  APPNAME="Master of Olympus - Zeus"
cat <<EOF >> "$WINEPREFIX/drive_c/Zeus.iss"
[InstallShield Silent]
Version=v5.00.000
File=Response File
 
[DlgOrder]
Dlg0=SdLicense-0
Count=8
Dlg1=SdWelcome-0
Dlg2=SdSetupTypeEx-0
Dlg3=SdAskDestPath-0
Dlg4=MessageBox-0
Dlg5=AskOptions-0
Dlg6=AskYesNo-0
Dlg7=SdFinishReboot-0
 
[SdLicense-0]
Result=1
 
[SdWelcome-0]
Result=1
 
[SdSetupTypeEx-0]
Result=Full Install
 
[SdAskDestPath-0]
szDir=C:\Sierra\Master of Olympus - Zeus
Result=1
 
[Application]
Name=Master of Olympus - Zeus
Version=1.0
Company=Sierra On-Line
 
[MessageBox-0]
Result=1
 
[AskOptions-0]
Result=1
Sel-0=0
Sel-1=1
 
[AskYesNo-0]
Result=0
 
[SdFinishReboot-0]
Result=1
BootOption=0
 
EOF

fi

# Show the EULA after converting the codepage
iconv -f CP1250 <"$CDROM/EULA.TXT" >"$REPERTOIRE/tmp/EULA.TXT"
POL_SetupWindow_licence "Please read carefuly the following terms of service" "EULA" "$REPERTOIRE/tmp/EULA.TXT"

# Run the installer
POL_SetupWindow_wait_next_signal "Installing game..." "$TITLE"
wine "$CDROM/SETUP.EXE" -s -f1"c:\Zeus.iss" 
POL_SetupWindow_detect_exit

wine reboot

# Use OSS, since using ALSA results in noise
Set_SoundDriver "oss"

# Setup an icon for the game
cd "$WINEPREFIX/drive_c/Sierra/$APPNAME"
convert zeus.ico zeus.png
cp zeus-1.png "$HOME/.PlayOnLinux/icones/32/$TITLE"

# Make a short cut
POL_SetupWindow_make_shortcut "$PREFIX" "Sierra/$APPNAME" "Zeus.exe" "" "$TITLE"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TITLE"

# Done!
POL_SetupWindow_message "$TITLE installed"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF4ACgkQ5TH6yaoTykfXjwCeL8WO2G2+udQpirNHqXddUqIU
3isAn0w26UFwZPrGgUEwnO4lj4FSxhN9
=jHui
-----END PGP SIGNATURE-----
