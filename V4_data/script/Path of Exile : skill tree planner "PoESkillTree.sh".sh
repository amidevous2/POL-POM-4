#!/usr/bin/env playonlinux-bash
# Date : (2016-11-11 14-10)
# Last revision : (2016-11-11 14-10)
# Wine version used : 1.9.22
# Distribution used to test : Ubuntu 16.10
# Author : FatalBaboon

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="PoESkillTree"
PREFIX="poeskilltree"

POL_SetupWindow_Init

# Have not tested it with earlier versions, and thus cannot guarantee that it would work.
POL_RequiredVersion 4.2.10 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"

POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "EmmitJ" "https://github.com/EmmittJ/PoESkillTree" "FatalBaboon" "$PREFIX"

# Not sure that's the correct way to go,
# but I think using POL_Function_RootCommand would make this script Ubuntu-specific
# which I would prefer to avoid.
POL_SetupWindow_message "Please ensure winbind is installed.\n\nOn Ubuntu, 'sudo apt-get install winbind' should do the trick." "$TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "1.9.22"

# That is not working as advertised in http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_11:_List_of_Functions#Set_OS_.284.0.2B.29
# as it actually set Windows 2003 instead of Windows XP.
# I had to set this up manually via wine config after the script.
Set_OS "winxp"
Set_Desktop "On" "1024" "768"

POL_SetupWindow_wait "Please wait" "Requirements installation in progress"

# Please note that due to:
# - https://www.playonlinux.com/en/issue-5329.html
# - https://www.playonlinux.com/en/app-523-POL_Install_msxml3.html
# Installing dotnet45 will not work as POL_Install_dotnet45 is broken.
# I used:
# /usr/share/playonlinux/playonlinux-bash POESkillTree.sh
# and issued a Ctrl-C to terminate the infinite loop of:
# Are you sure you want to delete the registry key 'HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v3.5'? (Yes|No)
# Are you sure you want to delete the registry key 'HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v3.5'? (Yes|No)
# ...
POL_Call POL_Install_dotnet45
POL_Wine_reboot
POL_Call POL_Install_msxml6
POL_Call POL_Install_msvc100
POL_Call POL_Install_mono210
POL_Wine_reboot

POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
POESKILLTREE_EXE_PATH="$APP_ANSWER"

POL_SetupWindow_wait "Please wait" "Installation in progress"
POL_Wine "$POESKILLTREE_EXE_PATH"

POL_Shortcut "PoESkillTree.exe" "$TITLE"

POL_SetupWindow_Close
exit

# I actually tested it and it works, with the corrections I added as comments.

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNW3eQAKCRDlMfrJqhPK
Ry8iAJ9EoFV3roTRd7d/GSPIDzjl9/0ikACgod1tNjIvN0mi0jkIx6aYe4cPVCU=
=oda1
-----END PGP SIGNATURE-----
