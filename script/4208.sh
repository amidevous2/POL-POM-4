#!/bin/bash
# Date: (2020-09-13 13:25)
# Last revision: (2020-09-13 13:25)
# Wine version used: 5.8
# Distribution used to test: Ubuntu 20.04
# Author: Dingo35
 
# ---------------------------------------------------------------------------------------------------------
 
# CHANGELOG
# Version 0.0.1 by Dingo35; tested with GarminExpress for Windows v7.1.3.0
# ---------------------------------------------------------------------------------------------------------
 
# Under BSD License!
 
# Copyright (c) 2018, Quentin Pâris, Eduardo Lucio and N0rbert, GuerreroAzul
# All rights reserved.
 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the free software community nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Quentin Pâris and Eduardo Lucio BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
# ---------------------------------------------------------------------------------------------------------
 
# Initialization!
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Garmin Express"
PREFIX="GarminExpress"
#wine 5.0, 5.8 work, 5.16 doesnt
WINEVERSION="5.8"
OSVERSION="vista"

POL_GetSetupImages "https://i.imgur.com/licFVuF.png" "https://i.imgur.com/ff6PkEZ.png" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 3064
 
POL_SetupWindow_presentation "$TITLE" "Garmin" "https://www.garmin.com/en-US/software/express/windows/" "Dingo35" "$TITLE"
 
POL_Debug_Init
# ---------------------------------------------------------------------------------------------------------
# Perform some validations!
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE might not work with $APPLICATION_TITLE $VERSION!\nPlease update!"

#check if winetricks present
winetricks -V || POL_Debug_Fatal "Please install winetricks before installing $TITLE!"

POL_System_SetArch "x86"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
SetupIs="$APP_ANSWER"
# ---------------------------------------------------------------------------------------------------------
# Prepare resources for installation!
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
#POL_SetupWindow_message "This installation is going to take a LONG time (maybe 30 minutes or more)!" "$TITLE" 
POL_SetupWindow_wait "This installation is going to take a LONG time (maybe 30 minutes or more)! I have to install .NET 4.7.2, and Microsoft decided I first have to install 4.0, then 4.5, then 4.6, then 4.6.1, then 4.6.2, and then finally 4.7.2...." "$TITLE"
Set_OS "$OSVERSION"
 
#for some reason the dotnet472 installation is not recognized by the application, so we have to use winetricks
#POL_Call POL_Install_dotnet472
winetricks -q dotnet472
POL_Call POL_Install_vcrun2010
#for some reason the d3dcompiler_47 is not giving a good result, so we have to use winetricks
#POL_Call POL_Install_d3dcompiler_47
winetricks d3dcompiler_47
#without corefonts the login window is not displayed correctly
winetricks corefonts
#it is really necessary to put it in Vista again, the previous installs put it on win7
#without it, the transfer of files to the device will not work
Set_OS "$OSVERSION"

# ---------------------------------------------------------------------------------------------------------
# Install!
POL_SetupWindow_message "$(eval_gettext 'Move this window over to the upper right part of your screen, so that it remains visible when the application shows up.')" "$TITLE" 
POL_SetupWindow_message "$(eval_gettext 'Now I will install Garmin Express. After installing, you will see a window that says: This application could not be started. You must etc. Do you want to view information about this issue? ANSWER NO!')" "$TITLE" 

POL_Wine "$SetupIs"

# ---------------------------------------------------------------------------------------------------------
# Create shortcuts, entries to extensions and finalize!
 
POL_Shortcut "express.exe" "$TITLE"
 
# ---------------------------------------------------------------------------------------------------------

POL_SetupWindow_message "$(eval_gettext 'Now Garmin Express is installed. If you start Garmin Express, only part of your screen is updated. Give the app 30 seconds to start up, then MOVE your mouse in the upper middle of the screen and parts of the screen WILL be visible. If you press a button full screen WILL appear.')" "$TITLE" 
POL_SetupWindow_message "$(eval_gettext 'After installation, if you are updating software and/or maps, make sure to be PATIENT. Progress bar will not move for a long time (sometimes 20 minutes or more) but behind the screens it IS updating your device. Good luck!')" "$TITLE" 

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX/IKfQAKCRDlMfrJqhPK
R3EQAKCGMKnTxqO4FcUB2Dq/jOapTXHvbgCaA/4iYH5B66gt/YlLxSMSoONILSw=
=/TuJ
-----END PGP SIGNATURE-----
