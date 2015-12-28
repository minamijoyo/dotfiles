" NeoBundleの設定
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" プラグイン
" ファイル管理
NeoBundle 'Shougo/unite.vim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" 行番号を表示
set number

