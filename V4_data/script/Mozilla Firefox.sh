#!/usr/bin/env playonlinux-bash

# Date : (2011-06-13 17-29)
# Last revision : see changelog
# Wine version used : X
# Distribution used to test : OpenSUSE 13.1
# Firefox Version used to test : 31.0
# Author : SuperPlumus

# CHANGELOG
# [SuperPlumus] (2011-11-27 08-24)
#   Correction links + md5 for Flash Player and Shockwave Player (bug 567)
#   Correction link + md5 for Java
# [SuperPlumus] (2012-02-24 05-20)
#   Remove cheking md5 for Flash Player and Shockwave Player (Bug 673)
# [SuperPlumus] (2012-04-06 19-40)
#   Change Wine version 1.3.26 -> 1.4
#   Remove optionnal install Java
# [SuperPlumus] (2012-04-11 09-32)
#   Add support $POL_SELECTED_FILE
# [Quentin PÂRIS] (2012-05-12 23-05)
#   Improving theme
# [SuperPlumus] (2013-05-09 17-27)
#   Re-add support Shockwave Player (precedently disabled for bad url)
#   Clean code
#   Remove disable plugin-container (dom.ipc.plugins.enabled = false)
#   Shockwave Player : Set OS win2k to prevent crash on Shockwave Player installation, set winxp at the end of the Shockwave Player installation
# [SuperPlumus] (2013-09-30 08-41)
#   Update gettext messages
# [petch] (2013-10-13 17-41)
#   Change Wine version 1.4 -> 1.6
# [Ground0] (2014-07-25)
#   Change Wine version 1.6 -> 1.7.22
# [SuperPlumus] (2015-05-02 23-55)
#   Update download url mirror
# [petch] (2015-11-23 23-48)
#   Update download urls
# [SuperPlumus] (2017-05-20 16-24)
#   Set Windows version to win7 to setup (setup refuses to install in winxp)
#   Set Windows version to xinxp after setup, workarround, Firefox can't load any page in win7 after first starting, cf. https://bugs.winehq.org/show_bug.cgi?id=42388
#   Update wine version to 2.0.1
# [Dadu] (2020-03-17 20-47)
#   Update wine 2.0.1 (outdated) -> 2.22
#   Improve POL_Shortcut
#   Problem (Wine 3.0.3  Firefox v74+flash+shockwave): Adobe Shockwave installer stall at ~20 % (at: 'SwDnld.exe /regserver'). Firefox does crash when launched.

 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Mozilla Firefox"
PREFIX="MozillaFirefox"
WORKING_WINE_VERSION="2.22"
 
PLUGIN_NAME_FLASH="Flash Player"
PLUGIN_NAME_SHOCKWAVE="Shockwave Player"
 
PLUGIN_FILE_SHOCKWAVE="Shockwave_Installer_Full.exe"
PLUGIN_URL_SHOCKWAVE="http://fpdownload.macromedia.com/get/shockwave/default/english/win95nt/latest/$PLUGIN_FILE_SHOCKWAVE"
 
# Fonction pour simplifier l'utilisation de POL_SetupWindow_checkbox_list
is_checked ()
{
    if [ "$(echo "$CHECKS" | grep -o "$1")" != "" ]; then
        return 0
    else
        return 1
    fi
}
 
POL_GetSetupImages "$SITE/setups/firefox/top.jpg" "$SITE/setups/firefox/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 856
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Mozilla" "http://www.mozilla.com" "SuperPlumus" "$PREFIX"
 
 
POL_Wine_EnableOSXNativeDock # A new feature for PlayOnMac. Firefox is the first test
 
POL_System_TmpCreate "$PREFIX"
 
if [ -n "$POL_SELECTED_FILE" ]; then
    INSTALLER="$POL_SELECTED_FILE"
