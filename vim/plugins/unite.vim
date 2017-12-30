" インサートモードで開始
let g:unite_enable_start_insert=1
" ウィンドウ分割ルール
let g:unite_split_rule = 'botright'
" uniteのfile_recの検索対象から画像ファイルを無視する
let s:unite_ignore_patterns='\.\(gif\|jpe\?g\|png\)$'
call unite#custom#source('file_rec', 'ignore_pattern', s:unite_ignore_patterns)

" prefix keyの設定
nnoremap [unite] <Nop>
nmap <Leader>b [unite]

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
