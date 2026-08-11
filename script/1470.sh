#!/bin/bash
# PlayOnLinux Function
# RealName: Internet Explorer 8
# Date : (2012-11-19 14-52)
# Author : Percherie
# RealName: Internet Explorer 8
# CHANGELOG
#
# Luc BOURNAUD (2017-05-06)
#  - Add the "--autolang"
if [ "$POL_ARCH" = "amd64" ]
then
   POL_Debug_Error "AMD64 is set, but IE8 is needed."
else
  
# Création du répertoire temporaire
mkdir -p "$POL_USER_ROOT/tmp/ie8"
cd "$POL_USER_ROOT/tmp/ie8"
  
case "$1" in
	"--lang" )
		APP_ANSWER="$2"
    shift 2;;
   "--autolang" )
     APP_ANSWER="English"
     case "${LANG:0:2}" in
     	 "ar" ) APP_ANSWER="Arabic";;
     	 "zh" | "ch" ) APP_ANSWER="Chinese (Simplified)";;
     	 # ??? ) APP_ANSWER="Chinese (Traditional, Taiwan)";;
     	 "cs" ) APP_ANSWER="Czech";;
     	 "da" ) APP_ANSWER="Danish";;
     	 "nl" ) APP_ANSWER="Dutch";;
     	 "fi" ) APP_ANSWER="Finnish";;
     	 "fr" ) APP_ANSWER="French";;
     	 "de" ) APP_ANSWER="German";;
     	 "el" ) APP_ANSWER="Greek";;
     	 "he" ) APP_ANSWER="Hebrew";;
     	 "hu" ) APP_ANSWER="Hungarian";;
     	 "it" ) APP_ANSWER="Italian";;
     	 "ja" ) APP_ANSWER="Japanese";;
     	 "ko" ) APP_ANSWER="Korean";;
     	 "nb" | "nn" | "no" ) APP_ANSWER="Norwegian";;
     	 "pl" ) APP_ANSWER="Polish";;
     	 "pt" ) 
     	   case "${LANG:3:2}" in
     	   "BR" ) APP_ANSWER="Portuguese (Brazil)";;
     	   * ) APP_ANSWER="Portuguese (Portugal)";;
     	   esac ;;
     	 "ru" ) APP_ANSWER="Russian";;
     	 "es" ) APP_ANSWER="Spanish";;
     	 "sv" ) APP_ANSWER="Swedish";;
     	 "tr" ) APP_ANSWER="Turkish";;
     esac;;
  * ) POL_SetupWindow_menu "$(eval_gettext 'Choose the Internet Explorer language you want')" "$TITLE" "Arabic~Chinese (Simplified)~Chinese (Traditional, Taiwan)~Czech~Danish~Dutch~English~Finnish~French~German~Greek~Hebrew~Hungarian~Italian~Japanese~Korean~Norwegian~Polish~Portuguese (Brazil)~Portuguese (Portugal)~Russian~Spanish~Swedish~Turkish" "~" ;;
esac
 
