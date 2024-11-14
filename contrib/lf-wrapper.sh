#!/bin/sh

# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.

set -eu

. "${0%/*}/common.sh"  # source common functions
# See `common.sh` for definitions of variables ($out, $path, …).

cmd=lf
termcmd=$(default_termcmd)

if [ "$save" = "1" ]; then
	create_save_file "$path" "$out"
	set -- -selection-path "$out" "$path"
else
	set -- -selection-path "$out"
fi

$termcmd $cmd "$@"
