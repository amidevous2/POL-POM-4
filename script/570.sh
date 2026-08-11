#!/bin/bash
# PlayOnLinux Function
# Date : (2010-08-02 21-00)
# Last revision : (2021-06-02 13-27)
# Author : Berillions
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com
 
# [petch] (2013-01-22 16:47)
#   Fixing bug #1787
# [Yaotl] (2019-10-17 15:39)
#   Update URLs.
#   Remove FR case.
# [Yaotl] (2021-06-02 13:27)
#   Update URLs & Hash values.

FORCE_MODE=$1

# Installing x64 version
if [ "$POL_ARCH" = "amd64" ]; then
        # Downloading vcrun2008 sp1 x64 EN
        POL_Download_Resource "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe" "472c10efa75a30deb2a15ec8b777227b" "vcrun2008"
fi

# Downloading vcrun2008 sp1 x86 EN
POL_Download_Resource "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe" "a92a4d8e784d8f859217f828fe879047" "vcrun2008"

# Check if vcrun2008 is already installed
CHECK_VC2K8=`find $WINEPREFIX -name "msdia90.dll"`
if [ "$CHECK_VC2K8" = "" -o "$FORCE_MODE" == "--force" ]; then
        if [ "$CHECK_VC2K8" != "" ]; then
                POL_SetupWindow_message "$(eval_gettext 'Warning : vcrun2008 seems to be already installed.\nForcing reinstallation.')" "$TITLE"
        fi

        # Fix before install for wine 1.3.37 and older
        POL_AdvisedVersion  4.0.16 || POL_Debug_Error "$(eval_gettext 'VCRun2008 might fail to install because your PlayOnLinux version is too old. Please update.')"
        if VersionLower $(POL_Config_PrefixRead VERSION) 1.3.37; then
                POL_Call POL_Install_msxml3
                ln -s "$WINEPREFIX/drive_c" "$WINEPREFIX/harddiskvolume0"
                rm -f "$WINEPREFIX/dosdevices/c:"
                ln -s "$WINEPREFIX/harddiskvolume0" "$WINEPREFIX/dosdevices/c:"
        fi

        cd "$POL_USER_ROOT/ressources/vcrun2008"

        # Installing vcrun2008 sp1
        if [ "$POL_ARCH" = "amd64" ]; then
                rm "$WINEPREFIX/drive_c/windows/syswow64/msvcp90.dll"
                rm "$WINEPREFIX/drive_c/windows/system32/msvcp90.dll"
                POL_Wine start /unix "vcredist_x64.exe" /q
                POL_Wine_WaitExit "vcrun2008 sp1 x64"
                POL_Wine start /unix "vcredist_x86.exe" /q
                POL_Wine_WaitExit "vcrun2008 sp1 x86"
        else
                rm "$WINEPREFIX/drive_c/windows/system32/msvcp90.dll"
                POL_Wine start /unix "vcredist_x86.exe" /q
                POL_Wine_WaitExit "vcrun2008 sp1 x86"
        fi

        # Overriding dll
        POL_Wine_OverrideDLL "native,builtin" "msvcr90"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYLqmKwAKCRDlMfrJqhPK
RxFlAJ9qsDC/pePjS6t84J4F7FTuTgWEvwCfRH04kuBTB4ztuwTGC18kg16dK+A=
=qqoe
-----END PGP SIGNATURE-----
