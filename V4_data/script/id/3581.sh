#!/usr/bin/env playonlinux-bash
# Date : (2019-08-02 03-49)
# Last revision : (2021-10-12 14-47)
# Wine version used : 6.0.1
# Distribution used to test : Linux Mint 20.1 Cinnamon
# Author : Yaotl
# PlayOnLinux : 4.3.4
# Script licence : GPL3


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="IrfanView"
PREFIX="IrfanView"

# Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 3581
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "Irfan Škiljan" "https://www.irfanview.com/" "Yaotl" "$PREFIX"

POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "6.0.1"

POL_Call POL_Install_corefonts

#Set_OS "win10"

# Download
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
if [ "$POL_ARCH" = "amd64" ]; then
    SetupFile="iview458_x64_setup.exe"
    SetupFilePlugins="iview458_plugins_x64_setup.exe"
    ShortEXE="i_view64.exe"
    i_ini="i_view64.ini"
else
    SetupFile="iview458_setup.exe"
    SetupFilePlugins="iview458_plugins_setup.exe"
    ShortEXE="i_view32.exe"
    i_ini="i_view32.ini"
fi

wget --referer=https://www.irfanview.info/files/$SetupFile https://www.irfanview.info/files/$SetupFile
wget --referer=https://www.irfanview.info/files/$SetupFilePlugins https://www.irfanview.info/files/$SetupFilePlugins

# toolbar skin: Michael Grosberg, Button sizes: 16, 24, 32
POL_Download "https://www.irfanview.com/skins/irfanview_skin_grosberg.zip" "4f9da947262e03be8afb545391453931"

# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$POL_System_TmpDir/$SetupFile" /silent /folder="C:\Program Files\IrfanView"
POL_Wine_WaitExit "$TITLE"
POL_Wine start /unix "$POL_System_TmpDir/$SetupFilePlugins" /silent /folder="C:\Program Files\IrfanView"
POL_Wine_WaitExit "$TITLE"
unzip "$POL_System_TmpDir/irfanview_skin_grosberg.zip" -d "$WINEPREFIX/drive_c/Program Files/IrfanView/Toolbars"

# Create Shortcut
POL_Shortcut "$ShortEXE" "$TITLE" "" "" "Graphics;"

# Automatic language selection
lang_install="true"

if [ "$POL_LANG" = "en" ]; then # English
    lang_install="false"
    DLL="ENGLISH"
    Lang="English"
elif [ "$POL_LANG" = "de" ]; then # German
    lang_setup="irfanview_lang_deutsch.exe"
    DLL="DEUTSCH.DLL"
    Lang="Deutsch"
elif [ "$POL_LANG" = "fr" ]; then # French
    lang_setup="irfanview_lang_french.exe"
    DLL="FRENCH.DLL"
    Lang="Francais"
elif [ "$POL_LANG" = "ar" ]; then # Arabic
    lang_setup="irfanview_lang_arabic.exe"
    DLL="ARABIC.DLL"
    Lang="Arabic"
elif [ "$POL_LANG" = "bg" ]; then # Bulgarian
    lang_setup="irfanview_lang_bulgarian.exe"
    DLL="BULGARIAN.DLL"
    Lang="Bulgarian"
elif [ "$POL_LANG" = "ca" ]; then # Catalan
    lang_setup="irfanview_lang_catalan.exe"
    DLL="CATALAN.DLL"
    Lang="Català"
elif [ "$POL_LANG" = "zh" ]; then # Chinese
    lang_setup="irfanview_lang_chinese.exe"
    DLL="CHINESE_SIMP.DLL"
    Lang="Chinese simple"
elif [ "$POL_LANG" = "hr" ]; then # Croatian
    lang_setup="irfanview_lang_hrvatski.exe"
    DLL="HRVATSKI.DLL"
    Lang="Hrvatski"
elif [ "$POL_LANG" = "cs" ]; then # Czech
    lang_setup="irfanview_lang_czech.exe"
    DLL="CZECH.DLL"
    Lang="Czech"
elif [ "$POL_LANG" = "da" ]; then # Danish
    lang_setup="irfanview_lang_dansk.exe"
    DLL="DANSK.DLL"
    Lang="Dansk"
elif [ "$POL_LANG" = "et" ]; then # Estonian
    lang_setup="irfanview_lang_estonian.exe"
    DLL="ESTONIAN.DLL"
    Lang="Eesti"
elif [ "$POL_LANG" = "fi" ]; then # Finnish
    lang_setup="irfanview_lang_finnish.exe"
    DLL="FINNISH.DLL"
    Lang="Suomi"
elif [ "$POL_LANG" = "el" ]; then # Greek
    lang_setup="irfanview_lang_greek.exe"
    DLL="HELLENIC.DLL"
    Lang="Greek"
elif [ "$POL_LANG" = "he" ]; then # Hebrew
    lang_setup="irfanview_lang_hebrew.exe"
    DLL="HEBREW.DLL"
    Lang="Hebrew"
