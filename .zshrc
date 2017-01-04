source ~/.zshrc.d/env.zsh
source ~/.zshrc.d/bindkey.zsh
source ~/.zshrc.d/alias.zsh
source ~/.zshrc.d/setopt.zsh
source ~/.zshrc.d/completion.zsh
source ~/.zshrc.d/bin.zsh
source ~/.zshrc.d/zplug.zsh
source ~/.zshrc.d/prompt.zsh
source ~/.zshrc.d/settings.zsh

source ~/.zshrc.d/local/linux.zsh
source ~/.zshrc.d/local/macos.zsh

if [[ -e ~/.zshrc.local ]]; then
	source ~/.zshrc.local # local rc will override configurations
fi

