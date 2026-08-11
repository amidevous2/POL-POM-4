#!/bin/bash
# Date : (2016-03-24 21-00)
# Last revision : (2013-08-24 19-14)
# Wine version used : 1.6.2-dos_support_0.6
# Distribution used to test : Linux Mint 17.3 Rosa
# PlayOnLinux: 4.2.2
# Author : GNU32
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Turrican II - The Final Fight"
PREFIX="TurricanII"
WINEVERSION="1.6.2-dos_support_0.6"
AUTHOR="GNU32"
GAME_URL="http://www.abandonware-utopia.com/abandonware-telecharger-118-Turrican_II_The_Final_Fight.htm"
GAME_EDITOR="Rainbow Arts"
 
if [ "$POL_LANG" == "fr" ]; then
    LNG_INSTALL_INFO1="a été installé avec succès."
    LNG_INSTALL_INFO2="Il suffit d'appuyer sur la touche "Entrée" après chaque lancement pour pouvoir démarrer le jeu."
    LNG_INSTALL_INFO3="Bon jeu à tous."
    LNG_INSTALL_INFO4="Pour le bon déroulement de l'installation veuillez laissez les options proposées par défaut."
else
    LNG_INSTALL_INFO1="has been installed successfully."
    LNG_INSTALL_INFO2="Just press the "Enter" key after each launch to be able to start the game."
    LNG_INSTALL_INFO3="Good luck with the game."
    LNG_INSTALL_INFO4="For the proper functioning of the installation please leave the default options."
fi
 
POL_SetupWindow_Init
POL_Debug_Init
 
# Présentation
POL_SetupWindow_presentation \
    "${TITLE}" \
    "${GAME_EDITOR}" \
    "${GAME_URL}" \
    "${AUTHOR}" \
    "${PREFIX}"
 
# Creation du Préfixe
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "${PREFIX}"
POL_Wine_PrefixCreate "${WINEVERSION}"
 
# Dosbox config
cat <<_EOF_ > "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
sdl_fullscreen=true
sdl_fulldouble=true
sdl_fullresolution=original
sdl_windowresolution=original
sdl_output=overlay
sdl_autolock=true
sdl_sensitivity=100
sdl_waitonerror=true
sdl_priority="highest,highest"
sdl_mapperfile=mapper.txt
sdl_usescancodes=true
dosbox_language=
dosbox_machine=vga
dosbox_memsize=64
dosbox_captures=capture
render_frameskip=0
render_scaler=normal2x
render_aspect=true
cpu_core=auto
cpu_cycles=auto
cpu_cycleup=500
cpu_cycledown=20
mixer_nosound=false
mixer_rate=44100
mixer_blocksize=2048
mixer_prebuffer=10
midi_mpu401=intelligent
midi_device=default
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=1
sblaster_mixer=true
sblaster_oplrate=22050
sblaster_oplmode=auto
gus_gus=false
dos_keyboardlayout=FR
_EOF_
 
POL_SetupWindow_menu "Veuillez choisir votre mirroir de téléchargement" "Liste des mirroirs" "http://rares.abandons.org/|http://www.abandonware-utopia.com/" "|"
 
# Téléchargement
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
 
if [ "$APP_ANSWER" = "http://www.abandonware-utopia.com/" ]
then
    POL_Download "http://www.abandonware-utopia.com/pages/telechargement/jeux/Turrican%20II%20-%20The%20Final%20Fight.7z" "b8eb9636f7e2fd06da8932956c6eff7b"
    7z x "Turrican%20II%20-%20The%20Final%20Fight.7z" -o"$WINEPREFIX/drive_c"
    mv "$WINEPREFIX/drive_c/Turrican II - The Final Fight" "$WINEPREFIX/drive_c/turrican"
    cp -a "$WINEPREFIX/drive_c/turrican/CFG/ENGLISH.LNG" "$WINEPREFIX/drive_c/turrican/ENGLISH.LNG"
 
    if type -t POL_unbase64 > /dev/null; then
            POL_unbase64 <<-'_EOF_' > "$WINEPREFIX/drive_c/turrican/TURRICAN.CFG"
ICAgICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgID09PSBTVU4gUFJPSkVDVCBDT05GSUcgRklMRSBGT1IgVFVSUklDQU4gSUkgUEMgPT09DQogICAgICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMgU09VTkQgU0VUVVAgIyMjIyMjIyMjIw0KDQpDYXJkTmFtZT1DcmVhdGl2ZSBMYWJzIFNvdW5kQmxhc3RlciAgICANClNvdW5kRHJpdmVyPVNCLk1TRA0KUG9ydD01NDQNCkludGVycnVwdD03DQpETUFDaGFubmVsPTENClBsYXlpbmdGcmVxdWVuY3k9MjIwMDANCg0KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIFZJREVPIFNFVFVQICMjIyMjIyMjIyMNCg0KxMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTEDQohISEgV0FSTklORyA6IERPIE5PVCBNT0RJRlkgVEhFU0UgVkFMVUVTICAhISENCiEhISAgICAgICAgICAgWU9VIENBTiBEQU1BR0UgWU9VUiBNT05JVE9SICEhIQ0KxMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTEDQoNClZpZGVvTW9kZT02MA0KVmVydGljYWxUb3RhbD01MjcNClZlcnRpY2FsQ2VudGVyPTQ5MA0KSG9yaXpvbnRhbENlbnRlcj04NA0KDQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMgSU5QVVQgREVWSUNFIFNFVFVQICMjIw0KDQpJbnB1dERldmljZT0wDQpKb3lDYWwxPTANCkpveUNhbDI9MA0KSm95Q2FsMz0wDQpKb3lDYWw0PTANCg0KDQo=
    _EOF_
    fi
 
