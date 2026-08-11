#!/bin/bash
# Date : (2010-04-03 20-00)
# Last revision : (2010-04-03 20-00)
# Wine version used : 1.1.42
# Distribution used to test : Fedora 12
# Author : NSLW
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTULS3="The Sims 3"
TYTULEP01="The Sims 3 World Adventures"
TYTULSP01="The Sims 3 High-End Loft Stuff"
PREFIX="TheSims3"
WORKINGWINEVERSION="1.1.42"
PATCHVERSIONS3="1.11.7.005"
PATCHVERSIONEP01="2.6.11.005"
PATCHVERSIONSP01="3.2.8.005"

LNG_DOWNLOADING="PlayOnLinux is downloading"
LNG_INSTALLING="PlayOnLinux is installing"
LNG_INSTINPROGRESS="Installation in progress..."
LNG_PATCHSUCCES="Patch for $TYTULS3 has been installed successfully"
LNG_DETECTED="was detected\nand will be updated right now."
LNG_PATCHM="Let me choose patch manually"
LNG_PATCHA="Download patch automatically"
LNG_UPTODATE="is up to date."
LNG_CHOOSEACTION="What do you want to do?"
LNG_PATCH="Patch game"
LNG_PATCHVQ1="Your game will be updated\nfrom version:"
LNG_PATCHVQ2="to version:"
LNG_PATCHVQ3="Patch will be downloaded\nDo you agree?"
LNG_NOMOREADDONS="No more add-ons were detected.\nThe installer will finish now."

if [ "$POL_LANG" == "pl" ]; then
LNG_DOWNLOADING="PlayOnLinux pobiera"
LNG_INSTALLING="PlayOnLinux instaluje"
LNG_INSTINPROGRESS="Instalacja w trakcie..."
LNG_PATCHSUCCES="Łatka do $TYTULS3 została zainstalowana pomyślnie"
LNG_DETECTED="zostało wykryte\ni zostanie zaktualizowane."
LNG_PATCHM="Pozwól mi wybrać łatkę samodzielnie"
LNG_PATCHA="Pobierz łatkę automatycznie"
LNG_UPTODATE="jest już zaktualizowane."
LNG_CHOOSEACTION="Co chcesz zrobić?"
LNG_PATCH="Łataj grę"
LNG_PATCHVQ1="Twoja gra będzie zaktualizowana\nz wersji:"
LNG_PATCHVQ2="do wersji:"
LNG_PATCHVQ3="Łatka będzie pobrana.\nCzy zgadzasz się na to?"
LNG_NOMOREADDONS="Nie wykryto więcej rozszerzeń.\nInstalator zakończy w tej chwili."

elif [ "$POL_LANG" == "de" ]; then
LNG_DOWNLOADING="PlayOnLinux ladet herunter"
LNG_INSTALLING="PlayOnLinux installiert"
LNG_INSTINPROGRESS="Es wird installiert..."
LNG_PATCHSUCCES="Patch für $TYTULS3 ist erfolgreich installiert worden."
LNG_DETECTED="wurde entdeckt\nund wird aktualisiert."
LNG_PATCHM="Lass mich Patch selbst aussuchen"
LNG_PATCHA="Lade Patch automatisch herunter"
LNG_UPTODATE="ist shon aktualisiert."
LNG_CHOOSEACTION="Was willst du machen?"
LNG_PATCH="Patch einspielen"
LNG_PATCHVQ1="Dein Spiel wird aktualisiert\nvon Version:"
LNG_PATCHVQ2="auf Version:"
LNG_PATCHVQ3="Patch wird herunterladet.\nStimmen Sie darauf zu?"
LNG_NOMOREADDONS="Keine Erweiterungen wurden mehr entdeckt.\nDer Installateur wird jetz beenden."
fi

