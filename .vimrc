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
" ランチャー
NeoBundle 'Shougo/unite.vim'
" 最近開いたファイル
NeoBundle 'Shougo/neomru.vim'
" ヤンク履歴
NeoBundle 'Shougo/neoyank.vim'
" アウトラインの表示
NeoBundle 'Shougo/unite-outline'

" uniteの設定
" インサートモードで開始
let g:unite_enable_start_insert=1
" ウィンドウ分割ルール
let g:unite_split_rule = 'botright'
" prefix keyの設定
nmap <Space> [unite]

" スペースキーとaキーでカレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" スペースキーとfキーでバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
" スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
" スペースキーとbキーでバッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
" スペースキーとrキーでレジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
" スペースキーとtキーでタブを表示
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
" スペースキーとhキーでヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
 "スペースキーとoキーでoutline
nnoremap <silent> [unite]o :<C-u>Unite<Space>-vertical -winwidth=40 outline<CR>
" スペースキーとENTERキーでfile_rec:!
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
" unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

" gitコマンド実行
NeoBundle 'tpope/vim-fugitive.git'
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow
" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}

" gitの差分をエディタ上に表示
NeoBundle 'vim-gitgutter'
" コミットログ確認
NeoBundle 'gregsexton/gitv.git'

" ファイラ
NeoBundle 'scrooloose/nerdtree'

" カラースキーマ
NeoBundle 'nanotech/jellybeans.vim'
" カラースキーマの選択
NeoBundle 'ujihisa/unite-colorscheme'

" インデントガイド
NeoBundle 'nathanaelkane/vim-indent-guides'
" vim 起動時 vim-indent-guides を自動起動
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=2
" 自動カラー無効
let g:indent_guides_auto_colors=0
" set background=dark
" 奇数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=lightgray
" 偶数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray
" ガイドの幅
let g:indent_guides_guide_size = 1

" Ruby関連
" endを自動で挿入
NeoBundle 'tpope/vim-endwise'

" Rails関連
NeoBundle 'tpope/vim-rails'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" 行番号を表示
set number

" シンタックスハイライト
syntax on
" カラースキーマ
set t_Co=256
set background=dark
colorscheme jellybeans

" エンコード
set encoding=utf8
" ファイルエンコード
set fileencoding=utf-8
" スクロールする時に下が見えるようにする
set scrolloff=5
" .swapファイルを作らない
set noswapfile
" バックアップファイルを作らない
set nowritebackup
" バックアップをしない
set nobackup
" バックスペースで各種消せるようにする
set backspace=indent,eol,start
" ビープ音を消す
set vb t_vb=
set novisualbell

" OSのクリップボードを使う
set clipboard=unnamed,autoselect
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" タブ文字の表示幅
set tabstop=2
" Vimが挿入するインデントの幅
set shiftwidth=2
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab

