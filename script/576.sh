#!/bin/bash
# Date : 
# Last revision : 
# Wine version used : 1.1.35
# Distribution used to test : Ubuntu Karmic
# Author : Lennart Hansen - lahansen@gmail.com
# Depend : IE6

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Application Specific Vars 
TITLE="Paddy Power Poker"
APPDIR="PaddyPowerPoker"
APPINSTALLDIR="Poker/Paddy Power  Poker/"
APPEXEC="casino.exe"
APPLINK="http://banner.paddypowerpoker.com/cgi-bin/SetupPoker.exe"
LOGOLINK="http://www.playonlineslots.co.uk/wp-content/uploads/2009/11/paddy-power-casino.gif"
ICONLINK="http://img.informer.com/icons/png/48/37/37916.png"
REMOVELIST="$HOME/Desktop/Paddy\ Power\ \ Poker.desktop"
WINE="1.1.35"

# Install specific vars
DOWNLOADINGINSTALLING="PlayOnLinux is installing"
INSTALLED="has been installed successfully"
PREFIX="$HOME/.PlayOnLinux/wineprefix/$APPDIR/"
WINDIR="$PREFIX/drive_c/windows/"
TMPDIR="$PREFIX/drive_c/tmp/"
TMPDIR_WIN='c:\tmp'
ICONDIR="$HOME/.PlayOnLinux/icones"

# Functions - Ported from winetricks but modified to work "natively" with PlayOnLinux
install_msls31() {
	# Install native Microsoft Line Services (needed by e-Sword, possibly only when using native riched20)
	cd "$TMPDIR"
	POL_SetupWindow_download "Downloading Microsoft Line Services" "$TITLE" "http://download.microsoft.com/download/WindowsInstaller/Install/2.0/W9XMe/EN-US/InstMsiA.exe"
	cabextract --directory="$TMPDIR" InstMsiA.exe
    	cp -f "$TMPDIR"/msls31.dll "$WINDIR"/system32
}

install_ie6() {
    install_msls31

    WINEDLLOVERRIDES=mshtml=

    # Unregister Wine IE
    wine iexplore -unregserver

    # Change the override to the native so we are sure we use and register them
    override_dlls native,builtin iexplore.exe itircl itss jscript mlang mshtml msimtf shdoclc shdocvw shlwapi urlmon

    # Remove the fake dlls, if any
    mv "$PROGRAMFILESDIR_UNIX"/"Internet Explorer"/iexplore.exe "$PROGRAMFILESDIR_UNIX"/"Internet Explorer"/iexplore.exe.bak
    for dll in itircl itss jscript mlang mshtml msimtf shdoclc shdocvw shlwapi urlmon
    do
        test -f "$WINDIR"/system32/$dll.dll &&
          mv "$WINDIR"/system32/$dll.dll "$WINDIR"/system32/$dll.dll.bak
    done

    # The installer doesn't want to install iexplore.exe in XP mode.
    Set_OS "win2k"

    # Workaround a IE6 Installer bug, not Wine's fault
    # See http://bugs.winehq.org/show_bug.cgi?id=5409
    # Actual value downloaded doesn't matter
    rm -f "$TMPDIR"/ie6sites.dat
    cd $TMPDIR
    POL_SetupWindow_download "Downloading required ie6sites.dat" "$TITLE" "http://www.microsoft.com/windows/ie/ie6sp1/download/rtw/x86/ie6sites.dat"

    # Install
    POL_SetupWindow_download "Downloading required IE6 Setup" "$TITLE" "http://download.microsoft.com/download/ie6sp1/finrel/6_sp1/W98NT42KMeXP/EN-US/ie6setup.exe"
    
    # Workaround http://bugs.winehq.org/show_bug.cgi?id=21009
    # See also http://code.google.com/p/winezeug/issues/detail?id=78
    rm -f "$WINDIR"/system32/browseui.dll "$WINDIR"/system32/inseng.dll

    POL_SetupWindow_wait_next_signal "$DOWNLOADINGINSTALLING Internet Explorer 6" "$TITLE"

    # Silent install recipe from:
    # http://www.axonpro.sk/japo/info/MS/SILENT%20INSTALL/Unattended-Silent%20Installation%20Switches%20for%20Windows%20Apps.htm
    wine "$TMPDIR"/ie6setup.exe /q:a /r:n /c:"ie6wzd /S:""#e"" /q:a /r:n"

    POL_SetupWindow_detect_exit

    # Work around DLL registration bug until ierunonce/RunOnce/wineboot is fixed
    # FIXME: whittle down this list
    cd "$WINDIR"/system32/
    for i in actxprxy.dll browseui.dll browsewm.dll cdfview.dll ddraw.dll \
      dispex.dll dsound.dll iedkcs32.dll iepeers.dll iesetup.dll \
      imgutil.dll inetcomm.dll inseng.dll isetup.dll jscript.dll laprxy.dll \
      mlang.dll mshtml.dll mshtmled.dll msi.dll msident.dll \
      msoeacct.dll msrating.dll mstime.dll msxml3.dll occache.dll \
      ole32.dll oleaut32.dll olepro32.dll pngfilt.dll quartz.dll \
      rpcrt4.dll rsabase.dll rsaenh.dll scrobj.dll scrrun.dll \
      shdocvw.dll shell32.dll urlmon.dll vbscript.dll webcheck.dll \
      wshcon.dll wshext.dll asctrls.ocx hhctrl.ocx mscomct2.ocx \
      plugin.ocx proctexe.ocx tdc.ocx webcheck.dll wshom.ocx
    do
        wine regsvr32 /i $i > /dev/null 2>&1
    done
}

