" ファイルの保存時のみチェックする
let g:ale_lint_on_save = 1
" ファイルの保存時に自動で修正する
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 0
" ファイルのオープン時にはチェックしない
let g:ale_lint_on_enter = 0
" ロケーションリストを開く
let g:ale_open_list = 1
" terraform_unused_declarationsは1ファイルだけチェックすると誤検知するので無効化
let g:ale_terraform_tflint_options='--disable-rule=terraform_unused_declarations'
let g:ale_fixers = {
\    'python': ['black'],
\}
" GitHub ActionsのワークフローのYAMLファイルだけactionlintを有効化
au BufRead,BufNewFile */.github/*/*.y{,a}ml let b:ale_linters = {'yaml': ['actionlint']}
" actionlintのshellcheckで指摘した行がYAMLの行として解釈されてしまうので無効化
let g:ale_yaml_actionlint_options = '-shellcheck= '
