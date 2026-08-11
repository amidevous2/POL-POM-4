

#!/bin/bash
#
#  Filename: Pokemontcgo.pol
#
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#  For use with PlayOnLinux
#  <https://playonlinux.com/>
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Pokemon TCGO"
PREFIX="PokemonTCGO"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Pokemon TCGO" "http://pokemon.com/" "The Unity Wine Support Team" "$PREFIX"

# Create the prefix
POL_System_SetArch "AMD64"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.20"
POL_System_SetArch "AMD64"

# Install the fonts
POL_Wine_InstallFonts
POL_Call POL_Install_d3dx11
POL_Install_dotnet40

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

POL_System_TmpCreate "$PREFIX"

 

POL_System_TmpDelete


POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX4gEHgAKCRDlMfrJqhPK
RzcJAJ9uDBcss8oZOhKAPSnimJBHW0SYrACgsmCuqgcreom++RFvlqxX1nSeYJo=
=SVJE
-----END PGP SIGNATURE-----
