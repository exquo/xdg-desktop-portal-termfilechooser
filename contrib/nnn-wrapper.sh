#!/bin/sh

# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.

set -eu

. "${0%/*}/common.sh"  # source common functions
# See `common.sh` for definitions of variables ($out, $path, …).

cmd="nnn -S -s xdg-portal-filechooser"
	# -S [-s <session_file_name>] saves the last visited dir location and opens it on next startup
termcmd=$(default_termcmd)

# See also: https://github.com/jarun/nnn/wiki/Basic-use-cases#file-picker

# nnn has no equivalent of ranger's:
	# `--cmd`
		# .. and no other way to show a message text on startup. So, no way to show instructions in nnn itself, like it is done in ranger-wrapper.
		# nnn also does not show previews (needs a plugin and a keypress). So, the save instructions in `$path` file are not shown automatically.
	# `--show-only-dirs`
	# `--choosedir`
		# Navigating to a dir and quitting nnn would not write it to the selection file. To select a dir, use <Space> on a dir name, then quit nnn.
		# Although it might be possible to write a script using https://github.com/jarun/nnn/wiki/Basic-use-cases#configure-cd-on-quit
	# However it might be possible to implement all of the above with a plugin for nnn.

if [ "$save" = "1" ]; then
	create_save_file "$path" "$out"
	set -- -p "$out" "$path"
else
	set -- -p "$out"
fi

$termcmd $cmd "$@"
