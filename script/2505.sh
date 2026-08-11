#!/usr/bin/env playonlinux-bash
# Date : (2015-04-21)
# Last revision : see changelog
# Distribution used to test : Linux Mint 20.1 Cinnamon
# Game Version tested : NW.131.20210906a.13
# Author : Ronin Dusette
# Licence : GPLv3
# PlayOnLinux : 4.3.4
#
# Changelog:
# 2019-05-20 Dadu042: Add suppport for dual GPU. Upgrade wine 4.5-staging to 4.8. Add warning POL version required.
# 2020-02-10 Yaotl: Update Wine 4.0.1 > 4.0.3; Various script fixes.
# 2020-07-10 Yaotl: Update Wine 4.0.3 > 5.0.1; Small script updates.
# 2020-07-31 Yaotl: Enable UseGLSL & Enable OpenGL; Add set Mouse DirectInput
# 2020-09-30 Dadu042: Update Wine 5.0.1 > 5.0.2
# 2021-04-12 Yaotl: Update Wine 5.0.1 > 6.0; remove Mouse DirectInput; DXVK_181 installation option added; Download url updated.
# 2021-06-15 Yaotl: Update Wine 6.0 > 6.0.1; Download url updated; other small script changes.
# 2021-09-18 Dae: restore old link
# 2021-09-19 Yaotl: Script changed
# 2021-09-23 Yaotl: dll fix, Update Wine 6.0.1(Stable) > 6.17(Development)
# 2021-10-10 Yaotl: Script clean again

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Neverwinter Online"
PREFIX="NeverwinterOnline"
WINEVERSION="6.17"
DOWNLOAD_URL="http://download.perfectworld.com/nw/launcher/Neverwinter.exe"
MD5_CHECKSUM="7bf87d6886bef4b278895fa4d85d50d0"

#Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 2505
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "Perfect World Entertainment Inc." "https://www.arcgames.com/games/neverwinter" "RoninDusette" "$PREFIX"

# Checks the required POL/POM version
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

# Create Prefix
POL_System_SetArch "amd64"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Dependencies
POL_Call POL_Install_corefonts
POL_Call POL_Install_d3dcompiler_46
POL_Call POL_Install_d3dcompiler_47
POL_Call POL_Install_d3dx9
POL_Call POL_Install_d3dx10
POL_Call POL_Install_d3dx11
POL_Call POL_Install_physx
POL_Call POL_Install_vcrun2019
POL_Call POL_Install_xinput

# Asking about memory size of graphic card
POL_SetupWindow_VMS ${GAME_VMS}

POL_Wine_Direct3D "UseGLSL" "enabled"
POL_Wine_Direct3D "DirectDrawRenderer" "opengl"

# Set Graphic Card informations keys for wine
POL_Call POL_Install_VideoDriver

# Installation
mkdir -p "$WINEPREFIX/drive_c/Program Files/Neverwinter Online"
cd "$WINEPREFIX/drive_c/Program Files/Neverwinter Online"
POL_Download "$DOWNLOAD_URL" "$MD5_CHECKSUM"

# Create Shortcut
POL_Shortcut "Neverwinter.exe" "$TITLE" "" "" "Game;RolePlaying;"

# Game Configuration
POL_System_TmpCreate "$PREFIX"
cd $POL_System_TmpDir

if [ "$POL_LANG" = "en" ]; then # English
    lang="1033"
elif [ "$POL_LANG" = "de" ]; then # German
    lang="1031"
elif [ "$POL_LANG" = "fr" ]; then # French
    lang="1036"
elif [ "$POL_LANG" = "it" ]; then # Italian
    lang="1040"
elif [ "$POL_LANG" = "ru" ]; then # Russian
    lang="1049"
else # English
    lang="1033"
fi

cat << EOF > "lang.reg"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Cryptic\Neverwinter]
"DisableMicropatching"=dword:00000001
"InstallLanguage"="$lang"
"InstallLocation"="C:/Program Files/Neverwinter Online"
EOF
POL_Wine regedit "lang.reg"

if [ "$POL_OS" = "Linux" ]; then
    POL_SetupWindow_checkbox_list "Optimal components:" "$TITLE" "DXVK" "~"
    if [ "$(echo $APP_ANSWER | grep -o "DXVK")" != "" ]; then
        POL_Call POL_Install_DXVK
    fi
fi

# Cleanup
POL_System_TmpDelete
POL_SetupWindow_message "$(eval_gettext 'NOTICE: $TITLE can take up to 15 minutes or longer to start for the first time. It only does this the first time the game has be ran.')" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYWcBKQAKCRDlMfrJqhPK
R4i7AJ9kdC9RUGa6UYYzTATVUun1/mAtaACgpxeGxcQDv6nBd/PnvO6RWLfU84s=
=WuG7
-----END PGP SIGNATURE-----
