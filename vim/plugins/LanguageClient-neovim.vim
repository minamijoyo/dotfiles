let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
  \ 'go': ['golsp'],
  \ }

" let g:LanguageClient_serverCommands = {
"   \ 'terraform': ['tfcode'],
"   \ }
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'
