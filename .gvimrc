colorscheme evening 

if has('win32')
  set guifont=Ricty:h14
elseif has('gui_macvim')
  set guifont=Osaka-mono:h16
elseif has('xfontset')
  set guifontset=a14,r14,k14
endif

" delete tool bar
set guioptions-=T
" delete menu bar
set guioptions-=m


if has('gui_macvim')
  gui 
  set transparency=40
elseif has('win32')
  gui
  set transparency=205
endif

" 右クリックメニューの文字化け対策
source $VIMRUNTIME/delmenu.vim
"set langmenu=ja_jp.utf-8
set langmenu=en_us.utf-8
source $VIMRUNTIME/menu.vim
