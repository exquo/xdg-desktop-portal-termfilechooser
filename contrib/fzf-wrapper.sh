#!/bin/sh

# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.

set -eu

. "${0%/*}/common.sh"  # source common functions
# See `common.sh` for definitions of variables ($out, $path, …).

termcmd=$(default_termcmd)

if [ "$save" = "1" ]; then
    cmd="dialog --yesno \"Save to \"$path\"?\" 0 0 && ( printf '%s' \"$path\" > $out ) || ( printf '%s' 'Input path to write to: ' && read input && printf '%s' \"\$input\" > $out)"
elif [ "$directory" = "1" ]; then
    cmd="fd -a --base-directory=$HOME -td | fzf +m --prompt 'Select directory > ' > $out"
elif [ "$multiple" = "1" ]; then
    cmd="fd -a --base-directory=$HOME | fzf -m --prompt 'Select files > ' > $out"
else
    cmd="fd -a --base-directory=$HOME | fzf +m --prompt 'Select file > ' > $out"
fi

$termcmd "$cmd"
