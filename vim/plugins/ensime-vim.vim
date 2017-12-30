nnoremap [ensime] <Nop>
nmap <Leader>e [ensime]
noremap <silent>[ensime]d :EnDeclaration<CR>
noremap <silent>[ensime]t :EnType<CR>
noremap <silent>[ensime]f :EnToggleFullType<CR>
noremap <silent>[ensime]c :EnTypeCheck<CR>
noremap <silent>[ensime]i :EnSuggestImport<CR>
noremap <silent>[ensime]o :EnOrganizeImports<CR>
" deopleteでscalaのファイルも補完する
" refs: https://github.com/Shougo/deoplete.nvim/issues/245
" refs: https://github.com/ensime/ensime-vim/issues/282
let g:deoplete#sources = {}
let g:deoplete#sources.scala = ['buffer', 'tags', 'omni']
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.scala = [
  \ '[^. *\t]\.\w*',
  \ '[:\[,] ?\w*',
  \ '^import .*'
  \ ]
