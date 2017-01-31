. ~/.zshrc.d/env.zsh
. ~/.zshrc.d/alias.zsh
. ~/.zshrc.d/opt.zsh
. ~/.zshrc.d/bin.zsh
. ~/.zshrc.d/prompt.zsh
. ~/.zshrc.d/settings.zsh
. ~/.zshrc.d/zplug.zsh

. ~/.zshrc.d/local/linux.zsh
. ~/.zshrc.d/local/macos.zsh

if [[ -e ~/.zshrc.local ]]; then
	. ~/.zshrc.local # local rc will override configurations
fi

