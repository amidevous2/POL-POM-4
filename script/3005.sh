#!/usr/bin/env playonlinux-bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# CHANGELOG
# [WarfaceZ] (2013 ?)
#   First script.
# [Dadu042] (2019-11-13)
#   Wine 1.9.15 -> 3.0.3

TITLE="League of Angels 2"
PREFIX="LeagueOfAngels2"
 
WINEVERSION="3.0.3"
SHORTCUT_NAME="League of Angels 2"

POL_SetupWindow_Init
 
POL_SetupWindow_presentation "League of Angels 2"
POL_SetupWindow_InstallMethod "LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"
 
    if strings "$APP_ANSWER"|grep -q '\(name="Pando Media Booster Downloader"\|Advanced Installer\)'; then
        NOBUGREPORT="TRUE"
        POL_Debug_Fatal "$(eval_gettext 'Cant install using the official downloader, sorry')"
    fi
    FULL_INSTALLER="$APP_ANSWER"
then
    POL_SetupWindow_browse
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd
    POL_Download
fi
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "LeagueOfAngels2"
POL_Wine_PrefixCreate "$WINEVERSION"
 
POL_Call POL_Install_corefonts
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_d3dx9
 
Set_OS "win7"
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$FULL_INSTALLER"
 
Set_OS winxp

POL_Wine_OverrideDLL_App "firefox.exe" "native"


POL_Shortcut "LOA2.exe" "League of Angles 2"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcx2RwAKCRDlMfrJqhPK
R7mAAKCWKb5ycJj257TyO68FoaAxdyYwLQCeL60P9JNvhAFMoxPVpr5TSR8edE8=
=rnNO
-----END PGP SIGNATURE-----
