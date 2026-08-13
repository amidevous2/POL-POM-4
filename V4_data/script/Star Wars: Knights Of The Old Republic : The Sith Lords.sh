#!/bin/bash
# Date : (2009-08-09 11-00)
# Last revision : (2010-04-05 15-00)
# Wine version used : 1.1.42
# Distribution used to test : Fedora 12
# Author : NSLW
# Licence : Retail
# Depend : unzip

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Star Wars Knights of the Old Republic II - The Sith Lords"
PREFIX="SWKotor2"
WORKINGWINEVERSION="1.1.42"

LNG_DOWNLOADING="PlayOnLinux is downloading"
LNG_INSTALLING="PlayOnLinux is installing"
LNG_INSTALLATIONINPROGRESS="Installation in progress..."
LNG_CLICKNEXT="Click NEXT when the installation will finish"
LNG_SUCCES="$TYTUL has been installed successfully."
LNG_PATCHSUCCES="Patch for $TYTUL has been installed successfully"
LNG_PATCHQ="It's recommended to patch the game. Do you want to do it now?"
LNG_PATCHM="Let me choose patch manually"
LNG_PATCHA="Download patch automatically"
LNG_GFXMEM="How much memory do your graphic card have got?"
LNG_CHOOSEACTION="What do you want to do?"
LNG_PATCH="Patch game"
LNG_CHOOSELANG="Please choose language of your SWKOTOR2."
LNG_INSTALLATIONSPACE="POL will copy all CD's into one directory\nand then it'll start installation.\nPlease be sure that you've got 6GB free space in your home directory.\nAfter installation your game will take only 3.5GB"

if [ "$POL_LANG" == "pl" ]; then
LNG_DOWNLOADING="PlayOnLinux pobiera"
LNG_INSTALLING="PlayOnLinux instaluje"
LNG_INSTINPROGRESS="Instalacja w trakcie..."
LNG_CLICKNEXT="Naciśnij DALEJ tylko wtedy gdy instalator zakończy."
LNG_SUCCES="$TYTUL został zainstalowany pomyślnie."
LNG_PATCHSUCCES="Łatka do $TYTUL została zainstalowana pomyślnie"
LNG_PATCHQ="Zalecane jest zainstalowanie łatki. Czy chcesz to zrobić teraz?"
LNG_PATCHM="Pozwól mi wybrać łatkę samodzielnie"
LNG_PATCHA="Pobierz łatkę automatycznie"
LNG_GFXMEM="Jak dużo pamięci ma twoja karta graficzna?"
LNG_CHOOSEACTION="Co chcesz zrobić?"
LNG_PATCH="Łataj grę"
LNG_CHOOSELANG="Wybierz język twojej gry SWKOTOR2."
LNG_INSTALLATIONSPACE="POL skopiuje wszystkie płyty CD do jednego folderu\npo tym rozpocznie instalację.\nUpewnij się, że masz 6GB wolnego miejsca w katalogu domowym.\nPo instalacji gra zajmie jedynie 3.5GB"

elif [ "$POL_LANG" == "de" ]; then
LNG_DOWNLOADING="PlayOnLinux ladet herunter"
LNG_INSTALLING="PlayOnLinux installiert"
LNG_INSTINPROGRESS="Es wird installiert..."
LNG_CLICKNEXT="Klicke WEITER wenn Installation vorbei ist."
LNG_SUCCES="$TYTUL ist erfolgreich installiert worden."
LNG_PATCHSUCCES="Patch für $TYTUL ist erfolgreich installiert worden."
LNG_PATCHQ="Es ist Willst du ein Patch einspielen?"
LNG_PATCHM="Lass mich Patch selbst aussuchen"
LNG_PATCHA="Lade Patch automatisch herunter"
LNG_GFXMEM="Wie viel Speicher hat deine Grafikkarte?"
LNG_CHOOSEACTION="Was willst du machen?"
LNG_PATCH="Patch einspielen"
LNG_UPDATEWINEVER="Aktualisiere Wine Version zu"
LNG_CHOOSELANG="Bitte whale die Sprache für deine SWKOTOR2."
LNG_INSTALLATIONSPACE="POL wird alle CD Platten in einem Heimatverzeichnis kopieren\ndanach Installation wird starten.\nSei sicher, dass du mindestens 6GB freien Speicher im Heimatverzeichnis hast.\nNach die Installation, das Spiel wird nur 3.5GB nehmen."

