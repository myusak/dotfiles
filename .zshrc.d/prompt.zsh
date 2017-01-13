# %n: user name
# %m: hostname
# %W: date (mm/dd/yy)
# %*: time (hh:mm:ss)
# %~: current directory
# %#: user type (root: #, other: %)
function zle-line-init zle-keymap-select {
	case $KEYMAP in
		vicmd)
			mode="%F{cyan}NOR%f"
		;;
		main|viins)
			mode="%F{green}INS%f"
		;;
	esac

	if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
		host="%F{yellow}%m%f"
	else
		host="%F{cyan}%m%f"
	fi

	if [ ! -z "$VIRTUAL_ENV" ]; then
		venv=" ($(basename $VIRTUAL_ENV))"
	else
		venv=""
	fi

	PROMPT="
<$mode> (%D %*) <%?> [%~]
$host$venv %# "

	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

REPORTTIME=1
KEYTIMEOUT=1 # times out multi-char key combos as fast as possible. (1/100th of a second.)