if [ "$APP_ANSWER" = "Arabic" ]; then
IE8_LINK="http://download.microsoft.com/download/3/8/2/3823FDA9-160A-4972-830A-3ED9012C186A/IE8-WindowsXP-x86-ARA.exe"
IE8_MD5="058e36f21eb6c0a34b9049d15caae1b8"
IE8_INSTALLER="IE8-WindowsXP-x86-ARA.exe"
elif [ "$APP_ANSWER" = "Chinese (Simplified)" ]; then
IE8_LINK="http://download.microsoft.com/download/1/6/1/16174D37-73C1-4F76-A305-902E9D32BAC9/IE8-WindowsXP-x86-CHS.exe"
IE8_MD5="acde10a1f8659cf91a3a323590195b48"
IE8_INSTALLER="IE8-WindowsXP-x86-CHS.exe"
elif [ "$APP_ANSWER" = "Chinese (Traditional, Taiwan)" ]; then
IE8_LINK="http://download.microsoft.com/download/8/3/9/83941BA7-BDE8-4402-BEC4-51D670DF2BAB/IE8-WindowsXP-x86-CHT.exe"
IE8_MD5="b6a1ea23d59c16219aa25fce1ffe544e"
IE8_INSTALLER="IE8-WindowsXP-x86-CHT.exe"
elif [ "$APP_ANSWER" = "Czech" ]; then
IE8_LINK="http://download.microsoft.com/download/7/F/2/7F2D755E-1568-482A-AC6B-2602B50FB88E/IE8-WindowsXP-x86-CSY.exe"
IE8_MD5="6afa953c7ec7b7417e13e80bdf34376d"
IE8_INSTALLER="IE8-WindowsXP-x86-CSY.exe"
elif [ "$APP_ANSWER" = "Danish" ]; then
IE8_LINK="http://download.microsoft.com/download/C/5/A/C5AC24F9-EE0A-4F0D-91B7-D8E08239C93B/IE8-WindowsXP-x86-DAN.exe"
IE8_MD5="e1b44864d089093e829c86b8d390c7a4"
IE8_INSTALLER="IE8-WindowsXP-x86-DAN.exe"
elif [ "$APP_ANSWER" = "Dutch" ]; then
IE8_LINK="http://download.microsoft.com/download/C/6/3/C63E77C7-4A38-45E6-BDBA-10EFFB925F6B/IE8-WindowsXP-x86-NLD.exe"
IE8_MD5="08eeb38f01a901e37e9ba047bb08800d"
IE8_INSTALLER="IE8-WindowsXP-x86-NLD.exe"
elif [ "$APP_ANSWER" = "English" ]; then
IE8_LINK="http://download.microsoft.com/download/C/C/0/CC0BD555-33DD-411E-936B-73AC6F95AE11/IE8-WindowsXP-x86-ENU.exe"
IE8_MD5="616c2e8b12aaa349cd3acb38bf581700"
IE8_INSTALLER="IE8-WindowsXP-x86-ENU.exe"
elif [ "$APP_ANSWER" = "Finnish" ]; then
IE8_LINK="http://download.microsoft.com/download/E/4/F/E4FE5E50-D1A4-4584-9E91-A702496D772C/IE8-WindowsXP-x86-FIN.exe"
IE8_MD5="0ab9340ff720979e453399d690f01e60"
IE8_INSTALLER="IE8-WindowsXP-x86-FIN.exe"
elif [ "$APP_ANSWER" = "French" ]; then
IE8_LINK="http://download.microsoft.com/download/B/B/F/BBFCC870-E61D-4515-B81F-69D4D2F2B23B/IE8-WindowsXP-x86-FRA.exe"
IE8_MD5="acc1e2dcc38ef00452eb0b754351226e"
IE8_INSTALLER="IE8-WindowsXP-x86-FRA.exe"
elif [ "$APP_ANSWER" = "German" ]; then
IE8_LINK="http://download.microsoft.com/download/7/7/7/777F0C67-5404-4420-890A-2F517022F4C0/IE8-WindowsXP-x86-DEU.exe"
IE8_MD5="7164e238994f5d6882cfd6890863328d"
IE8_INSTALLER="IE8-WindowsXP-x86-DEU.exe"
elif [ "$APP_ANSWER" = "Greek" ]; then
IE8_LINK="http://download.microsoft.com/download/7/D/E/7DE51A86-DB86-4F38-8D9E-FF3A37EA6FFF/IE8-WindowsXP-x86-ELL.exe"
IE8_MD5="ae3df63e9f9a6c02451b9964dadd413d"
IE8_INSTALLER="IE8-WindowsXP-x86-ELL.exe"
elif [ "$APP_ANSWER" = "Hebrew" ]; then
IE8_LINK="http://download.microsoft.com/download/B/B/F/BBFDCFC5-0723-4BFE-AA96-D95B816B6C9A/IE8-WindowsXP-x86-HEB.exe"
IE8_MD5="871d8795b795376494e7c296531637af"
IE8_INSTALLER="IE8-WindowsXP-x86-HEB.exe"
elif [ "$APP_ANSWER" = "Hungarian" ]; then
IE8_LINK="http://download.microsoft.com/download/A/2/5/A257E411-C76D-40E4-83D5-BB5B1F3C6F37/IE8-WindowsXP-x86-HUN.exe"
IE8_MD5="0230f460135981c1957a962f8521c08d"
IE8_INSTALLER="IE8-WindowsXP-x86-HUN.exe"
elif [ "$APP_ANSWER" = "Italian" ]; then
IE8_LINK="http://download.microsoft.com/download/7/9/9/7996C6A7-F7A8-4D14-86A2-EE78567FB144/IE8-WindowsXP-x86-ITA.exe"
IE8_MD5="34558ded6de1f10bce1f08c48fcaadd2"
IE8_INSTALLER="IE8-WindowsXP-x86-ITA.exe"
elif [ "$APP_ANSWER" = "Japanese" ]; then
IE8_LINK="http://download.microsoft.com/download/0/5/7/05716044-2806-40DA-8332-D3ED79BC8F68/IE8-WindowsXP-x86-JPN.exe"
IE8_MD5="3b59e3fc451da4829e51e84c22c2ddd1"
IE8_INSTALLER="IE8-WindowsXP-x86-JPN.exe"
elif [ "$APP_ANSWER" = "Korean" ]; then
IE8_LINK="http://download.microsoft.com/download/B/B/0/BB0A25CB-C624-4DC7-8451-20C04D87D6A0/IE8-WindowsXP-x86-KOR.exe"
IE8_MD5="fc9def00f9531829f89445272c951132"
IE8_INSTALLER="IE8-WindowsXP-x86-KOR.exe"
elif [ "$APP_ANSWER" = "Norwegian" ]; then
IE8_LINK="http://download.microsoft.com/download/C/B/B/CBB3E8E0-0121-4B13-BC5E-DEAC199D7095/IE8-WindowsXP-x86-NOR.exe"
IE8_MD5="58ee35286505130360d4bce0b108285e"
IE8_INSTALLER="IE8-WindowsXP-x86-NOR.exe"
elif [ "$APP_ANSWER" = "Polish" ]; then
IE8_LINK="http://download.microsoft.com/download/2/0/C/20C9DC22-2E3E-4B3C-AC23-11C6A4E3E592/IE8-WindowsXP-x86-PLK.exe"
IE8_MD5="f8f8ae75a1b475becb951026c257ec13"
IE8_INSTALLER="IE8-WindowsXP-x86-PLK.exe"
elif [ "$APP_ANSWER" = "Portuguese (Brazil)" ]; then
IE8_LINK="http://download.microsoft.com/download/2/E/B/2EB4A8C1-419A-4139-8608-57109F5568B4/IE8-WindowsXP-x86-PTB.exe"
IE8_MD5="0ed28b6699c50e8321c7af668bd7da77"
IE8_INSTALLER="IE8-WindowsXP-x86-PTB.exe"
elif [ "$APP_ANSWER" = "Portuguese (Portugal)" ]; then
IE8_LINK="http://download.microsoft.com/download/2/2/D/22DCA0D1-F27F-41AD-8B10-27D0C52F2D4B/IE8-WindowsXP-x86-PTG.exe"
IE8_MD5="d8c80964f66a27c718295a8bb8c231c3"
IE8_INSTALLER="IE8-WindowsXP-x86-PTG.exe"
elif [ "$APP_ANSWER" = "Russian" ]; then
IE8_LINK="http://download.microsoft.com/download/D/6/9/D693B7D9-C8E3-4D15-B3D2-59843A8DE90B/IE8-WindowsXP-x86-RUS.exe"
IE8_MD5="8856768bee7667a3abd46e9ed82b4ae1"
IE8_INSTALLER="IE8-WindowsXP-x86-RUS.exe"
elif [ "$APP_ANSWER" = "Spanish" ]; then
IE8_LINK="http://download.microsoft.com/download/3/3/5/3352706D-AE43-4832-BE17-A3AEAEE85FBE/IE8-WindowsXP-x86-ESN.exe"
IE8_MD5="e6032815cac4b4fdd7d48a93de221277"
IE8_INSTALLER="IE8-WindowsXP-x86-ESN.exe"
elif [ "$APP_ANSWER" = "Swedish" ]; then
IE8_LINK="http://download.microsoft.com/download/D/6/0/D6092CEC-BDAD-45C0-AA6A-EE10EB03BD45/IE8-WindowsXP-x86-SVE.exe"
IE8_MD5="c5e258b2849e42d9e28c9e3d55fb58ef"
IE8_INSTALLER="IE8-WindowsXP-x86-SVE.exe"
elif [ "$APP_ANSWER" = "Turkish" ]; then
IE8_LINK="http://download.microsoft.com/download/C/B/7/CB7C2809-EB9C-4640-90CE-8E98E641BA64/IE8-WindowsXP-x86-TRK.exe"
IE8_MD5="f62db3576469e34f1595f469207c3638"
IE8_INSTALLER="IE8-WindowsXP-x86-TRK.exe"
fi
  
