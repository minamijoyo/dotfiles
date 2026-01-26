" hashicorp/terraform-lsを使うためjuliosueiras/terraform-lspを無効化
let g:lsp_settings = {
\  'golangci-lint-langserver': {
\    'initialization_options': {'command': ['golangci-lint', 'run', '--out-format', 'json']}
\   },
\}
" 標準のgopls以外にgolangci-lint-langserverを有効化
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']
" pylsp経由でpython-lsp-ruffを入れるよりも、ruffの方が推奨
let g:lsp_settings_filetype_python = ['pylsp', 'ruff']
