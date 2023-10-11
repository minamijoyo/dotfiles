" let g:asyncomplete_log_file = expand('/tmp/asyncomplete.log')
" 自動補完がすぐに出るとウザい＆重いので遅延を長めにしておいて
" Ctrl+Spaceで補完を任意のタイミングで呼び出せるようにしておく。
" Copilotと競合するので自動補完は一旦オフにしておく。
let g:asyncomplete_auto_popup = 0
" let g:asyncomplete_popup_delay = 1000
" Ctrl+Spaceで補完したいが端末からNulが送られるのでマップしなおす
imap <nul> <c-space>
imap <c-space> <Plug>(asyncomplete_force_refresh)
