#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Indiana Jones and the Fate of Atlantis"
PREFIX="IndianaJonesAtlantis"
EDITOR="LucasArts"
 
export WINEDEBUG="-all"
  
#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "" "Tinou" "$PREFIX"
  
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "INSTALL.EXE"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_SetupWindow_prefixcreate "1.4-dos_support_0.5"
  
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$CDROM/INSTALL.EXE"
  
POL_Shortcut "ATLANTIS.EXE" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/PwfUACgkQ5TH6yaoTykdMuwCgh+s2/+ibubozMKNfJH8Rs8cW
1XcAn34ieBPnfX3iU+BOIF07yZJOMLIz
=VAR/
-----END PGP SIGNATURE-----
