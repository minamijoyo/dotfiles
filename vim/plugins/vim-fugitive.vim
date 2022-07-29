nnoremap [fugitive] <Nop>
vnoremap [fugitive] <Nop>
nmap <Leader>g [fugitive]
vmap <Leader>g [fugitive]
nnoremap [fugitive]d :<C-u>Gdiff<Enter>
nnoremap [fugitive]g :<C-u>Git<Enter>
nnoremap [fugitive]c :<C-u>Gcommit -v<Enter>
nnoremap [fugitive]a :<C-u>Gcommit -v --amend<Enter>
nnoremap [fugitive]b :<C-u>Git blame<Enter>
nnoremap [fugitive]p :<C-u>Gpush origin HEAD<Enter>
nnoremap [fugitive]o :<C-u>GBrowse<Enter>
vnoremap [fugitive]o :<C-u>'<,'>GBrowse<Enter>