elif [ "$POL_LANG" == "fr" ]; then
LNG_CLICKNEXT="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera
terminée sous peine de devoir recommencer l'installation."
LNG_GFXMEM="La taille de votre mémoire graphique?"
LNG_PATCHSUCCES="Patch pour $TYTUL installé avec succès"
fi

#procedure for patching kotor
patch_kotor2()
{

POL_SetupWindow_menu "$LNG_CHOOSEACTION" "Actions" "$LNG_PATCHM~$LNG_PATCHA" "~"

if [ "$APP_ANSWER" == "$LNG_PATCHM" ]; then
    POL_SetupWindow_browse "Select patch file" "$TYTUL" ""
    POL_SetupWindow_wait_next_signal "$LNG_INSTALLATIONINPROGRESS" "$TYTUL"
    wine "$APP_ANSWER"
    POL_SetupWindow_detect_exit
    POL_SetupWindow_message "$LNG_PATCHSUCCES" "$TYTUL"
elif [ "$APP_ANSWER" == "$LNG_PATCHA" ]; then

	POL_SetupWindow_menu "$LNG_CHOOSELANG" "Languages" "english(UK)~english(US)~french~italian~german~spanish" "~"
	LANGUAGEVERSION=$APP_ANSWER
	if [ "$APP_ANSWER" == "english(UK)" ]; then
	LANGUAGEVERSIONSHRT="UK"
	elif [ "$APP_ANSWER" == "english(US)" ]; then
	LANGUAGEVERSIONSHRT="english"
	    cd "$REPERTOIRE/ressources"
            if [ ! -e "sw_pc_english_from200424_to210427.exe" ]; then
            POL_SetupWindow_download "$LNG_DOWNLOADING sw_pc_english_from200424_to210427.exe (ca. 12.5MB)" "$TYTUL" "ftp://ftp.lucasarts.com/patches/pc/sw_pc_english_from200424_to210427.exe"
            fi
            POL_SetupWindow_wait_next_signal "$LNG_INSTALLING sw_pc_english_from200424_to210427.exe" "$TYTUL"
            wine "sw_pc_english_from200424_to210427.exe"
            POL_SetupWindow_detect_exit
	    return
	elif [ "$APP_ANSWER" == "french" ]; then
	LANGUAGEVERSIONSHRT="FR"
	elif [ "$APP_ANSWER" == "italian" ]; then
	LANGUAGEVERSIONSHRT="IT"
	elif [ "$APP_ANSWER" == "german" ]; then
	LANGUAGEVERSIONSHRT="DE"
	elif [ "$APP_ANSWER" == "spanish" ]; then
	LANGUAGEVERSIONSHRT="SP"
	fi
	
    cd "$REPERTOIRE/ressources"
    
    #downloading KotOR2%20Patch%20v201420%20$LANG.exe
    if [ ! -e "KotOR2%20Patch%20v201420%20${LANGUAGEVERSIONSHRT}.exe" ]; then
    POL_SetupWindow_download "$LNG_DOWNLOADING KotOR2%20Patch%20v201420%20${LANGUAGEVERSIONSHRT}.exe (ca. 2.0MB)" "$TYTUL" "ftp://ftp.lucasarts.com/patches/pc/KotOR2%20Patch%20v201420%20${LANGUAGEVERSIONSHRT}.exe"
    fi
    
    POL_SetupWindow_wait_next_signal "$LNG_INSTALLING KotOR2%20Patch%20v201420%20${LANGUAGEVERSIONSHRT}.exe" "$TYTUL"
    wine "KotOR2%20Patch%20v201420%20${LANGUAGEVERSIONSHRT}.exe"
    POL_SetupWindow_detect_exit
    POL_SetupWindow_message "$LNG_PATCHSUCCES" "$TYTUL"
    

    #downloading sw_pc_$LANG_from201420_to211427.exe
    LANGUAGEVERSIONSHRT=`echo $LANGUAGEVERSIONSHRT | tr '[A-Z]' '[a-z]'`
    if [ ! -e "sw_pc_${LANGUAGEVERSIONSHRT}_from201420_to211427.exe" ]; then
    	POL_SetupWindow_download "$LNG_DOWNLOADING sw_pc_${LANGUAGEVERSIONSHRT}_from201420_to211427.exe (ca. 16.0MB)" "$TYTUL" "ftp://ftp.lucasarts.com/patches/pc/sw_pc_${LANGUAGEVERSIONSHRT}_from201420_to211427.exe"
    fi
    
    POL_SetupWindow_wait_next_signal "$LNG_INSTALLING sw_pc_${LANGUAGEVERSIONSHRT}_from201420_to211427.exe" "$TYTUL"
    wine "sw_pc_${LANGUAGEVERSIONSHRT}_from201420_to211427.exe"
    POL_SetupWindow_detect_exit
    POL_SetupWindow_message "$LNG_PATCHSUCCES" "$TYTUL"
fi
}

