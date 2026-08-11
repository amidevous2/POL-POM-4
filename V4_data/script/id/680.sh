#!/bin/bash
# Changelog

# CHANGELOG
# [Quentin PARIS] (2012-04-24) Fixed bug 815
#   petch: fixed after ie6setup.exe disappearance
# [Dadu042] (2020-04-06)
#   Wine 4.0-rc3 (outdated) -> 4.0.3
#   Add POL_RequiredVersion

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Internet Explorer 6"
PREFIX="InternetExplorer6"
WORKING_WINE_VERSION="4.0.3"

POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/ie6/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
export WINEARCH=win32 
POL_SetupWindow_presentation "$TITLE" "Microsoft corporation" "http://www.microsoft.com/" "Tinou" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

wget -q "$SITE/divers/ie_license.txt"
POL_SetupWindow_licence "Please read this carefully" "$TITLE" "$POL_System_TmpDir/ie_license.txt"

POL_Download_Resource "http://files.playonlinux.com/ie/6.0/ie60.exe" "f34f7f96e8307a01d51c9cc82abe90c2"
#POL_Download_Resource "http://www.oldapps.com/internet_explorer.php?app=f34f7f96e8307a01d51c9cc82abe90c2" "8e483db28ff01a7cabd39147ab6c59753ea1f533"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

cd "$POL_System_TmpDir"
POL_Wine "$POL_USER_ROOT/ressources/ie60.exe"

POL_Wine_InstallFonts
POL_Call POL_Function_FontsSmoothRGB
POL_Call POL_Install_msls31
POL_Call POL_Install_LunaTheme

if [ ! -f "$WINEPREFIX/drive_c/windows/system32/plugin.ocx" ]
then
    POL_Wine iexplore -unregserver
fi

POL_Wine_OverrideDLL native,builtin inetcpl.cpl itircl itss jscript mlang mshtml msimtf shdoclc shdocvw shlwapi urlmon

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Internet Explorer/"
[ -f "iexplore.exe" ] && mv iexplore.exe iexplore.bak
  
cd "$WINEPREFIX/drive_c/windows/system32"
for dll in itircl itss jscript mlang mshtml msimtf shdoclc shdocvw shlwapi urlmon
do
    [ -f "$dll.dll" ] && rm "$dll.dll"
done

Set_OS win2k

rm -f "$WINEPREFIX/drive_c/windows/system32/browseui.dll"
rm -f "$WINEPREFIX/drive_c/windows/system32/inseng.dll"
rm -f "$WINEPREFIX/drive_c/windows/system32/inetcpl.cpl"

cd "$WINEPREFIX/drive_c/windows/system32/"

cabextract -F "inseng.dll" "$POL_System_TmpDir/IE 6.0 Full/ACTSETUP.CAB"

POL_Wine_OverrideDLL native inseng

cd "$POL_System_TmpDir/IE 6.0 Full"
POL_Wine_WaitBefore "$TITLE"
POL_System_wget "$SITE/divers/ie6reg.reg"
POL_Wine regedit ie6reg.reg
POL_Wine --ignore-errors IE6SETUP.EXE
POL_Wine_WaitExit "$TITLE"
 
POL_SetupWindow_pulsebar "$(eval_gettext "Registering libraries, please wait\n(It can take a while)")" "$TITLE"
cd "$WINEPREFIX/drive_c/windows/system32"
PULSE=0
for file in actxprxy.dll browseui.dll browsewm.dll cdfview.dll ddraw.dll \
      dispex.dll dsound.dll iedkcs32.dll iepeers.dll iesetup.dll imgutil.dll \
      inetcomm.dll inetcpl.cpl inseng.dll isetup.dll jscript.dll laprxy.dll \
      mlang.dll mshtml.dll mshtmled.dll msi.dll msident.dll \
      msoeacct.dll msrating.dll mstime.dll msxml3.dll occache.dll \
      ole32.dll oleaut32.dll olepro32.dll pngfilt.dll quartz.dll \
      rpcrt4.dll rsabase.dll rsaenh.dll scrobj.dll scrrun.dll \
      shdocvw.dll shell32.dll urlmon.dll vbscript.dll webcheck.dll \
      wshcon.dll wshext.dll asctrls.ocx hhctrl.ocx mscomct2.ocx \
      plugin.ocx proctexe.ocx tdc.ocx webcheck.dll wshom.ocx
do
    sleep 0.1
    POL_SetupWindow_set_text "$file"
    POL_Wine --ignore-errors regsvr32 /i "$file"
    [ $PULSE = 100 ] || PULSE=$(( PULSE + 2 ))
    sleep 0.1
    POL_SetupWindow_pulse "$PULSE"
    echo POL_SetupWindow_pulse "$PULSE"
done

POL_Call POL_Install_pngfilt

rm "$WINEPREFIX/drive_c/windows/system32/iexplore.exe"

POL_Shortcut "iexplore.exe" "$TITLE"
POL_System_TmpDelete

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXukezQAKCRDlMfrJqhPK
RyVMAKCDvM6L3vUR7AlzJyMv1ZO5Q+IdOgCgrP/03RL8uvYPa2W1z/r2G5wFklY=
=2wv8
-----END PGP SIGNATURE-----