# Téléchargement de Internet Explorer
POL_Download_Resource "$IE8_LINK" "$IE8_MD5"
  
# Installations complémentaires
POL_Wine_InstallFonts
POL_Call POL_Function_FontsSmoothRGB
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msls31
POL_Call POL_Install_msxml3
POL_Call POL_Install_riched20
POL_Call POL_Install_DisableCrashDialog
  
# Remplacement de DLL
POL_Wine_OverrideDLL native,builtin browseui crypt32 hhctrl.ocx hlink iernonce iexplore.exe itircl itss jscript mlang mshtml msimtf secur32 shdoclc shdocvw shlwapi url urlmon usp10 uxtheme wintrust xmllite
POL_Wine_OverrideDLL builtin wininet
  
# Telechargement et installation de DLL
POL_Download_Resource "$SITE/divers/ie7-dlls.tar.bz2" "b71a3213452c9a3a1aa08767d52e7577"
tar -xvf ie7-dlls.tar.bz2
mv "msctf.dll" "$WINEPREFIX/drive_c/windows/system32"
mv "msimtf.dll" "$WINEPREFIX/drive_c/windows/system32"
mv "uxtheme.dll" "$WINEPREFIX/drive_c/windows/system32"
  
# Installation de Internet Explorer
POL_Wine --ignore-errors "$IE8_INSTALLER"
  
# Redemarrage de Wine
POL_Wine_reboot
  
# Fermeture de la condition (fin du script)
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgvrDAAKCRDlMfrJqhPK
R2TqAJ9w0pCvGGB59TY7eSvgvX1UyxapvQCghiProNmKtDMidGJrXlq2ppCM1E4=
=lXQw
-----END PGP SIGNATURE-----