POL_SetupWindow_make_icon_for_shortcut()
{
#$1 - Application name
#$2 - Application directory name in $HOME/.local/share/applications/wine/Programs/
cd $HOME/.local/share/applications/wine/*
echo $(pwd)
cd "$2"
echo $(pwd)
temp=`cat " $1.desktop" | grep Icon` #uwaga

if [ "$temp" == "" ]; then
temp=`cat "$1.desktop" | grep Icon`
fi

echo "$temp"
IconName=${temp##*/}
convert "$HOME/.local/share/icons/$IconName" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

copy_cd()
{
POL_SetupWindow_message "Please insert $1 CD" "$TYTUL"
POL_SetupWindow_cdrom
POL_SetupWindow_wait_next_signal "Copying $1 CD" "$TYTUL"
cd "$WINEPREFIX/drive_c/windows/temp"
cd "$CDROM"
cp -fr * "$WINEPREFIX/drive_c/windows/temp/SWKOTOR2"
chmod 777 "$WINEPREFIX/drive_c/windows/temp/SWKOTOR2" -R
mv "$WINEPREFIX/drive_c/windows/temp/SWKOTOR2/autorun.inf" "$WINEPREFIX/drive_c/windows/temp/SWKOTOR2/autorun$2.inf"
cd "$WINEPREFIX/drive_c/windows/temp"
POL_SetupWindow_detect_exit
sleep 5
}

#starting the script
wget http://upload.wikimedia.org/wikipedia/en/9/9b/KOTOR_II.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_presentation "$TYTUL" "LucasArts" "N/A" "NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
#asking about patching
if [ -e "$REPERTOIRE/configurations/installed/$TYTUL" ]; then
POL_SetupWindow_menu "$LNG_CHOOSEACTION" "Actions" "$LNG_PATCH" "~"
if [ "$APP_ANSWER" == "$LNG_PATCH" ]; then
    POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
    Use_WineVersion "$WORKINGWINEVERSION"
    patch_kotor2
    Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL"
    Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL Configurator"
fi
POL_SetupWindow_Close
exit
fi

#downloading specific Wine
POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

#creating application's own prefix
POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

#making directory where all CD will be copied to
cd "$WINEPREFIX/drive_c/windows/temp"
mkdir "SWKOTOR2"

#warning about free available space
POL_SetupWindow_message "$LNG_INSTALLATIONSPACE" "Free space" "$PLAYONLINUX/themes/tango/warning.png"

