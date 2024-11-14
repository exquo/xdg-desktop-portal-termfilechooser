#!/bin/sh

# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.

set -eu

. "${0%/*}/common.sh"  # source common functions
# See `common.sh` for definitions of variables ($out, $path, …).

cmd=yazi
termcmd=$(default_termcmd)

if [ "$save" = "1" ]; then
	create_save_file "$path" "$out"
	set -- --chooser-file="$out" "$path"
elif [ "$directory" = "1" ]; then
	set -- --chooser-file="$out" --cwd-file="$out"
	# Returns either the dir explicitly selected (with e.g. <Enter>), or the last dir yazi was in before exiting.
else
	set -- --chooser-file="$out"
fi

$termcmd $cmd "$@"
