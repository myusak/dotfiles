RPROMPT=""

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least
autoload -Uz colors


zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git

if is-at-least 4.3.10; then
	zstyle ':vcs_info:git:*' formats '(%s)-[%r/%b]' '%c%u %m'
	zstyle ':vcs_info:git:*' actionformats '(%s)-[%r/%b]' '%m' '<!%a>'
	zstyle ':vcs_info:git:*' check-for-changes true
	zstyle ':vcs_info:git:*' stagedstr ":staged"
	zstyle ':vcs_info:git:*' unstagedstr ":unstaged"
fi

if is-at-least 4.3.11; then
	zstyle ':vcs_info:git+set-message:*' hooks \
		git-hook-begin \
		git-untracked \
		git-push-status \
		git-nomerge-branch \
		git-stash-count

	function +vi-git-hook-begin() {
		if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
			return 1
		fi
		return 0
	}

	function +vi-git-untracked() {
		if [[ $1 != "1" ]]; then
			return 0
		fi

		if command git status --porcelain 2> /dev/null \
			| awk '{print $1}' \
			| command grep -F '??' > /dev/null 2>&1; then
				hook_com[unstaged]+=':untracked'
		fi
	}

	function +vi-git-push-status() {
		if [[ $1 != "1" ]]; then
			return 0
		fi

		local ahead
		ahead=$(command git rev-list origin/master..master 2> /dev/null \
			| wc -l \
			| tr -d ' ')

		if [[ "$ahead" -gt 0 ]]; then
			hook_com[misc]+="(${ahead} ahead)"
		fi
	}

	function +vi-git-nomerge-branch() {
		if [[ $1 != "1" ]]; then
			return 0
		fi

		if [[ "${hook_com[branch]}" == "master" ]]; then
			return 0
		fi

		local nomerged
		nomerged=$(command git rev-list master..${hook_com[branch]} 2> /dev/null | wc -l | tr -d ' ')

		if [[ "$nomerged" -gt 0 ]]; then
			hook_com[misc]+="(${nomerged} feature commit/s)"
		fi
	}

	function +vi-git-stash-count() {
		if [[ "$1" != "1" ]]; then
			return 0
		fi

		local stash
		stash=$(command git stash list 2> /dev/null | wc -l | tr -d ' ')
		if [[ "${stash}" -gt 0 ]]; then
			hook_com[misc]+="(${stash} stash/es)"
		fi
	}
fi

function _update_vcs_info_msg() {
	local -a messages
	local prompt

	LANG=en_US.UTF-8 vcs_info

	if [[ -z ${vcs_info_msg_0_} ]]; then
		prompt=""
	else
		[[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
		[[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
		[[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

		prompt="${(j: :)messages}"
	fi

	RPROMPT="$prompt"
}

add-zsh-hook precmd _update_vcs_info_msg

