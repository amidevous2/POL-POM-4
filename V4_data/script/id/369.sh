#!/bin/bash
# Date : (2009-07-07 19-30)
# Last revision : X
# Wine version used : 
 
# CHANGELOG
# [?] (2009-07-07 19-30)
#   First script.
# [SuperPlumus] (2012-04-12 14-57)
#   Re-writting
# [Dadu042] (2020-04-06)
#   Wine 1.4 -> 4.0.3
#   Improve POL_Shortcut

# KNOWN ISSUES:
# - Wine 4.0.3 x86: Browser is detected as 'IE8' by whatismybrowser.org
# - Wine 5.0.0 x86: Browser is detected as 'IE9' by whatismybrowser.org


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Internet Explorer 7"
PREFIX="InternetExplorer7"
WORKING_WINE_VERSION="4.0.3"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ie7/top.jpg" "http://files.playonlinux.com/resources/setups/ie7/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"
POL_Debug_Init
 
POL_SetupWindow_presentation "Internet Explorer 7" "Microsoft" "http://www.microsoft.com" "Tinou and Superplumus" "$PREFIX"
   
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "vista"
 
POL_System_TmpCreate "$PREFIX"
 
POL_Wine_InstallFonts
POL_Call POL_Function_FontsSmoothRGB
# Disabled, see http://www.playonlinux.com/en/issue-1447.html
# POL_Call POL_Install_LunaTheme
POL_Call POL_Function_sandbox
 
if grep -q -i "wine placeholder" "$WINEPREFIX/drive_c/$PROGRAMFILES/Internet Explorer/iexplore.exe"
then
    POL_Wine iexplore -unregserver
fi
 
POL_Wine_OverrideDLL native,builtin iexplore.exe itircl itss jscript mshtml msimtf shdoclc shdocvw shlwapi urlmon xmllite
POL_Wine_OverrideDLL builtin updspapi
 
cd "$WINEPREFIX/drive_c/windows/system32"
for dll in itircl itss jscript mshtml msimtf shdoclc shdocvw shlwapi urlmon
do
    [ -f "$dll.dll" ] && mv "$dll.dll" "$dll.bak"
done
 
cd "$POL_System_TmpDir"
POL_Download "$SITE/divers/ie7-dlls.tar.bz2" "b71a3213452c9a3a1aa08767d52e7577"
tar -xvjf "ie7-dlls.tar.bz2" -C "$WINEPREFIX/drive_c/windows/system32/"
 
if [ -z "$POL_SELECTED_FILE" ]
then
 
POL_SetupWindow_menu "$(eval_gettext 'Which language version would you like to install?')" "$TITLE" "Arabic~Chinese (Simplified)~Chinese (Traditional, Taiwan)~Czech~Danish~Dutch~English~Finnish~French~German~Greek~Hebrew~Hungarian~Italian~Japanese~Korean~Norwegian~Polish~Portuguese (Brazil)~Portuguese (Portugal)~Russian~Spanish~Swedish~Turkish" "~"
 