override_dlls() {
    mode=$1
    shift
    echo Using $mode override for following DLLs: $@
    cat > "$TMPDIR"/override-dll.reg <<_EOF_
REGEDIT4

[HKEY_CURRENT_USER\Software\Wine\DllOverrides]
_EOF_
    while test "$1" != ""
    do
        echo "\"$1\"=\"$mode\"" >> "$TMPDIR"/override-dll.reg
        shift
    done

    wine regedit "$TMPDIR_WIN"\\override-dll.reg
    rm "$TMPDIR"/override-dll.reg
}


# Installation 

cd "/tmp/"
LOGOFILE=$(basename $LOGOLINK)
wget "$LOGOLINK" -O "$LOGOFILE"

POL_SetupWindow_Init "" "$LOGOFILE"
INSTALLTXT=$(eval_gettext "This wizard will help you to install $TITLE in a playonlinux prefix")
POL_SetupWindow_free_presentation "$TITLE" "$INSTALLTXT"

select_prefix "$PREFIX"

if [ ! -e "$PREFIX" ]; then
	POL_SetupWindow_prefixcreate
fi

fonts_to_prefix

PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

PROGRAMFILESDIR_UNIX="$PREFIX/drive_c/$PROGRAMFILES"

POL_SetupWindow_install_wine "$WINE"
Use_WineVersion "$WINE"
sleep 2

# Install Dependencies

mkdir -p "$TMPDIR"

install_ie6

# Install App

POL_SetupWindow_detect_exit

POL_SetupWindow_download "Downloading $TITLE" "$TITLE" "$APPLINK"

POL_SetupWindow_wait_next_signal "$DOWNLOADINGINSTALLING $TITLE" "$TITLE"

APPINSTALLEXEC=$(basename $APPLINK)

wine "$APPINSTALLEXEC"

POL_SetupWindow_detect_exit

ICONFILE=$(basename $ICONLINK)
wget "$ICONLINK" -O "$ICONDIR/$ICONFILE"

POL_SetupWindow_reboot

POL_SetupWindow_message "$TITLE $INSTALLED, Enjoy!" "$TITLE"

POL_SetupWindow_make_shortcut "$APPDIR" "$APPINSTALLDIR" "$APPEXEC" "$ICONFILE" "$TITLE"

POL_SetupWindow_Close

clean_tmp 

echo -e $REMOVELIST | while read I
do
	rm -rf "$I"
done

exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFkACgkQ5TH6yaoTykdMDQCgl77Oh4PnChVI/9DquwE8kB0H
yuAAnRvGzc31CY6zitDUll4MAbhbIigW
=dXTz
-----END PGP SIGNATURE-----
