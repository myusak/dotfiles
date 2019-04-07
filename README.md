## How to install
Run ``./init`` and the dotfiles in this directory are symlinked to the home directory.

### nvim
Install via ``appimage`` if your system package repository does not have nvim.

It requires ``python`` > 3.6.
Use ``pyenv`` if the system has an older version.

### tmux
``tpm`` (tmux plugin manager) will be installed into ``$HOME/.tmux/plugins`` at the time that ``./init`` is executed.
Then reload ``.tmux.conf`` (``bind + shift + I`` in tmux) and the plugins specified in ``.tmux.conf`` will be installed.

#### copy in tmux
By dragging with pressing ``shift`` (Ubuntu) or ``option`` (macOS), you can select texts in your system (not in tmux).

## miscellaneous
- https://github.com/powerline/fonts
