let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('/tmp/vim-lsp.log')
let g:lsp_log_file = ''
nnoremap <silent> <C-]> :LspDefinition<CR>

" ファイル保存時に自動でorganizeImportsとFormatを実行する
augroup lsp_organize_imports_and_format
  autocmd!
  autocmd BufWritePre *.py call execute('LspCodeActionSync source.organizeImports')
  autocmd BufWritePre *.py call execute('LspDocumentFormatSync --server=ruff-lsp')
augroup END
