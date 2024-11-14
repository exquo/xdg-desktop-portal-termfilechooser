#!/bin/sh

set -eu

# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.

. "${0%/*}/common.sh"  # source common functions
# See `common.sh` for definitions of variables ($out, $path, …).

cmd=ranger
termcmd=$(default_termcmd)

if [ "$save" = "1" ]; then
	create_save_file "$path" "$out"
	set -- --choosefile="$out" --cmd="echo Select save path (see tutorial in preview pane; try pressing zv or zp if no preview)" --selectfile="$path"
elif [ "$directory" = "1" ]; then
	set -- --choosedir="$out" --show-only-dirs --cmd="echo Select directory (quit in dir to select it)"
elif [ "$multiple" = "1" ]; then
	set -- --choosefiles="$out" --cmd="echo Select file(s) (open file to select it; <Space> to select multiple)"
else
	set -- --choosefile="$out" --cmd="echo Select file (open file to select it)"
fi

$termcmd $cmd "$@"
