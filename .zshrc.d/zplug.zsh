if [ ! -d ~/.zplug ]; then
	curl -sL zplug.sh/installer | zsh
	return
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug"

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2 # for delayed loading
zplug "zsh-users/zsh-completions"
zplug "olivierverdier/zsh-git-prompt", use:zshrc.sh

zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux, rename-to:fzf-tmux

zplug "b4b4r07/enhancd", use:init.sh
zplug "mollifier/cd-gitroot"

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

for rcfile in ~/.zshrc.d/zplug/*.zsh; do
	source $rcfile
done

zplug load --verbose