if [ "$APP_ANSWER" = "English" ]; then
IE7_LINK="http://download.microsoft.com/download/3/8/8/38889dc1-848c-4bf2-8335-86c573ad86d9/IE7-WindowsXP-x86-enu.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-enu.exe"
IE7_MD5="ea16789f6fc1d2523f704e8f9afbe906"
elif [ "$APP_ANSWER" = "French" ]; then
IE7_LINK="http://download.microsoft.com/download/d/7/6/d7635233-5433-45aa-981b-4690ae90b785/IE7-WindowsXP-x86-fra.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-fra.exe"
IE7_MD5="77c9bdd28f220f2c31fc23d73125eef7"
elif [ "$APP_ANSWER" = "German" ]; then
IE7_LINK="http://download.microsoft.com/download/6/b/c/6bcfcbcd-d634-44f9-8231-c4b05323770a/IE7-WindowsXP-x86-deu.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-deu.exe"
IE7_MD5="b704d4f7956af137294e72c30799cabe"
elif [ "$APP_ANSWER" = "Arabic" ]; then
IE7_LINK="http://download.microsoft.com/download/f/5/e/f5ec8dec-a76d-4866-88a3-8bd6be368c8d/IE7-WindowsXP-x86-ara.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-ara.exe"
IE7_MD5="d6788008595b2e241b0616b4d84652b1"
elif [ "$APP_ANSWER" = "Chinese (Simplified)" ]; then
IE7_LINK="http://download.microsoft.com/download/4/1/8/418981a4-6ef9-4de6-befc-1a53e886cb62/IE7-WindowsXP-x86-chs.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-chs.exe"
IE7_MD5="9bbf568537e6ff060954bc710b5e648e"
elif [ "$APP_ANSWER" = "Chinese (Traditional, Taiwan)" ]; then
IE7_LINK="http://download.microsoft.com/download/4/a/5/4a5a86de-af85-432e-979c-fa69e5d781db/IE7-WindowsXP-x86-cht.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-cht.exe"
IE7_MD5="193bf89a4556eca1ac244bedbe7ab5aa"
elif [ "$APP_ANSWER" = "Czech" ]; then
IE7_LINK="http://download.microsoft.com/download/6/c/9/6c933e30-c659-438e-9bc0-6e050e329d14/IE7-WindowsXP-x86-csy.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-csy.exe"
IE7_MD5="88859df39f3048a742756eb629483c02"
elif [ "$APP_ANSWER" = "Danish" ]; then
IE7_LINK="http://download.microsoft.com/download/9/f/b/9fbfc1cb-47ea-4364-9829-830e5c5b8b09/IE7-WindowsXP-x86-dan.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-dan.exe"
IE7_MD5="1d752313b9bcfc088392a204bd00a130"
elif [ "$APP_ANSWER" = "Dutch" ]; then
IE7_LINK="http://download.microsoft.com/download/4/3/3/433d9e80-2b31-4bf3-844f-c11eece20da5/IE7-WindowsXP-x86-nld.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-nld.exe"
IE7_MD5="752244327d5fb2bb9d3f4636a3ce10c7"
elif [ "$APP_ANSWER" = "Finnish" ]; then
IE7_LINK="http://download.microsoft.com/download/3/9/6/396ee8cb-0f76-47ab-86b1-3c2ad0752bc3/IE7-WindowsXP-x86-fin.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-fin.exe"
IE7_MD5="bc67ebaf7bf69763bcc7a6109360527d"
elif [ "$APP_ANSWER" = "Greek" ]; then
IE7_LINK="http://download.microsoft.com/download/f/3/f/f3fc00ed-8b5d-4e36-81f0-fe0d722993e2/IE7-WindowsXP-x86-ell.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-ell.exe"
IE7_MD5="9974e80af2c470581cb3c58332cd9f0a"
elif [ "$APP_ANSWER" = "Hebrew" ]; then
IE7_LINK="http://download.microsoft.com/download/5/8/7/587bbf05-6132-4a49-a81d-765082ce8246/IE7-WindowsXP-x86-heb.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-heb.exe"
IE7_MD5="19eb048477c1cb70e0b68405d2569d22"
elif [ "$APP_ANSWER" = "Hungarian" ]; then
IE7_LINK="http://download.microsoft.com/download/7/2/c/72c09e25-5635-43f9-9f62-56a8f87c58a5/IE7-WindowsXP-x86-hun.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-hun.exe"
IE7_MD5="ae8e824392642166d52d33a5dab55c5d"
elif [ "$APP_ANSWER" = "Italian" ]; then
IE7_LINK="http://download.microsoft.com/download/3/9/0/3907f96d-1bbd-499a-b6bd-5d69789ddb54/IE7-WindowsXP-x86-ita.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-ita.exe"
IE7_MD5="510a2083dfb4e42209d845968861a2df"
elif [ "$APP_ANSWER" = "Japanese" ]; then
IE7_LINK="http://download.microsoft.com/download/d/4/8/d488b16c-877d-474d-912f-bb88e358055d/IE7-WindowsXP-x86-jpn.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-jpn.exe"
IE7_MD5="13934f80870d549493197b5cb0995112"
elif [ "$APP_ANSWER" = "Korean" ]; then
IE7_LINK="http://download.microsoft.com/download/1/0/a/10ad8b7f-2354-420d-aae3-ddcff81554fb/IE7-WindowsXP-x86-kor.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-kor.exe"
IE7_MD5="3cc8e93f191f726e5ec9b23349a261c0"
elif [ "$APP_ANSWER" = "Norwegian" ]; then
IE7_LINK="http://download.microsoft.com/download/a/a/3/aa317f65-e818-458c-a36f-9f0feb017744/IE7-WindowsXP-x86-nor.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-nor.exe"
IE7_MD5="7450388c1dd004f63b39ade2868da9bd"
elif [ "$APP_ANSWER" = "Polish" ]; then
IE7_LINK="http://download.microsoft.com/download/6/a/0/6a01b4fa-66e5-4447-8f36-9330a8725ecd/IE7-WindowsXP-x86-plk.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-plk.exe"
IE7_MD5="09677cc0df807cd9fb0a834eeecbfec9"
elif [ "$APP_ANSWER" = "Portuguese (Brazil)" ]; then
IE7_LINK="http://download.microsoft.com/download/e/9/8/e98bd8ac-3122-4079-bb70-d19b5d5ef875/IE7-WindowsXP-x86-ptb.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-ptb.exe"
IE7_MD5="ec5098a90641f4c3c248582ed8d7cf8c"
elif [ "$APP_ANSWER" = "Portuguese (Portugal)" ]; then
IE7_LINK="http://download.microsoft.com/download/9/9/0/99012553-0eea-402d-99e9-bdc2f4ee26a9/IE7-WindowsXP-x86-ptg.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-ptg.exe"
IE7_MD5="5882c9721261d564220e4f776a811197"
elif [ "$APP_ANSWER" = "Russian" ]; then
IE7_LINK="http://download.microsoft.com/download/d/4/e/d4e2d315-2493-44a4-8135-b5310b4a50a4/IE7-WindowsXP-x86-rus.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-rus.exe"
IE7_MD5="db8d6f76a16a690458c65b831bfe14a4"
elif [ "$APP_ANSWER" = "Spanish" ]; then
IE7_LINK="http://download.microsoft.com/download/4/c/4/4c4fc47b-974c-4dc9-b189-2820f68b4535/IE7-WindowsXP-x86-esn.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-esn.exe"
IE7_MD5="0b90933978f8f39589b4bd6e457d8899"
elif [ "$APP_ANSWER" = "Swedish" ]; then
IE7_LINK="http://download.microsoft.com/download/1/2/3/12311242-faa8-4edf-a0c4-86bf4e029a54/IE7-WindowsXP-x86-sve.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-sve.exe"
IE7_MD5="7a569708bd72ab99289064008609bfa8"
elif [ "$APP_ANSWER" = "Turkish" ]; then
IE7_LINK="http://download.microsoft.com/download/4/e/7/4e77d531-5c33-4f9b-a5c9-ea29fb79cc56/IE7-WindowsXP-x86-trk.exe"
IE7_INSTALLER="IE7-WindowsXP-x86-trk.exe"
IE7_MD5="71a39c77bcfd1e2299e99cb7433e5856"
fi
 