else
    POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
    if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        # Language version
        POL_SetupWindow_menu "$(eval_gettext 'Which language version would you like to install?')" "$TITLE" "Afrikaans~Albanian~Arabic~Asturian~Basque~Belarusian~Bengali (Bangladesh)~Bengali (India)~Breton~Bulgarian~Catalan~Chinese (Simplified)~Chinese (Traditional)~Croatian~Czech~Danish~Dutch~English (British)~English (South African)~English (US)~Esperanto~Estonian~Finnish~French~Frisian~Gaelic (Scotland)~Galician~German~Greek~Gujarati~Hebrew~Hindi (India)~Hungarian~Indonesian~Icelandic~Irish (Ireland)~Italian~Japanese~Kannada~Korean~Latvian~Lithuanian~Macedonian~Malayalam~Marathi~Norwegian (Bokmål)~Norwegian (Nynorsk)~Persian~Polish~Portuguese (Brazilian)~Portuguese (Portugal)~Punjabi~Romanian~Romansh~Russian~Sinhala~Slovak~Slovenian~Spanish (Argentina)~Spanish (Chile)~Spanish (Mexico)~Spanish (Spain)~Swedish~Telugu~Thai~Turkish~Ukrainian~Vietnamese~Welsh" "~"
 
        case "$APP_ANSWER" in
            "Afrikaans") FIREFOX_LANG="af" ;;
            "Albanian") FIREFOX_LANG="sq" ;;
            "Arabic") FIREFOX_LANG="ar" ;;
            "Asturian") FIREFOX_LANG="ast" ;;
            "Basque") FIREFOX_LANG="eu" ;;
            "Belarusian") FIREFOX_LANG="be" ;;
            "Bengali (Bangladesh)") FIREFOX_LANG="bn-BD" ;;
            "Bengali (India)") FIREFOX_LANG="bn-IN" ;;
            "Breton") FIREFOX_LANG="br" ;;
            "Bulgarian") FIREFOX_LANG="bg" ;;
            "Catalan") FIREFOX_LANG="ca" ;;
            "Chinese (Simplified)") FIREFOX_LANG="zh-CN" ;;
            "Chinese (Traditional)") FIREFOX_LANG="zh-TW" ;;
            "Croatian") FIREFOX_LANG="hr" ;;
            "Czech") FIREFOX_LANG="cs" ;;
            "Danish") FIREFOX_LANG="da" ;;
            "Dutch") FIREFOX_LANG="nl" ;;
            "English (British)") FIREFOX_LANG="en-GB" ;;
            "English (South African)") FIREFOX_LANG="en-ZA" ;;
            "English (US)") FIREFOX_LANG="en-US" ;;
            "Esperanto") FIREFOX_LANG="eo" ;;
            "Estonian") FIREFOX_LANG="et" ;;
            "Finnish") FIREFOX_LANG="fi" ;;
            "French") FIREFOX_LANG="fr" ;;
            "Frisian") FIREFOX_LANG="fy-NL" ;;
            "Gaelic (Scotland)") FIREFOX_LANG="gd" ;;
            "Galician") FIREFOX_LANG="gl" ;;
            "German") FIREFOX_LANG="de" ;;
            "Greek") FIREFOX_LANG="el" ;;
            "Gujarati") FIREFOX_LANG="gu-IN" ;;
            "Hebrew") FIREFOX_LANG="he" ;;
            "Hindi (India)") FIREFOX_LANG="hi-IN" ;;
            "Hungarian") FIREFOX_LANG="hu" ;;
            "Icelandic") FIREFOX_LANG="is" ;;
            "Indonesian") FIREFOX_LANG="id" ;;
            "Irish (Ireland)") FIREFOX_LANG="ga-IE" ;;
            "Italian") FIREFOX_LANG="it" ;;
            "Japanese") FIREFOX_LANG="ja" ;;
            "Kannada") FIREFOX_LANG="kn" ;;
            "Korean") FIREFOX_LANG="ko" ;;
            "Latvian") FIREFOX_LANG="lv" ;;
            "Lithuanian") FIREFOX_LANG="lt" ;;
            "Macedonian") FIREFOX_LANG="mk" ;;
            "Malayalam") FIREFOX_LANG="ml" ;;
            "Marathi") FIREFOX_LANG="mr" ;;
            "Norwegian (Bokmål)") FIREFOX_LANG="nb-NO" ;;
            "Norwegian (Nynorsk)") FIREFOX_LANG="nn-NO" ;;
            "Persian") FIREFOX_LANG="fa" ;;
            "Polish") FIREFOX_LANG="pl" ;;
            "Portuguese (Brazilian)") FIREFOX_LANG="pt-BR" ;;
            "Portuguese (Portugal)") FIREFOX_LANG="pt-PT" ;;
            "Punjabi") FIREFOX_LANG="pa-IN" ;;
            "Romanian") FIREFOX_LANG="ro" ;;
            "Romansh") FIREFOX_LANG="rm" ;;
            "Russian") FIREFOX_LANG="ru" ;;
            "Sinhala") FIREFOX_LANG="si" ;;
            "Slovak") FIREFOX_LANG="sk" ;;
            "Slovenian") FIREFOX_LANG="sl" ;;
            "Spanish (Argentina)") FIREFOX_LANG="es-AR" ;;
            "Spanish (Chile)") FIREFOX_LANG="es-CL" ;;
            "Spanish (Mexico)") FIREFOX_LANG="es-MX" ;;
            "Spanish (Spain)") FIREFOX_LANG="es-ES" ;;
            "Swedish") FIREFOX_LANG="sv-SE" ;;
            "Telugu") FIREFOX_LANG="te" ;;
            "Thai") FIREFOX_LANG="th" ;;
            "Turkish") FIREFOX_LANG="tr" ;;
            "Ukrainian") FIREFOX_LANG="uk" ;;
            "Vietnamese") FIREFOX_LANG="vi" ;;
            "Welsh") FIREFOX_LANG="cy" ;;
            *) POL_Debug_Fatal "$APP_ANSWER : Incorrect value, bug." ;;
        esac
 
        # Detection de la derniere version
        cd "$POL_System_TmpDir"
 
        # https://download-installer.cdn.mozilla.net/pub/firefox/releases/latest/README.txt
        # No MD5, since the script uses the latest installer version available
        POL_Download "https://download.mozilla.org/?product=firefox-latest&os=win&lang=$FIREFOX_LANG"
        INSTALLER="$POL_System_TmpDir/FirefoxSetup.exe"
        POL_System_mv "$POL_System_TmpDir/?product=firefox-latest&os=win&lang=$FIREFOX_LANG" "$INSTALLER"
 
    elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        INSTALLER="$APP_ANSWER"
    fi