cat <<_EOF_ > "$WINEPREFIX/drive_c/autoexec.bat"
@echo off
keyb fr
cls
echo.-----------------------------------------------
echo                  Turrican II
echo          www.abandonware-utopia.com
echo.-----------------------------------------------
echo                  DOSBox v0.74
echo.-----------------------------------------------
echo   Commandes de base pour Dosbox :
echo   ALT  + ENTREE - MODE PLEIN ECRAN/FENETRE
echo   CTRL + F5     - CAPTURE D'ECRAN
echo   CTRL + F10    - CAPTURER/LIBERER LE CURSEUR
echo   CTRL + F12/11 - AUGMENTER/REDUIRE LA VITESSE
echo   CTRL + F9     - QUITER DOSBOX
echo.-----------------------------------------------
echo.  
echo.
pause
_EOF_
 
    POL_Shortcut "T2.EXE" "$TITLE"
 
elif [ "$APP_ANSWER" = "http://rares.abandons.org/" ]
then
    POL_Download "http://rares.abandons.org/fichiers/jeux/1994-1995/setup-00914-Turrican2-PCDOS.exe" "efefedc43294e123807ef642980e14b5"
    POL_SetupWindow_message "$LNG_INSTALL_INFO4" "$TITLE"
    POL_Wine "$POL_System_TmpDir/setup-00914-Turrican2-PCDOS.exe"
 
    if type -t POL_unbase64 > /dev/null; then
            POL_unbase64 <<-'_EOF_' > "$WINEPREFIX/drive_c/users/$USERNAME/Application Data/Abandonware-France/Turrican 2/C/TURRICAN.CFG/TURRICAN.CFG"
ICAgICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgID09PSBTVU4gUFJPSkVDVCBDT05GSUcgRklMRSBGT1IgVFVSUklDQU4gSUkgUEMgPT09DQogICAgICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMgU09VTkQgU0VUVVAgIyMjIyMjIyMjIw0KDQpDYXJkTmFtZT1DcmVhdGl2ZSBMYWJzIFNvdW5kQmxhc3RlciAgICANClNvdW5kRHJpdmVyPVNCLk1TRA0KUG9ydD01NDQNCkludGVycnVwdD03DQpETUFDaGFubmVsPTENClBsYXlpbmdGcmVxdWVuY3k9MjIwMDANCg0KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIFZJREVPIFNFVFVQICMjIyMjIyMjIyMNCg0KxMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTEDQohISEgV0FSTklORyA6IERPIE5PVCBNT0RJRlkgVEhFU0UgVkFMVUVTICAhISENCiEhISAgICAgICAgICAgWU9VIENBTiBEQU1BR0UgWU9VUiBNT05JVE9SICEhIQ0KxMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTEDQoNClZpZGVvTW9kZT02MA0KVmVydGljYWxUb3RhbD01MjcNClZlcnRpY2FsQ2VudGVyPTQ5MA0KSG9yaXpvbnRhbENlbnRlcj04NA0KDQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMgSU5QVVQgREVWSUNFIFNFVFVQICMjIw0KDQpJbnB1dERldmljZT0wDQpKb3lDYWwxPTANCkpveUNhbDI9MA0KSm95Q2FsMz0wDQpKb3lDYWw0PTANCg0KDQo=
    _EOF_
    fi
 
cat <<_EOF_ > "$WINEPREFIX/drive_c/autoexec.bat"
# Lines in this section will be run at startup.
# You can put your MOUNT lines here.
@echo off
keyb fr
mount -u c
mount c "$WINEPREFIX/drive_c/users/$USERNAME/Application Data/Abandonware-France/Turrican 2/C" -label harddisk
imgmount d "$WINEPREFIX/drive_c/users/$USERNAME/Application Data/Abandonware-France/Turrican 2/CD/Turric2.iso" -t iso -fs iso
cls
echo.-----------------------------------------------
echo                  Turrican II
echo.              Version CD anglaise                   
echo          www.abandonware-france.org       
echo.-----------------------------------------------
echo                  DOSBox v0.74
echo.-----------------------------------------------
echo   Commandes de base pour Dosbox :
echo   ALT  + ENTREE - MODE PLEIN ECRAN/FENETRE
echo   CTRL + F5     - CAPTURE D'ECRAN
echo   CTRL + F10    - CAPTURER/LIBERER LE CURSEUR
echo   CTRL + F12/11 - AUGMENTER/REDUIRE LA VITESSE
echo   CTRL + F9     - QUITER DOSBOX
echo.-----------------------------------------------
echo.  
echo.
pause
c:
t2
exit
_EOF_
    POL_Shortcut "Turrican2.bat" "$TITLE"
fi
 
POL_SetupWindow_message "$TITLE $LNG_INSTALL_INFO1\\n\\n\\n$LNG_INSTALL_INFO2\\n\\n$LNG_INSTALL_INFO3" "$TITLE"
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUSTYwAKCRDlMfrJqhPK
RzMnAJ4zZAn7bkwhA1K7MuCnnamY+f4R6QCfcPlAiYHOC9vs2NXdPzIagoObt28=
=d9/0
-----END PGP SIGNATURE-----
