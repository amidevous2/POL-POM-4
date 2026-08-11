#!/bin/bash
# Date : (2011-27-03 21-00)
# Last revision : (2013-06-22 16-59)
# Wine version used : 1.3.16, 1.3.23
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-06-22 16-59)
#   Update script POLv3 -> POLv4

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="FluidMark 1.3.1"
PREFIX="fluidmark"
WORKING_WINE_VERSION="1.3.23"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/fluidmark/top.jpg" "http://files.playonlinux.com/resources/setups/fluidmark/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Geeks3D" "http://www.geeks3d.com/" "GNU_Raziel" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_physx

# Downloading SCNB game (it's a freeware)
# Original thread : http://www.geeks3d.com/20101126/gpu-tool-fluidmark-1-3-0-gpu-physx-fluids-with-more-than-700k-sph-particles/
cd "$POL_System_TmpDir"
POL_Download "http://files.playonlinux.com/Geeks3D_PhysX_FluidMark_Setup_v1.3.1.exe" "dd0e007b0c9695d3da95f341b0dcf8b3"

POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$POL_System_TmpDir/Geeks3D_PhysX_FluidMark_Setup_v1.3.1.exe"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_VMS

POL_Wine_SetVideoDriver

[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"

POL_System_TmpDelete

POL_Shortcut "FluidMark.exe" "$TITLE" "$TITLE.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHFxLkACgkQ5TH6yaoTykfULQCglviaz3IuR+Hxd7uuCgA8fG7K
LFIAn10SGjvIwMvEQC+JsncwfZfIg71W
=YSjj
-----END PGP SIGNATURE-----