patch_TheSims3()
#$1 - Title of the game
#$2 - Number of the patch
{

#get SKU number
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/$1/Game/Bin"
PATCHFROMVER=`grep "GameVersion" skuversion.txt | cut -d'=' -f2 | sed -e 's/\x0d/ /g' | sed -e 's/ //g'`
ll=${#PATCHFROMVER}
hl=$((ll-2))
IMPORTANTNUMBER=`echo $PATCHFROMVER | cut -c${hl}-${ll}`

if [ "$IMPORTANTNUMBER" == "107" ]; then
IMPORTANTNUMBER="017"
fi

echo "Former version:"
echo $PATCHFROMVER
echo "${2}${IMPORTANTNUMBER}"

if [ "$PATCHFROMVER" == "${2}${IMPORTANTNUMBER}" ]; then
POL_SetupWindow_message "$1 $LNG_UPTODATE" "$TYTULS3"
return
fi

POL_SetupWindow_menu "$LNG_CHOOSEACTION" "Actions" "$LNG_PATCHM~$LNG_PATCHA" "~"

if [ "$APP_ANSWER" == "$LNG_PATCHM" ]; then
	POL_SetupWindow_browse "Select patch file" "$TYTULS3" ""
	PATCHFILE="$APP_ANSWER"

elif [ "$APP_ANSWER" == "$LNG_PATCHA" ]
then
	POL_SetupWindow_question "$LNG_PATCHVQ1\n${PATCHFROMVER}\n$LNG_PATCHVQ2\n${2}${IMPORTANTNUMBER}\n$LNG_PATCHVQ3" "$TYTULS3"
	if [ "$APP_ANSWER" == "FALSE" ] ;then
	return
	fi

	cd "$REPERTOIRE/ressources"
	#downloading patch
	if [ ! -e "Sims3_${2}${IMPORTANTNUMBER}_from_${PATCHFROMVER}.exe" ]; then
	POL_SetupWindow_download "$LNG_DOWNLOADING Sims3_${2}${IMPORTANTNUMBER}_from_${PATCHFROMVER}.exe" "Downloading patch" "http://na.llnet.eadownloads.ea.com/u/f/sims/sims3/patches/Sims3_${2}${IMPORTANTNUMBER}_from_${PATCHFROMVER}.exe"
	fi
	PATCHFILE="Sims3_${2}${IMPORTANTNUMBER}_from_${PATCHFROMVER}.exe"
fi
	POL_SetupWindow_wait_next_signal "$LNG_INSTINPROGRESS" "$TYTULS3"
	wine "$PATCHFILE"
	POL_SetupWindow_detect_exit
	POL_SetupWindow_message "$LNG_PATCHSUCCES" "$TYTULS3"

}

POL_SetupWindow_Init "" ""
POL_SetupWindow_free_presentation "The Sims 3 - Updates" "This installer will help you with\ninstallation of patches for The Sims 3 and its add-ons"

#checking if The Sims 3 is installed
if [ ! -e "$REPERTOIRE/configurations/installed/$TYTULS3" ]; then
POL_SetupWindow_message "Install $TYTULS3 before patching." "$TYTULS3"
POL_SetupWindow_Close
exit
fi

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

POL_SetupWindow_message "$TYTULS3 $LNG_DETECTED" "$TYTULS3" "$PLAYONLINUX/themes/tango/info.png"
patch_TheSims3 "$TYTULS3" "$PATCHVERSIONS3"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTULS3"

#cleaning temp
cd "$WINEPREFIX/drive_c/windows/temp/"
rm -rf *

#checking for EP01 (World Adventures)
if [ -e "$REPERTOIRE/configurations/installed/$TYTULEP01" ]; then
    Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTULEP01"
    cd "$WINEPREFIX/drive_c/windows/temp/"
    regedit /e ep01name.reg "HKEY_LOCAL_MACHINE\Software\Electronic Arts\Sims\The Sims 3 World Adventures"

    if [ -e "ep01name.reg" ]; then
        TYTULEP01=`cat ep01name.reg | grep "DisplayName" | cut -d'"' -f4 |tr -d '\231'`
        POL_SetupWindow_message "$TYTULEP01 $LNG_DETECTED" "$TYTULEP01" "$PLAYONLINUX/themes/tango/info.png"
        patch_TheSims3 "$TYTULEP01" "$PATCHVERSIONEP01"
    fi
fi

#checking for SP01 (High-End Loft Stuff)
if [ -e "$REPERTOIRE/configurations/installed/$TYTULSP01" ]; then
    Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTULSP01"
    cd "$WINEPREFIX/drive_c/windows/temp/"
    regedit /e sp01name.reg "HKEY_LOCAL_MACHINE\Software\Electronic Arts\Sims\The Sims 3 High-End Loft Stuff"

    if [ -e "sp01name.reg" ]; then
        TYTULSP01=`cat sp01name.reg | grep "DisplayName" | cut -d'"' -f4 |tr -d '\231'`
        POL_SetupWindow_message "$TYTULSP01 $LNG_DETECTED" "$TYTULSP01" "$PLAYONLINUX/themes/tango/info.png"
        patch_TheSims3 "$TYTULSP01" "$PATCHVERSIONSP01"
    fi
fi

POL_SetupWindow_message "$LNG_NOMOREADDONS" "$TYTULS3"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFsACgkQ5TH6yaoTykcQpQCdF0Cub3MwPpAc+o01DShHMuys
zbIAn1kdpQWq49H8tnbSj5DaxSVy/gvd
=DNY9
-----END PGP SIGNATURE-----
