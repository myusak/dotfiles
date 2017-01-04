function zle-line-init zle-keymap-select {
	case $KEYMAP in
		vicmd)
			mode="%F{cyan}NOR%f"
		;;
		main|viins)
			mode="%F{green}INS%f"
		;;
	esac

	# %n: user name
	# %m: hostname
	# %W: date (mm/dd/yy)
	# %*: time (hh:mm:ss)
	# %~: current directory
	# %#: user type (root: #, other: %)
	if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
		# if you are in a remote host, make host name yellow

		PROMPT="
<$mode> (%D %*) <%?> [%~]
%F{yellow}%m%f %# "

	else

		PROMPT="
<$mode> (%D %*) <%?> [%~]
%F{cyan}%m%f %# "

	fi

	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

REPORTTIME=1
KEYTIMEOUT=1 # times out multi-char key combos as fast as possible. (1/100th of a second.)

