" hashicorp/terraform-lsを使うためjuliosueiras/terraform-lspを無効化
let g:lsp_settings = {
\  'golangci-lint-langserver': {
\    'initialization_options': {'command': ['golangci-lint', 'run', '--out-format', 'json']}
\   },
\  'ruff-lsp': {
\     'initialization_options': {
\       'settings': {
\         'lint': {
\           'run': 'onType',
\         },
\       },
\     },
\   },
\}
" 標準のgopls以外にgolangci-lint-langserverを有効化
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']
" pylsp経由でpython-lsp-ruffを入れるよりも、ruffの方が推奨
" またruff-lspよりもruff serverのlsp機能の方が推奨
" しかしながらruffのバージョンを上げられない環境があるのでruff-lspを使う
let g:lsp_settings_filetype_python = ['pylsp', 'ruff-lsp']
