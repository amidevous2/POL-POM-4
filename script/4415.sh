#!/usr/bin/env playonlinux-bash
# Date : (2021-09-12 09:30)
  
# Wine version used : 6.17
# Distribution used to test : Kubuntu 21.04 amd64
# Author : Revd John Goodman
# Licence : GPLv3
# PlayOnLinux: 4.3.4
 
# CHANGELOG
# [Revd John Goodman] (2021-09-12 09:30)
#    First script.
#    Install wine 6.17 or newer
#    winetricks corefonts
#    winetricks settings fontsmooth=rgb
#    winetricks dotnet48
#    winetricks settings renderer=gdi (you might need to set the reg key manually)
#    Install the Logos.msi download but don't run it.
#    wine64 reg add "HKCU\\Software\\Wine\\AppDefaults\\LogosIndexer.exe" /v Version /t REG_SZ /d vista /f
#    Run Logos installer
#    Create Shortcut
# [Revd John Goodman] (2021-09-12 21:30)
#    Had to revise the code for registry entries

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#prevent mono installation
export WINEDLLOVERRIDES="mscoree,mshtml="
export TITLE="Logos Bible Software"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Faithlife" "http://www.logos.com" "Revd John Goodman" "LogosBibleSoftware"
POL_SetupWindow_message "$(eval_gettext 'For amd64 systems only. No 32bit support. Installing .NET can take 30 mins - it has not frozen. A free / paid account is required to use this software, visit: http://www.logos.com')" "$TITLE"

POL_System_TmpCreate "LogosBibleSoftware"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "https://downloads.logoscdn.com/LBS9/Installer/9.7.0.0025/Logos-x64.msi"
    INSTALLER="$POL_System_TmpDir/Logos-x64.msi"
fi

POL_Wine_SelectPrefix "LogosBibleSoftware"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "6.17"


POL_SetupWindow_wait "$(eval_gettext 'Installation in progress.')" "$TITLE"

# Install dependencies
POL_SetupWindow_wait "$(eval_gettext 'Installing Microsoft Corefonts')" "Corefonts"
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma2
POL_SetupWindow_wait "$(eval_gettext 'Installing .NET Framework. Please be aware that setting up .NET can take about 30mins. Setup has not hung or crashed.')" "$TITLE"
POL_Call POL_Install_dotnet480

POL_Wine_OverrideDLL "native" "mscoree"

###Set required wine options
#Font smoothing
POL_SetupWindow_wait "$(eval_gettext 'Enabling Font Smoothing')" "Fontsmoothing"
POL_Call POL_Function_FontsSmoothRGB

#Fix graphics draw glitches
#set manually
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Please wait setting Renderer to GDI...')" "$TITLE"
cat << EOF > "$REPERTOIRE/tmp/renderer.reg"
REGEDIT4
[HKEY_CURRENT_USER\Software\Wine\Direct3D]
"renderer"="gdi"
EOF
POL_Wine regedit "$REPERTOIRE/tmp/renderer.reg"


#Set required win version (win10 might also work)
POL_SetupWindow_wait "$(eval_gettext 'Setting Windows Version')" "win7"
Set_OS "win7"

#The indexer exe needs to be set to vista or it crashes (strange bug, took ages to figure)
POL_SetupWindow_wait "$(eval_gettext '')" "$TITLE"
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Please wait setting LogosIndexer.exe to vista...')" "$TITLE"
cat << EOF > "$REPERTOIRE/tmp/Indexer.reg"
REGEDIT4
[HKEY_CURRENT_USER\Software\Wine\AppDefaults\LogosIndexer.exe]
"Version"="vista"
EOF
POL_Wine regedit "$REPERTOIRE/tmp/Indexer.reg"

#run installer
POL_SetupWindow_wait "$(eval_gettext 'Running Logos Installer msi')" "$TITLE"
POL_Wine "$INSTALLER"

#cleanup
POL_System_TmpDelete

#create shortcut
POL_SetupWindow_wait "$(eval_gettext 'Creating Shortcut')" "$TITLE"
POL_Shortcut "Logos.exe" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'Setup Complete')" "$TITLE"
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYUNZ/AAKCRDlMfrJqhPK
Rx+YAJ9k8RDT2UZwkSrFF+AaEVwtJG4Q4ACdHAPqRSkQmAHrJi9SPjMnwa1SePU=
=/A5M
-----END PGP SIGNATURE-----
