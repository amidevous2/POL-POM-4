#!/bin/bash
# Last revision : (2012-10-18 19:17)
# Creator: petch

# Download v. 0.1
cd "$POL_USER_ROOT/tmp"
POL_Download "https://linuxtrack-wine.googlecode.com/files/linuxtrack-wine-0.1-bin.tar.gz" "9bbc7b93c060bb0952863d53043c888b"

POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing Linuxtrack-wine DLL...')" "$TITLE"
tar xzvf linuxtrack-wine-0.1-bin.tar.gz
cd linuxtrack-wine-0.1-bin
./install-bin

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlCAQlgACgkQ5TH6yaoTykcOJACfei9VaBeltj9yCVP0kjLRSs52
8qgAniAAMxfos0HQkgBwjBM5z+gYvrCt
=ZH7d
-----END PGP SIGNATURE-----
