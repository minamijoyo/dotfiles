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

" 色情報が入ったファイルを開いた場合は表示を色付けする
NeoBundle 'vim-scripts/AnsiEsc.vim'

" 行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

" インデントガイド
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_color_term = 239
let g:indentLine_char = '│'

" 補完
NeoBundle 'Shougo/neocomplete'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

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
" 行列番号を表示する
set ruler

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
" タブ入力を複数の空白入力に置き換える
set expandtab
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab

" 不可視文字を表示する
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgrey
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

" 対応括弧をハイライト表示する
set showmatch
" 小文字の検索でも大文字も見つかるようにする
set ignorecase
" 検索結果をハイライト表示する
set hlsearch
" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 保存されていないファイルがあるときでも別のファイルを開けるようにする
set hidden
" w!! でsudoして保存
cmap w!! w !sudo tee > /dev/null %

