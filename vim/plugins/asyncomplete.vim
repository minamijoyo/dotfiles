" 自動補完を無効化して、Ctrl+Spaceで補完できるようにする
" TABだとインデントのTABの直後に補完したい場合に対応できない
let g:asyncomplete_auto_popup = 0
imap <c-space> <Plug>(asyncomplete_force_refresh)