#copying all CD's into one directory
copy_cd "first" "1"
copy_cd "second" "2"
copy_cd "third" "3"
copy_cd "fourth" "4"

#making SWKOTOR2 an CDROM to winecfg
CDROM="$WINEPREFIX/drive_c/windows/temp/SWKOTOR2"

#reanming autorun1.inf to autorun.inf so installer will not ask about Play disk at the end
cd "$WINEPREFIX/drive_c/windows/temp/SWKOTOR2"
cp autorun1.inf autorun.inf

cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" e:

cd "$WINEPREFIX/drive_c/windows/temp/" 
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
sleep 5

#starting installation
POL_SetupWindow_message "Installer will start now.\nPlease don't install DirectX at the end of installation." "DirectX at the end" "$PLAYONLINUX/themes/tango/info.png"
wine start /unix "$CDROM/setup.exe"
POL_SetupWindow_message "$LNG_CLICKNEXT" "$TYTUL"
wine eject
 
#asking about memory size of graphic card
POL_SetupWindow_menu_list "$LNG_GFXMEM" "$TYTUL" "32-64-128-256-320-384-512-640-768-896-1024-1792-2048" "-" "64"
VMS="$APP_ANSWER"
 
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg

Set_Managed "Off"
Set_DXGrab "Off"
Set_Desktop "On" "1920" "1440"

#setting decorated to N
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver]" > decorated.reg
echo "\"Decorated\"=\"N\"" >> decorated.reg
regedit decorated.reg

#disable systray
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver]" > override.reg
echo "\"ShowSystray\"=\"false\"" >> override.reg
regedit override.reg

POL_SetupWindow_question "Do you want to install tool helping you to set\nwidescreen resolutions for the game?" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ]; then
    cd "$REPERTOIRE/ressources"
    if [ ! -e "uniws.zip" ]; then
    	POL_SetupWindow_download "$LNG_DOWNLOADING UniWS" "$TYTUL" "http://www.widescreengamingforum.com/downloads/uniws.zip"
    fi
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/LucasArts/SWKotOR2"
    unzip "$REPERTOIRE/ressources/uniws.zip"
    POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/LucasArts/SWKotOR2" "uniws.exe" "" "Universal Widescreen Patcher for SWKOTOR2"
    Set_WineVersion_Assign "$WORKINGWINEVERSION" "Universal Widescreen Patcher for SWKOTOR2"
fi

#cleaning temp
cd "$WINEPREFIX/drive_c/windows/temp/"
rm -rf *

#making shortcut
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/LucasArts/SWKotOR2" "swkotor2.exe" "SWKotor2.xpm" "$TYTUL"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL"
POL_SetupWindow_make_icon_for_shortcut "$TYTUL" "LucasArts/Star Wars Knights of the Old Republic II - The Sith Lords"

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/LucasArts/SWKotOR2" "swconfig.exe" "SWKotor_Config.xpm" "$TYTUL Configurator"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL Configurator"
cp "$REPERTOIRE/icones/32/$TYTUL" "$REPERTOIRE/icones/32/$TYTUL Configurator"

POL_SetupWindow_message "$LNG_SUCCES" "$TYTUL"
POL_SetupWindow_reboot

#disabling hardware mouse
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/LucasArts/SWKotOR2"
echo "[config]
firstrun=1
[Graphics Options]
EnableHardwareMouse=0" >& swkotor2.ini
 
#asking about patching
POL_SetupWindow_question "$LNG_PATCHQ" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ]; then
patch_kotor2
fi

POL_SetupWindow_message "Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff." "Note about copy protection" "$PLAYONLINUX/themes/tango/warning.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJD8ACgkQ5TH6yaoTykc/JwCeOnPB9kxicCBUfQqnTl8Qi3M1
YikAnRPTadNnemBume8PxAuPDvmib67k
=GINs
-----END PGP SIGNATURE-----
