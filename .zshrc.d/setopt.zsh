setopt always_to_end
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_nodups
setopt hist_reduce_blanks
setopt inc_append_history # add history immediately
setopt no_flow_control
setopt share_history
setopt no_beep
setopt print_eight_bit
setopt list_packed
setopt auto_menu
setopt extended_glob
setopt magic_equal_subst
setopt long_list_jobs
setopt transient_rprompt

autoload -Uz select-word-style; select-word-style default

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