POL_Download "$IE7_LINK" "$IE7_MD5"
 
else
IE7_INSTALLER="$POL_SELECTED_FILE"
fi
 
POL_Wine_WaitBefore "$TITLE"
WINEDEBUG="warn+heap" POL_Wine --ignore-errors "$IE7_INSTALLER"
POL_Wine_WaitExit "$TITLE"
 
 
POL_SetupWindow_pulsebar "$(eval_gettext "Registering libraries, please wait\n(It can take a while)")" "$TITLE"
cd "$WINEPREFIX/drive_c/windows/system32"
for file in actxprxy.dll browseui.dll browsewm.dll cdfview.dll ddraw.dll dispex.dll dsound.dll iedkcs32.dll iepeers.dll iesetup.dll imgutil.dll inetcomm.dll inseng.dll isetup.dll jscript.dll laprxy.dll mlang.dll mshtml.dll mshtmled.dll msi.dll msident.dll msoeacct.dll msrating.dll mstime.dll msxml3.dll occache.dll ole32.dll oleaut32.dll olepro32.dll pngfilt.dll quartz.dll rpcrt4.dll rsabase.dll rsaenh.dll scrobj.dll scrrun.dll shdocvw.dll shell32.dll urlmon.dll vbscript.dll webcheck.dll wshcon.dll wshext.dll asctrls.ocx hhctrl.ocx mscomct2.ocx plugin.ocx proctexe.ocx tdc.ocx webcheck.dll wshom.ocx
do
    sleep 0.1
    POL_SetupWindow_set_text "$file"
    POL_Wine --ignore-errors regsvr32 /i "$file"
    [ "$PULSE" = 100 ] || PULSE=$(( PULSE + 2 ))
    POL_SetupWindow_pulse "$PULSE"
done
POL_Call POL_Install_msxml3
 
 
POL_System_TmpDelete
   
POL_Shortcut "$PROGRAMFILES/Internet Explorer/iexplore.exe" "$TITLE" "" "" "Network;"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXot2wgAKCRDlMfrJqhPK
R/FmAJ9j1hSPeoKVpDFJ5OeshnrJzRm/MwCfeqaI/xbx9VeJuFNWuGYXKPqYc/g=
=V/v/
-----END PGP SIGNATURE-----
