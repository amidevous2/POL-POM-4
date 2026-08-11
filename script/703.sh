#!/bin/bash
# PlayOnLinux Function
# RealName: Internet Explorer 6
# Date : (2010-09-21 04-48)
# Last revision : (2012-04-12 10-08)
# Author : Unkuiri

# CHANGELOG
# [SuperPlumus] (2012-04-11 18-47)
#   Add --ignore-errors for regsvr32
#   Add remove system32/inetcpl.cpl
#   Add POL_Wine iexplore -unregserver
#   Add native inseng.dll

if [ "$POL_ARCH" = "amd64" ]
then
    POL_Debug_Error "AMD64 is set, but IE6 is needed."
else
    IE6TMP="$POL_USER_ROOT/tmp/PI_ie6"
    mkdir -p "$IE6TMP"

    cd "$IE6TMP"
    wget -q "$SITE/divers/ie_license.txt"
    POL_SetupWindow_licence "Please read this carefully" "$TITLE" "$IE6TMP/ie_license.txt"

    POL_Download_Resource "http://files.playonlinux.com/ie/6.0/ie60.exe" "f34f7f96e8307a01d51c9cc82abe90c2"

    #POL_Download_Resource "http://www.oldapps.com/internet_explorer.php?app=f34f7f96e8307a01d51c9cc82abe90c2" "8e483db28ff01a7cabd39147ab6c59753ea1f533"

    cd "$IE6TMP"
    POL_Wine "$POL_USER_ROOT/ressources/ie60.exe"

    POL_Wine_InstallFonts
    POL_Call POL_Function_FontsSmoothRGB
    POL_Call POL_Install_msls31

    if [ ! -f "$WINEPREFIX/drive_c/windows/system32/plugin.ocx" ]
    then
	POL_Wine iexplore -unregserver
    fi

    POL_Wine_OverrideDLL native,builtin iexplore.exe inetcpl.cpl itircl itss jscript mlang mshtml msimtf shdoclc shdocvw shlwapi urlmon

    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Internet Explorer/"
    [ -f "iexplore.exe" ] && mv iexplore.exe iexplore.bak

    cd "$WINEPREFIX/drive_c/windows/system32"
    for dll in itircl itss jscript mlang mshtml msimtf shdoclc shdocvw shlwapi urlmon
    do
	[ -f "$dll.dll" ] && mv "$dll.dll" "$dll.bak"
    done

    Set_OS win2k

    rm -f "$WINEPREFIX/drive_c/windows/system32/browseui.dll"
    rm -f "$WINEPREFIX/drive_c/windows/system32/inseng.dll"
    rm -f "$WINEPREFIX/drive_c/windows/system32/inetcpl.cpl"

    cd "$WINEPREFIX/drive_c/windows/system32/"

    cabextract -F "inseng.dll" "$IE6TMP/IE 6.0 Full/ACTSETUP.CAB"

    POL_Wine_OverrideDLL native inseng

    cd "$IE6TMP/IE 6.0 Full"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine --ignore-errors IE6SETUP.EXE # /q:a /r:n /c:"ie6wzd /S:""#e"" /q:a /r:n"
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
	POL_SetupWindow_pulse "$PULSE"
    done

    POL_Call POL_Install_pngfilt

    rm "$WINEPREFIX/drive_c/windows/system32/iexplore.exe"

    rm -rf "$IE6TMP"
fi

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlXSS+kACgkQ5TH6yaoTykeLGACfakgPKugcyKcnj6ZBryR1g7n/
RIUAnjSYGlf6+fQDAh5KYolcAQJVDpLf
=u8el
-----END PGP SIGNATURE-----
