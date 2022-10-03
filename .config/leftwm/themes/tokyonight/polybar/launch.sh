#!/usr/bin/env bash
dir="$HOME/.dotfiles/.config/leftwm/themes/tokyonight/polybar/forest/config.ini"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
	# Terminate already running bar instances
	pkill polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
    polybar -q main -c "$dir" &	
}

launch_bar

