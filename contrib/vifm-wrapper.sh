#!/bin/sh

# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.

set -eu

. "${0%/*}/common.sh"  # source common functions
# See `common.sh` for definitions of variables ($out, $path, …).

cmd=vifm
termcmd=$(default_termcmd)

if [ "$save" = "1" ]; then
	create_save_file "$path" "$out"
	set -- --choose-files "$out" -c "set statusline='Select save path (see tutorial in preview pane; try pressing <w> key if no preview)'" --select "$path"
elif [ "$directory" = "1" ]; then
	set -- --choose-dir "$out" -c "set statusline='Select directory (quit in dir to select it)'"
elif [ "$multiple" = "1" ]; then
	set -- --choose-files "$out" -c "set statusline='Select file(s) (press <t> key to select multiple)'"
else
	set -- --choose-files "$out" -c "set statusline='Select file (open file to select it)'"
fi

$termcmd $cmd "$@"
