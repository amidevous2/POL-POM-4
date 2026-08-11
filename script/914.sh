#!/bin/bash
# Date : (2011-03-08 21:00)
# Last revision : (2012-02-24 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading directx runtime
POL_Download_Resource "https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4"

# Installing directmusic
POL_SetupWindow_wait "$(eval_gettext 'Installing DirectMusic')" "$TITLE"
mkdir "dmusic"
cabextract -d dmusic/ -L -F 'dxnt.cab' directx_Jun2010_redist.exe

if [ "$POL_ARCH" == "amd64" ]; then
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'devenum.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dmband.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dmcompos.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dmime.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dmloader.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dmscript.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dmstyle.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dmsynth.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dmusic.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dmusic32.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'dswave.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'streamci.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F 'quartz.dll' "dmusic/dxnt.cab"
else
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'devenum.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dmband.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dmcompos.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dmime.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dmloader.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dmscript.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dmstyle.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dmsynth.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dmusic.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dmusic32.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'dswave.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'streamci.dll' "dmusic/dxnt.cab"
	cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F 'quartz.dll' "dmusic/dxnt.cab"
fi

# Registering directmusic
POL_Debug_Message "Registering DirectMusic dlls"
POL_SetupWindow_wait "$(eval_gettext 'Registering libraries, please wait\n(It can take a while)')" "$TITLE"
POL_Wine regsvr32 devenum.dll
POL_Wine regsvr32 dmband.dll
POL_Wine regsvr32 dmcompos.dll
POL_Wine regsvr32 dmime.dll
POL_Wine regsvr32 dmloader.dll
POL_Wine regsvr32 dmscript.dll
POL_Wine regsvr32 dmstyle.dll
POL_Wine regsvr32 dmsynth.dll
POL_Wine regsvr32 dmusic.dll
POL_Wine regsvr32 dswave.dll
POL_Wine regsvr32 quartz.dll

# Overriding dll
POL_Call POL_Function_OverrideDLL "native" "devenum" "dmband" "dmcompos" "dmime" "dmloader" "dmscript" "dmstyle" "dmsynth" "dmusic" "dmusic32" "dswave" "streamci" "quartz"

rm -rf "dmusic"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYZYaEgAKCRDlMfrJqhPK
R9xOAJ99LrLXoNsUkG5JsW0w2FVyvrUVHQCglZsFpzegQYOCL/Jku2bpZ5oP5oE=
=0JHp
-----END PGP SIGNATURE-----
