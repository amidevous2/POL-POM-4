#!/bin/bash
# Date : (2013-02-25 21-49)
# Last revision : (2014-04-02 23-13)
# Wine version used : 1.4.1, 1.5.18
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Wine 1.4.1, 1.5.15, 1.5.17, 1.5.18: ok
# Wine 1.5.19, 1.5.22, 1.6, 1.6.2, 1.7.13: crashes in quartz when trying to play tutorials 
#   (intro videos are fine)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="commandos_ammo_pack"
PREFIX="CommandosAP_gog"
WORKING_WINE_VERSION="1.5.18"

TITLE="GOG.com - Commandos Ammo Pack"
SHORTCUT_NAME1="Commandos: Behind Enemy Lines"
SHORTCUT_NAME2="Commandos: Beyond The Call Of Duty"
SHORTCUT_NAMEDS="Commandos: Dedicated Server"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1594
which ffmpeg || POL_Debug_Fatal "$(eval_gettext 'This install script requires ffmpeg')"
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Pyro Studios / Digital Game Factory" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"


POL_Call POL_GoG_setup "$GOGID" "7f3c464722c4d14a48b2580b69e9523c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_Call POL_Install_devenum
POL_Call POL_Install_quartz
POL_Call POL_Install_amstream
POL_Call POL_Install_wmp9
POL_Call POL_Install_ffdshow

# Hide ffdshow systray icon
cat << _EOFREG_ >> "$POL_USER_ROOT/tmp/hideffdshow.reg"
[HKEY_CURRENT_USER\Software\GNU\ffdshow_audio]
"trayIcon"=dword:00000000
_EOFREG_
POL_Wine regedit "$POL_USER_ROOT/tmp/hideffdshow.reg"
rm "$POL_USER_ROOT/tmp/hideffdshow.reg"

convert_videos () {
    local DIR="$1"
    shift

    cd "$GOGROOT/Commandos Ammo Pack/$DIR" || POL_Debug_Fatal "Could not find game directory"
    [ -d Cinepak ] || mkdir Cinepak
    mv *.avi Cinepak/

    for i in "$@"; do
        POL_SetupWindow_set_text "$i"
        ffmpeg -i "Cinepak/$i" -c:v wmv2 -b:v 2000k "$i"
        let FILES++
        POL_SetupWindow_pulse $((100 * FILES / TOTAL))
    done
}

POL_SetupWindow_pulsebar "$(eval_gettext 'Converting videos...')" "$TITLE"
FILES=0
TOTAL=18

convert_videos 'Commandos 1/VIDEO/'  H_Afri.avi H_Intro.avi H_Norm.avi H_Noru.avi H_Rhin.avi H_Vict.avi Tut_1.avi Tut_2.avi Tut_3.avi Tut_4.avi Tut_5.avi Tut_6.avi Tut_7.avi
convert_videos 'Commandos 1 Beyond The Call Of Duty/VIDEO/' 1_v.avi 2_v.avi 3_v.avi 4_v.avi h_intro.avi

# "3D DirectX7"?
POL_SetupWindow_VMS "4"

# Mouse to borders to scroll around
POL_Wine_X11Drv "GrabFullScreen" "Y"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "comandos.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Commandos Ammo Pack/Commandos 1/Manual.pdf"

POL_Shortcut "coman_mp.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Commandos Ammo Pack/Commandos 1 Beyond The Call Of Duty/Manual.pdf"

# C:\GOG Games\Commandos Ammo Pack\Commandos 1 Beyond The Call Of Duty\mpserver.exe

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlM8ggkACgkQ5TH6yaoTykdwqACeKjYA7J9gnVTgeqojkcP0bdtv
F6cAn33Vg4RB9qli8FVJAmV9z5e+c9Fv
=r/hZ
-----END PGP SIGNATURE-----