fi
 
AVAILABLE_PLUGINS="$PLUGIN_NAME_FLASH~$PLUGIN_NAME_SHOCKWAVE"
 
POL_SetupWindow_checkbox_list "$(eval_gettext 'Check which components do you want to install additionally:')" "$TITLE" "$AVAILABLE_PLUGINS" "~"
CHECKS="$APP_ANSWER"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Firefox setup refuses to install in winxp
Set_OS "win7"
 
POL_Call POL_Install_LunaTheme
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
 
# Workarround, Firefox can't load any page in win7 after first starting, cf. https://bugs.winehq.org/show_bug.cgi?id=42388
Set_OS "winxp"
 
cd "$POL_System_TmpDir"
 
# Flash Player
if is_checked "$PLUGIN_NAME_FLASH"; then
    POL_Call POL_Install_flashplayer
fi
 
# Shockwave Player
if is_checked "$PLUGIN_NAME_SHOCKWAVE"; then
    POL_Download "$PLUGIN_URL_SHOCKWAVE" ""
    POL_Wine_WaitBefore "$PLUGIN_NAME_SHOCKWAVE"
    Set_OS "win2k"
    POL_Wine "$PLUGIN_FILE_SHOCKWAVE"
    Set_OS "winxp"
    POL_Wine_WaitExit "$PLUGIN_NAME_SHOCKWAVE"
fi
 
# Disables plugin container (that makes Firefox crash on pages that already used flash/shockwave)
#echo "pref("dom.ipc.plugins.enabled", false);" > "$WINEPREFIX/drive_c/$PROGRAMFILES/Mozilla Firefox/defaults/pref/firefox.js"
 
POL_System_TmpDelete
 
POL_Shortcut "firefox.exe" "$TITLE" "" "" "Network;"
 
POL_SetupWindow_Close
 
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnFEsgAKCRDlMfrJqhPK
R7e5AKCGzYvfApyVKiRxYdaH130T9ew9SACfSMYtWyHMWAaNeAemB7c49sBOSCA=
=7++k
-----END PGP SIGNATURE-----
