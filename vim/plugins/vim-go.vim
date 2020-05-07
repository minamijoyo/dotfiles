nnoremap [go] <Nop>
nmap <Leader>o [go]
nnoremap <silent>[go]o :GoRun<CR>
let g:go_fmt_command = "goimports"
" goplsはvim-lsp経由で使うのでvim-goは無効化しておく
let g:go_gopls_enabled = 0
