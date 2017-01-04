if zplug check olivierverdier/zsh-git-prompt; then
	RPROMPT='$(git_super_status)'
fi

