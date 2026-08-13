#!/bin/bash
# Date : (2013-07-19 01-51)
# Last revision : (2015-09-27 22-02)
# Wine version used : 1.7.51
# Distribution used to test : Debian Jessie (testing),Ubuntu 15.04
# Authors : Steven Wilson (steve723, modified to add Origin
#            download support using Origin script by
#            GNU_Raziel: http://www.playonlinux.com/en/
#            changelog-1059-EAs_Origin.html (?)
#           jre
#           LinuxScripter (changing wine version(big thanks to jre for telling me this),
#            removal of some obsolete lines since patching QT5Network.dll is no longer necessary)
# Licence : GPLv3
  
# The initial version of this script was tested using the
# DVD version of 'SimCity 2013' bought in Sweden 2013
# with wine 1.6-rc2, xUbuntu 13.10
  
# The Origin version of this script was tested:
# Older Origin       with wine 1.5.28-Origin
# Origin 9.4.12.2807 with wine 1.7.23
# Origin 9.5.1.571   with wine 1.7.30
# Origin 9.8.3.59237 with wine 1.7.51
 
# This script mimics the HOWTO from the wine AppDB:
# https://appdb.winehq.org/objectManager.php?sClass=version&iId=27821
# Check TROUBLESHOOTING there first, if you have any issues.
  
# Known bugs:
# * Origin needs Job Objects (a wine by POL using the patch
#   from wine bug #33723 would be nice).
#   Then this would work:
#   - Installation finishes automatically (no
#     "kill EAProxyInstaller.exe" necessary).
#   - Origin doesn't complain that SimCity is still
#     running after quitting SimCity.
#   - Update of "Last Played/Time Played" in Origin.
#   Otherwise AFAIK there are no big gains with this (jre).
# * Sometimes graphic glitches.
#   (I guess depending on certain hardware, jre.)
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="SimCity 2013"
TITLE2="Origin"
AUTHOR=""
PREFIX="SimCity2013"
WORKINGWINEVERSION="2.22"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Maxis" "http://www.simcity.com/" "$AUTHOR" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
  
# Set and install the correct Wine version
POL_Wine_PrefixCreate "$WORKINGWINEVERSION"
  
# Installing mandatory dependencies
# (They were recommended sometime, but I've found none of them to be necessary here, jre)
# (They might become necessary depending on wine version used and hardware, LinuxScripter)
#POL_Wine_InstallFonts
#POL_Function_FontsSmoothRGB
#POL_Call POL_Install_wininet # Fix EA Connexion's issue 1
#POL_Call POL_Install_vcrun2010
#POL_Call POL_Install_vcrun2008
#POL_Call POL_Install_vcrun2005
#POL_Call POL_Install_directx9 (probably crashes SimCity)
# MS Visual C++ 2008 Runtime with SP1 and
# MS DirectX (D3DX9_43.dll and d3dx9_31.dll) come with SimCity itself.
 
#This is installed in order to avoid MSVCP120.dll error.
POL_Call POL_Install_vcrun2013
 
POL_SetupWindow_InstallMethod "DVD,ORIGIN"
  
# DVD method
if [ "$INSTALL_METHOD" = "DVD" ]
then
  
    # Let the user select a DVD
    POL_SetupWindow_cdrom
  
    # Check if this DVD is the SimCity 2013 DVD
    POL_SetupWindow_check_cdrom "SimCity.zip"
  
    # Run installer
    taskset -c 0 POL_Wine start /unix "$CDROM/Setup.exe"
  
# Origin method
elif [ "$INSTALL_METHOD" = "ORIGIN" ]
then
  
    # Download latest Origin (gets updated constantly, so no md5sum available)
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    POL_Download "https://download.dm.origin.com/origin/live/OriginSetup.exe" ""
  
    POL_SetupWindow_message "$(eval_gettext 'You are close to installing $TITLE2.\n\nPress NEXT now to start the installation of $TITLE2.\n\nThen follow the graphical install setup. It might crash with "Please reinstall Origin" error.\n\nIn that case copy the contents of a working setup from VM or dual boot.\n\nThen you will have to manually kill EAProxyInstaller.exe')" "$TITLE"
  
    # Installing Origin
    POL_Wine start "OriginSetup.exe"
    # Kill Origin if the user still started it
    [ "$(ps aux | grep -c Origin.exe)" -lt 2 ] || killall Origin.exe
fi
  
    # Remove the temporary directory
    POL_System_TmpDelete
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Origin"
    POL_Wine start "Origin.exe"
  
fi
  
POL_SetupWindow_message "$(eval_gettext 'Please wait while $TITLE is installed.\n\nIf the $TITLE installer gets stuck (after downloading) on `Installing...` for more then 5 minutes press NEXT, the script will then try to fix this for you.\n\nPress NEXT when the installation is complete.\n')" "$TITLE"
  
# Kill EAProxyInstaller, which causes the installation not to finish
[ "$(ps aux | grep -c EAProxyInstaller.exe)" -lt 2 ] || killall EAProxyInstaller.exe
  
# Origin In Game has to be disabled
# Otherwise the SimCity start screen will load, but upon "Connecting to servers" SimCity will crash.
 
POL_SetupWindow_message "$(eval_gettext 'The installation of $TITLE should now be complete.\n\nIMPORTANT:\nIn the $TITLE2 window go to ´Origin - Application Settings - Origin In Game´ and disable ´Enable Origin In Game´.\n\nThen close the $TITLE2 window and press NEXT. (If you can not close $TITLE2, just press NEXT and the script will attempt to close it for you.)\n')" "$TITLE"
  
# (Again, in case the user clicked NEXT to early before)
# Kill EAProxyInstaller, which causes the installation not to finish
[ "$(ps aux | grep -c EAProxyInstaller.exe)" -lt 2 ] || killall EAProxyInstaller.exe
  
# Kill Origin if user didn't/couldn't close it
[ "$(ps aux | grep -c Origin.exe)" -lt 2 ] || killall Origin.exe
  
# Create shortcuts
POL_Shortcut "Origin.exe" "Origin - $TITLE" "" "" "Game;"
  
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLECOMPLETE"
  
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYEzqUgAKCRDlMfrJqhPK
R6vRAJ9kZXnvPMpXjsHvPlDBtt+NdifljQCdH4ObrGGUHD/867goPbDPLRxmTpM=
=5J1f
-----END PGP SIGNATURE-----
