#!/bin/bash
# PlayOnLinux Function
# Date : Unknown
# Last revision : (2021-06-02 02:31)
# Author : Berillions
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# [Berillions] (2013 ?)
#
# [petch] (2013-01-22 16:49)
#   Fixing bug #1787
# [Dadu042] (2019-09-05 18:21)
#   Update URLs.
#   Remove FR case.
# [Yaotl]
#   Update hash values

FORCE_MODE=$1

# Installing x64 version
if [ "$POL_ARCH" = "amd64" ]; then
        # Downloading vcrun2005 sp1 x64 EN
        POL_Download_Resource "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE" "e231fbcce2c2cb16dcc299d36c734df3" "vcrun2005"
fi

# Downloading vcrun2005 sp1 x86 EN
POL_Download_Resource "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE" "4f1611f2d0ae799507f60c10ff8654c5" "vcrun2005"


# Check if vcrun2005 is already installed
CHECK_VC2K5=`find $WINEPREFIX -name "msdia80.dll"`
if [ "$CHECK_VC2K5" = "" -o "$FORCE_MODE" = "--force" ]; then
        if [ "$CHECK_VC2K5" != "" ]; then
                POL_SetupWindow_message "$(eval_gettext 'Warning : vcrun2005 seems to be already installed.\nForcing reinstallation.')" "$TITLE"
        fi

        cd "$POL_USER_ROOT/ressources/vcrun2005"

        # Installing vcrun2005 sp1
        if [ "$POL_ARCH" = "amd64" ]; then
                rm "$WINEPREFIX/drive_c/windows/syswow64/msvcp80.dll"
                rm "$WINEPREFIX/drive_c/windows/system32/msvcp80.dll"
                POL_Wine start /unix "vcredist_x64.exe" /q
                POL_Wine_WaitExit "vcrun2005 sp1 x64"
                POL_Wine start /unix "vcredist_x86.exe" /q
                POL_Wine_WaitExit "vcrun2005 sp1 x86"
        else
                rm "$WINEPREFIX/drive_c/windows/system32/msvcp80.dll"
                POL_Wine start /unix "vcredist_x86.exe" /q
                POL_Wine_WaitExit "vcrun2005 sp1 x86"
        fi

        # Overriding dll
        POL_Wine_OverrideDLL "native,builtin" "msvcr80"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYLqmMQAKCRDlMfrJqhPK
R5mTAJ9kqXF0xJV6VCGWrRw4fPCHV2hkvQCaA4rAD/kNysqRFWDH96OkwquAFfs=
=0u19
-----END PGP SIGNATURE-----
