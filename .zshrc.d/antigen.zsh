if [ -e ~/.antigen ];
then
	source ~/.antigen/antigen.zsh

	antigen bundle zsh-users/zsh-syntax-highlighting
	antigen bundle zsh-users/zsh-completions

	antigen apply
fi

