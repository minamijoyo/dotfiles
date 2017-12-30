let g:memolist_path = "~/work/memo"
let g:memolist_memo_suffix = "md"
let g:memolist_unite = 1
let g:memolist_unite_option = "-auto-preview"
nnoremap [memo] <Nop>
nmap <Leader>m [memo]
nnoremap <silent>[memo]m :MemoNew<CR>
nnoremap <silent>[memo]l :MemoList<CR>
nnoremap <silent>[memo]g :MemoGrep<CR>
