" Leaderをスペースにする
let mapleader = "\<Space>"

" runtimepathにカスタマイズ用の設定ディレクトリを追加
set runtimepath+=$HOME/.vim/after/

""""""""""""""""""""""""""""""""""""""""
" dein
""""""""""""""""""""""""""""""""""""""""
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

""""""""""""""""""""""""""""""""""""""""
" 基本設定
""""""""""""""""""""""""""""""""""""""""
" 行番号を表示
set number
" 行列番号を表示する
set ruler
" 入力中のコマンドを表示する
set showcmd
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
" 新しいウィンドウを下に開く
set splitbelow
" 新しいウィンドウを右に開く
set splitright
" .swapファイルを作らない
set noswapfile
" バックアップファイルを作らない
set nowritebackup
" バックアップをしない
set nobackup
" 編集中のファイルが変更されたら自動で読み直す
set autoread
set updatetime=1000
autocmd CursorHold,CursorHoldI * checktime
" バックスペースで各種消せるようにする
set backspace=indent,eol,start
" ビープ音を消す
set vb t_vb=
set novisualbell
" マウス操作を有効にする
set mouse=a
" 端末224桁制限を超えて画面の右端でもマウスが使えるようにする
if !has('nvim')
  " neovimではデフォルトでマウスサポートしているので不要
  set ttymouse=sgr
endif
" OSのクリップボードを使う
set clipboard=unnamed
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
set listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

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

" カレント行ハイライトが重いときがあるので欲しいときだけトグルで有効化する
nnoremap <Leader>l :set cursorline! cursorcolumn!<CR>
" カレント行にアンダーラインを引く
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" Copilotの補完が見づらいので色を調整
highlight CopilotSuggestion ctermfg=96
" 対応括弧をハイライト表示する
set showmatch
" 小文字の検索でも大文字も見つかるようにする
set ignorecase
" 検索結果をハイライト表示する
set hlsearch
" 検索結果のハイライトが重いときがあるので欲しいときだけトグルで有効化する
nnoremap <Leader>L :set hlsearch!<CR>
" スペルチェックから日本語を除外
" スペルチェックはファイルタイプごとに設定するのでここでは有効化しない
set spelllang=en,cjk

" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
" ファイルタイプごとの単語の定義のカスタマイズ
autocmd BufRead,BufNewFile *.rb set iskeyword+=?,!

" 拡張正規表現をデフォルトにする
nnoremap / /\v
nnoremap ? ?\v

" 表示行単位で上下移動するようにする
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
" 行単位で移動したいときのために入れ替える
nnoremap gj j
nnoremap gk k

" 行頭の左と行末の右で前後の行に移動できるようにする
set whichwrap=b,s,h,l,<,>,[,],~

" Ctrl + hjklだけでウィンドウ移動できるようにする
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" バッファの移動
nnoremap sbp :bprevious<CR>
nnoremap sbn :bnext<CR>
nnoremap sbb :b#<CR>

" ロケーションリストの移動
nnoremap slp :lprevious<CR>
nnoremap sln :lnext<CR>
nnoremap sll :lnext<CR>

" QuickFixの移動
nnoremap scp :cprevious<CR>
nnoremap scn :cnext<CR>
nnoremap scc :cnext<CR>

" Ctrl + 左右キーでタブローテーション
nnoremap <c-Left> gT
nnoremap <c-Right> gt

" ノーマルモードのままで空行を挿入する
nnoremap <Leader><CR> :<C-u>call append(expand('.'), '')<Cr>j
" ノーマルモードに戻る待ち時間を減らすためESCキーのタイムアウトを短くする
set timeout timeoutlen=1000
" 日本語入力がたまに制御コードと認識されてしまうので、端末のキーコードについてタイムアウトする
set ttimeout
set ttimeoutlen=50

" コピペで連続ペーストできるようにする
vnoremap gp "0p
vnoremap gdd "_dd

" 保存されていないファイルがあるときでも別のファイルを開けるようにする
set hidden
" w!! でsudoして保存
cmap w!! w !sudo tee > /dev/null %
" q!!ですべて廃棄して終了
cmap q!! qall!
" Ctrl + q で保存済みのバッファをすべて閉じる
nnoremap <c-q> :qall<CR>
