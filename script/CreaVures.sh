#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
erreur "The server is overloaded. Please wait for a minut."
exit
	