elif [ "$POL_LANG" = "hu" ]; then # Hungarian
    lang_setup="irfanview_lang_hungarian.exe"
    DLL="MAGYAR.DLL"
    Lang="Magyar"
elif [ "$POL_LANG" = "it" ]; then # Italian
    lang_setup="irfanview_lang_italian.exe"
    DLL="ITALIAN.DLL"
    Lang="Italiano"
elif [ "$POL_LANG" = "ja" ]; then # Japanese
    lang_setup="irfanview_lang_japanese.exe"
    DLL="JAPANESE.DLL"
    Lang="Japanese"
elif [ "$POL_LANG" = "ko" ]; then # Korean
    lang_setup="irfanview_lang_korean.exe"
    DLL="KOREAN.DLL"
    Lang="Korean"
elif [ "$POL_LANG" = "lv" ]; then # Latvian
    lang_setup="irfanview_lang_latvian.exe"
    DLL="LATVIAN.DLL"
    Lang="Latviešu (Latvian)"
elif [ "$POL_LANG" = "lt" ]; then # Lithuanian
    lang_setup="irfanview_lang_lithuanian.exe"
    DLL="LITHUANIAN.DLL"
    Lang="Lithuanian"
elif [ "$POL_LANG" = "nl" ]; then # Nederlands
    lang_setup="irfanview_lang_nederlands.exe"
    DLL="NEDERLANDS.DLL"
    Lang="Nederlands"
elif [ "$POL_LANG" = "pl" ]; then # Polski
    lang_setup="irfanview_lang_polski.exe"
    DLL="POLSKI.DLL"
    Lang="Polski"
elif [ "$POL_LANG" = "pt" ]; then # Portuguese
    lang_setup="irfanview_lang_portuguese.exe"
    DLL="PORTUGUESE.DLL"
    Lang="Portuguese (Portugal)"
elif [ "$POL_LANG" = "ro" ]; then # Romanian
    lang_setup="irfanview_lang_romanian.exe"
    DLL="ROMANIAN.DLL"
    Lang="Romanian"
elif [ "$POL_LANG" = "ru" ]; then # Russian
    lang_setup="irfanview_lang_russian.exe"
    DLL="RUSSIAN.DLL"
    Lang="Russian"
elif [ "$POL_LANG" = "sk" ]; then # Slovak
    lang_setup="irfanview_lang_slovak.exe"
    DLL="SLOVAK.DLL"
    Lang="Slovensky/Slovak"
elif [ "$POL_LANG" = "sl" ]; then # Slovenian
    lang_setup="irfanview_lang_slovenscina.exe"
    DLL="SLOVENSCINA.DLL"
    Lang="Slovenian"
elif [ "$POL_LANG" = "es" ]; then # Spanish
    lang_setup="irfanview_lang_spanish.exe"
    DLL="SPANISH.DLL"
    Lang="Español"
elif [ "$POL_LANG" = "sv" ]; then # Swedish
    lang_setup="irfanview_lang_swedish.exe"
    DLL="SWEDISH.DLL"
    Lang="Svenska"
elif [ "$POL_LANG" = "tr" ]; then # Turkish
    lang_setup="irfanview_lang_turkish.exe"
    DLL="TURKISH.DLL"
    Lang="Türkçe"
elif [ "$POL_LANG" = "uk" ]; then # Ukrainian
    lang_setup="irfanview_lang_ukrainian.exe"
    DLL="UKRAINIAN.DLL"
    Lang="Ukrainian"
elif [ "$POL_LANG" = "uz" ]; then # Uzbek
    lang_setup="irfanview_lang_uzbek.exe"
    DLL="UZBEK.DLL"
    Lang="Uzbek"
else
    lang_install="false"
    DLL="ENGLISH"
    Lang="English"
    POL_Browser "https://www.irfanview.com/languages.htm"
fi

if [ "$lang_install" = "true" ]; then
    cd "$POL_System_TmpDir"
    POL_Download "https://www.irfanview.net/lang/$lang_setup"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$POL_System_TmpDir/$lang_setup"
    POL_Wine_WaitExit "$TITLE"
fi

POL_Debug_Message "Selected language. Wine: $POL_LANG; lang_install: $lang_install; DLL: $DLL; Lang: $Lang; lang_setup: $lang_setup;"

cat << EOF > "$WINEPREFIX/drive_c/Program Files/IrfanView/$i_ini"
[Language]
DLL=$DLL
Lang=$Lang
[Toolbar]
Skin=Grosberg_32.png
Size=32
EOF

# Cleanup
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYWcBCQAKCRDlMfrJqhPK
R9ZZAJ0eIGk8+WnnnGqEQ9Xx0xRmZJyvJgCghFv2yA71Y198EB3OeAfm0qf9TNw=
=To3Z
-----END PGP SIGNATURE-----
