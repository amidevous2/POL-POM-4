#!/bin/bash
# Date : 26-02-2010
# Last revision : 26-02-2010
# Wine version used : 1.1.35
# Distribution used to test : Ubuntu Karmic
# Author : Lennart Hansen - lahansen@gmail.com
# Depend : DirectX 9

# Notes:
# Register on: https://accounts.pkr.com/register.aspx
# Run in full screen or screen will not be aligned properly
# Disable Compiz / Desktop Effects or screen might flicker or PKR crash

# Application Specific Vars
TITLE="PKR - let's play"
APPDIR="PKRPoker"
APPEXEC="pkr.exe"
APPLINK="http://www.pkr.com/en/download/now/pkrinstall.exe"
LOGOLINK="http://www.rakeback.com/images/rooms/pkr-logo-black-135x135.gif"
ICONLINK="http://www.p3poker.com/images/pkrlogo.png"
REMOVELIST="$HOME/Desktop/Play\ PKR.desktop

$HOME/Desktop/Play\ PKR.lnk"
WINE="1.1.35"
PKRCONFIG='<?xml version="1.0" encoding="UTF-8"?>
<options>
<games>
<modules
type="string"
>avatar;common;poker;blackjack;casinoholdem;roulette;videopoker</modules>
<hideuninstalledonplay
type="string"
>casino2d;sportsbook;dond;euroroulette</hideuninstalledonplay>
<available type="u32">7</available>
</games>
<options>
<graphics>
<screen>
<fullscreen type="bool">true</fullscreen>
<vsync type="bool">true</vsync>
<resolution type="string">1024x768</resolution>
<maximized type="bool">false</maximized>
<antialias type="string" />
</screen>
</graphics>
<game>
<game>
<free_check_warning
type="bool"
>false</free_check_warning>
<profanity_filter
type="bool"
>false</profanity_filter>
<always_muck_losing_hands
type="bool"
>true</always_muck_losing_hands>
<never_show_uncalled
type="bool"
>true</never_show_uncalled>
</game>
<camera>
<default_camera type="string">Orbit</default_camera>
<cut_to_dynamic
type="string"
>Out Of Hand</cut_to_dynamic>
</camera>
<minigame>
<roulette>
<panelX type="float">0.500000</panelX>
<panelY type="float">0.500000</panelY>
</roulette>
</minigame>
</game>
<audio>
<volumes>
<menu_music type="float">0.000000</menu_music>
</volumes>
</audio>
</options>
<frontend>
<startup>
<name type="string">poker</name>
</startup>
</frontend>
<interface>
<chat>
<fontsize type="int">0</fontsize>
<infolevel type="int">0</infolevel>
</chat>
<menubutton>
<mood_button type="u32">2</mood_button>
<chiptrick_button_1 type="u32">1</chiptrick_button_1>
<emote_button_2 type="u32">41</emote_button_2>
<emote_button_4 type="u32">3</emote_button_4>
<emote_button_3 type="u32">24</emote_button_3>
<emote_button_1 type="u32">26</emote_button_1>
<min_players_button type="u32">1</min_players_button>
</menubutton>
</interface>
</options>'

# Install specific vars
DOWNLOADINGINSTALLING="PlayOnLinux is downloading and installing"
INSTALLED="has been installed successfully"
PREFIX="$HOME/.PlayOnLinux/wineprefix/$APPDIR/"
WINDIR="$PREFIX/drive_c/windows/"
TMPDIR="$PREFIX/drive_c/tmp/"
TMPDIR_WIN='c:\tmp'
PROGRAMFILESDIR_UNIX="$PREFIX/drive_c/Program\ Files/"
ICONDIR="$HOME/.PlayOnLinux/icones"

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

cd "$REPERTOIRE/tmp/"
LOGOFILE=$(basename $LOGOLINK)
wget "$LOGOLINK" -O "$LOGOFILE"

# Functions

install_d3dx9() {
cd "$REPERTOIRE/ressources"
#downloading directx9
if [ ! -e "directx_aug2009_redist.exe" ];
then
POL_SetupWindow_download "Downloading" "directx9" "http://download.microsoft.com/download/B/7/9/B79FC9D7-47B8-48B7-A75E-101DEBEB5AB4/directx_aug2009_redist.exe"
fi

mkdir "Directx"
cd Directx
cabextract "../directx_aug2009_redist.exe"

mkdir "d3dx9"
cabextract -d "d3dx9" *d3dx9*x86*

cd "d3dx9"
mv *.dll "$WINEPREFIX/drive_c/windows/system32"

#Réglage Directx9
cd "$WINEPREFIX/drive_c/windows/temp"
cat << EOF > OGL.reg
[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]
"d3dx9_24"="native"
"d3dx9_25"="native"
"d3dx9_26"="native"
"d3dx9_27"="native"
"d3dx9_28"="native"
"d3dx9_29"="native"
"d3dx9_30"="native"
"d3dx9_31"="native"
"d3dx9_32"="native"
"d3dx9_33"="native"
"d3dx9_34"="native"
"d3dx9_35"="native"
"d3dx9_36"="native"
"d3dx9_37"="native"
"d3dx9_38"="native"
"d3dx9_39"="native"
"d3dx9_40"="native"
"d3dx9_41"="native"
"d3dx9_42"="native"
EOF
regedit OGL.reg

cd "$REPERTOIRE/ressources"
rm -rf Directx
}


# Installation

POL_SetupWindow_Init "" "$LOGOFILE"
INSTALLTXT=$(eval_gettext "This wizard will help you to install $TITLE in a playonlinux prefix")
POL_SetupWindow_free_presentation "$TITLE" "$INSTALLTXT"

select_prefix "$PREFIX"

if [ ! -e "$PREFIX" ]; then
POL_SetupWindow_prefixcreate
fi

fonts_to_prefix

POL_SetupWindow_install_wine "$WINE"
Use_WineVersion "$WINE"
mkdir -p "$TMPDIR"
sleep 2

# Install Dependencies

install_d3dx9

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
POL_SetupWindow_message "$TITLE $INSTALLED

Now go to https://accounts.pkr.com/register.aspx and register
if you don't have an account already

Warning: Screen might flicker or PKR crash if you do not disable Compiz / Desktop effects
and appear wrong and behaive badly if you do not run it fullscreen.

Enjoy" "$TITLE"

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

APPINSTALLDIR="$PROGRAMFILES/PKR/"


mkdir -p "$WINEPREFIX/drive_c/$APPINSTALLDIR/"
echo $PKRCONFIG > "$WINEPREFIX/drive_c/$APPINSTALLDIR/preferences.xml"

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

iEYEABECAAYFAk1cJFUACgkQ5TH6yaoTykeX0QCeN1uBCBftDL9uWfgeLTJjyHUU
CrsAn1wEFZVAsaNBIUkDHttg/Ib4++ZZ
=wGWw
-----END PGP SIGNATURE-----
