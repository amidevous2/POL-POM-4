#!/bin/bash
 
# Author : Tinou
# Licence : Microsoft
# Depend : none

# CHANGELOG
# [Tinou ?] (2014 ?)
#   First script.
# [Dadu042] (2020-04-06)
#   Wine 4.0.0 -> 4.0.3 (more common and stable)
#   Update POL_Shortcut

# KNOWN ISSUES:
# - Wine 3.20 x86: Browser is detected as 'IE8' by whatismybrowser.org
# - Wine 4.0.3 x86: Browser is detected as 'IE8' by whatismybrowser.org
# - Wine 5.0.0 x86: Browser is detected as 'IE9' by whatismybrowser.org


# Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
  
# Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
TITLE="Internet Explorer 8"
Prefix="InternetExplorer8"
 
POL_GetSetupImages "$SITE/setups/ie7/top.jpg" "$SITE/setups/ie7/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"
POL_Debug_Init
 
#Presentation
POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.microsoft.com/" "Tinou" "$Prefix"
 
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$Prefix"
POL_Wine_PrefixCreate "4.0.3"
POL_SetupWindow_improve_fonts
 
POL_Call POL_Install_LunaTheme
 
  
POL_Download_Resource "http://download.microsoft.com/download/C/C/0/CC0BD555-33DD-411E-936B-73AC6F95AE11/IE8-WindowsXP-x86-ENU.exe" "616c2e8b12aaa349cd3acb38bf581700"
 
cat << EOF > OGL.reg
[HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\Main]
"TabProcGrowth"=dword:00000000
 
[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]
"browseui"="native,builtin"
"crypt32"="native,builtin"
"hhctrl.ocx"="native,builtin"
"hlink"="native,builtin"
"iernonce"="native,builtin"
"iexplore.exe"="native,builtin"
"itircl"="native,builtin"
"itss"="native,builtin"
"jscript"="native,builtin"
"mlang"="native,builtin"
"mshtml"="native,builtin"
"msimtf"="native,builtin"
"secur32"="native,builtin"
"shdoclc"="native,builtin"
"shdocvw"="native,builtin"
"shlwapi"="native,builtin"
"url"="native,builtin"
"urlmon"="native,builtin"
"usp10"="native,builtin"
"uxtheme"="native,builtin"
"wininet"="builtin"
"wintrust"="native,builtin"
"xmllite"="native,builtin"
EOF
POL_Wine regedit OGL.reg
 
 
POL_Download_Resource "$SITE/divers/ie7-dlls.tar.bz2" "b71a3213452c9a3a1aa08767d52e7577"
 
tar -xvf ie7-dlls.tar.bz2
mv "msctf.dll" "$WINEPREFIX/drive_c/windows/system32"
mv "msimtf.dll" "$WINEPREFIX/drive_c/windows/system32"
mv "uxtheme.dll" "$WINEPREFIX/drive_c/windows/system32"
 
POL_Wine_InstallFonts
POL_Call POL_Function_FontsSmoothRGB
 
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msls31
POL_Call POL_Install_msxml3
POL_Call POL_Install_riched20
POL_Call POL_Install_DisableCrashDialog
 
Set_OS win7
 
cd "$REPERTOIRE/ressources"
POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "IE8-WindowsXP-x86-ENU.exe"
 
POL_Shortcut "$PROGRAMFILES/Internet Explorer/iexplore.exe" "$TITLE" "" "" "Network;"

# IE8 crashes on exit, bug #847
POL_Shortcut_QuietDebug "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXot6AwAKCRDlMfrJqhPK
R9T3AJ9pudB0EZw+EYaOm9BKsvp1cVTWyQCfYFZ2f54bT6HjE5uDHZtVAliMHmQ=
=+AYx
-----END PGP SIGNATURE-----
