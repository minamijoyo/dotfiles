let g:LanguageClient_serverCommands = {
  \ 'go': ['go-langserver', '-gocodecompletion'],
  \ }
let g:LanguageClient_autoStart = 1

" デバッグ用の設定
" let g:LanguageClient_serverCommands = {
"   \ 'go': ['go-langserver', '-gocodecompletion', '-trace'],
"   \ 'terraform': ['tfcode'],
"   \ }
" let g:LanguageClient_loggingLevel = 'DEBUG'
