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
" Unite
NeoBundle 'Shougo/unite.vim'
" 最近開いたファイル
NeoBundle 'Shougo/neomru.vim'
" ヤンク履歴
NeoBundle 'Shougo/neoyank.vim'
" アウトラインの表示
NeoBundle 'Shougo/unite-outline'
" git連携
NeoBundle 'kmnk/vim-unite-giti'
" 検索にagを使う
NeoBundle 'rking/ag.vim'
let g:ag_prg="ag --vimgrep --hidden"

" uniteの設定
" インサートモードで開始
let g:unite_enable_start_insert=1
" ウィンドウ分割ルール
let g:unite_split_rule = 'botright'
" prefix keyの設定
nnoremap [unite] <Nop>
nmap <Space>b [unite]

" カレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" バッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
" 最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
" バッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
" レジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
" タブを表示
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
" ヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
 "outlineを表示
nnoremap <silent> [unite]o :<C-u>Unite<Space>-vertical -winwidth=40 outline<CR>
" カレントディレクトリでファイル名を再帰検索
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
" unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

" gitコマンド実行
NeoBundle 'tpope/vim-fugitive.git'
nnoremap [fugitive] <Nop>
nmap <Space>g [fugitive]
nnoremap [fugitive]d :<C-u>Gdiff<Enter>
nnoremap [fugitive]g :<C-u>Gstatus<Enter>
nnoremap [fugitive]l :<C-u>Glog<Enter>
nnoremap [fugitive]c :<C-u>Gcommit -v<Enter>
nnoremap [fugitive]a :<C-u>Gcommit -v --amend<Enter>
nnoremap [fugitive]b :<C-u>Gblame<Enter>

" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow

" gitの差分をエディタ上に表示
NeoBundle 'vim-gitgutter'
" コミットログ確認
NeoBundle 'gregsexton/gitv.git'
" githubを開く
NeoBundle 'tonchis/vim-to-github'

" セッション保存
NeoBundle 'tpope/vim-obsession'

" ファイラ
NeoBundle 'scrooloose/nerdtree'
nnoremap [nerdtree] <Nop>
nmap <Space>n [nerdtree]
nnoremap <silent>[nerdtree]n :NERDTreeToggle<CR>
nnoremap <silent>[nerdtree]r :NERDTree<CR>
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1

" PowerLine
NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'Lokaltog/powerline-fontpatcher'
let g:Powerline_symbols = 'fancy'
set laststatus=2

" カラースキーマ
NeoBundle 'nanotech/jellybeans.vim'
" カラースキーマの選択
NeoBundle 'ujihisa/unite-colorscheme'

" 色情報が入ったファイルを開いた場合は表示を色付けする
NeoBundle 'vim-scripts/AnsiEsc.vim'

" 行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

" インデントガイド
NeoBundle 'nathanaelkane/vim-indent-guides'
" vim 起動時 vim-indent-guides を自動起動
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=2
" 自動カラー無効
let g:indent_guides_auto_colors=0
" ガイドを無効化するファイルタイプ
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']
" 奇数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=235
" 偶数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=237
" ガイドの幅
let g:indent_guides_guide_size = 1

" 補完
NeoBundle 'Shougo/neocomplete'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" コメントアウト
NeoBundle "tyru/caw.vim.git"
nnoremap [caw] <Nop>
nmap <Space>c [caw]
vmap <Space>c [caw]
nmap [caw] <Plug>(caw:i:toggle)
vmap [caw] <Plug>(caw:i:toggle)

" 括弧の操作
NeoBundle 'tpope/vim-surround'

" シンタックスチェク
NeoBundle 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" Ruby関連
" endを自動で挿入
NeoBundle 'tpope/vim-endwise'
" rubyのブロックをテキストオブジェクトとして扱えるようにする
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'rhysd/vim-textobj-ruby'

" Rails関連
NeoBundle 'tpope/vim-rails'

" js関連
NeoBundle 'kchmck/vim-coffee-script'

" メモ帳
NeoBundle 'glidenote/memolist.vim'
let g:memolist_path = "~/Dropbox/work/memo"
let g:memolist_memo_suffix = "md"
let g:memolist_unite = 1
let g:memolist_unite_option = "-auto-preview"
nnoremap [memo] <Nop>
nmap <Space>m [memo]
nnoremap <silent>[memo]m :MemoNew<CR>
nnoremap <silent>[memo]l :MemoList<CR>
nnoremap <silent>[memo]g :MemoGrep<CR>

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

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
" バックスペースで各種消せるようにする
set backspace=indent,eol,start
" ビープ音を消す
set vb t_vb=
set novisualbell
" マウス操作を有効にする
set mouse=a
" 端末224桁制限を超えて画面の右端でもマウスが使えるようにする
set ttymouse=sgr
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

" カレント行をハイライト
set cursorline
" カレント行にアンダーラインを引く
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
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
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

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

" Ctrl + hjklだけでウィンドウ移動できるようにする
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" バッファの移動
nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bb :b#<CR>

" Ctrl + 左右キーでタブローテーション
nnoremap <c-Left> gT
nnoremap <c-Right> gt

" ノーマルモードのままで空行を挿入する
nnoremap <Space><CR> :<C-u>call append(expand('.'), '')<Cr>j
" ノーマルモードに戻る待ち時間を減らすためESCキーのタイムアウトを短くする
set timeout timeoutlen=1000 ttimeoutlen=50

" 保存されていないファイルがあるときでも別のファイルを開けるようにする
set hidden
" w!! でsudoして保存
cmap w!! w !sudo tee > /dev/null %
" q!!ですべて廃棄して終了
cmap q!! qall!

" uniteのfile_recの検索対象から画像ファイルを無視する
let s:unite_ignore_patterns='\.\(gif\|jpe\?g\|png\)$'
call unite#custom#source('file_rec', 'ignore_pattern', s:unite_ignore_patterns)

