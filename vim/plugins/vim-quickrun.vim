let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \   'runner'    : 'vimproc',
      \   'runner/vimproc/updatetime' : 60,
      \   'outputter' : 'error',
      \   'outputter/error/success' : 'buffer',
      \   'outputter/error/error'   : 'quickfix',
      \   'outputter/buffer/split'  : ':rightbelow 8sp',
      \   'outputter/buffer/close_on_empty' : 1,
      \}

let g:quickrun_config['go'] = {
      \ 'command': 'go',
      \ 'exec': ['%c run %s']
      \ }

nnoremap [quickrun] <Nop>
nmap <Leader>q [quickrun]
nnoremap <silent>[quickrun]g :QuickRun go<CR>
" <C-c> で実行を強制終了させる
" quickrun.vim が実行していない場合には <C-c> を呼び出す
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
