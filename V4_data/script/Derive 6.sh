#!/bin/bash
# Date : (21/05/10)
# Wine version used : 1.1.44
# Author : Fekir
# Version : 1.2

 [ "$PLAYONLINUX" = "" ] && exit 0
 
source "$PLAYONLINUX/lib/sources"

NAME="Derive 6" 
PREFIX="Derive6"
#WINE="1.1.44"
MATH="\n\n- Maxima (http://maxima.sourceforge.net/) \n\n- Octave (http://www.gnu.org/software/octave/)\n\n- Scilab (www.scilab.org)"

POL_SetupWindow_Init


if [ "$POL_LANG" == "it" ]; then
	TITLE="Alternative a Derive6"
	PRESENTATION="Considera le alternative OpenSource che esistono nativamente per Gnu/Linux come ad esempio $MATH \n\nprima di installare $NAME attraverso Wine."
	EXECUTE="Per favore, seleziona il file d'installazione." 
	INSTALLATION="Sto installando $NAME ..."
	POLEND="$NAME è stato installato con successo"
else
	TITLE="Alternatives to Derive6"
	PRESENTATION="Please consider some OpenSource alternative programs that runs natively on Linux, as for example $MATH \n\nbefor installing $NAME through Wine."
	INSTALLATION="Installing $NAME..."
	EXECUTE="Please select the .exe installation file."
	POLEND="$NAME has been installed succesfully"
fi
#--------PRESENTATION
POL_SetupWindow_presentation "$NAME" "Soft Wharehouse" "http://education.ti.com/" "Fekir and Tinou" "$PREFIX"
#--------EXECUTABLE
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX/"
POL_SetupWindow_prefixcreate
#--------INSTALLATION 
POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
POL_SetupWindow_improve_fonts
wine "$CDROM/setup.exe" 
POL_SetupWindow_detect_exit
#--------END
POL_SetupWindow_reboot 
POL_SetupWindow_auto_shortcut "$PREFIX" "Derive6.exe" "$NAME"
POL_SetupWindow_get_local_icon "Derive 6" "aa90_derive6.0.png" 
#Set_WineVersion_Assign "$WINE" "$NAME"

POL_SetupWindow_message "$POLEND" "$NAME" 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF0ACgkQ5TH6yaoTykcJfACfTVx7CQuUCjBG7SRaoVzqmE9w
UJEAn1MOlol7AZsLxyx3sbC9ke+jGi8n
=MbQS
-----END PGP SIGNATURE-----
