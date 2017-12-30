nnoremap [fugitive] <Nop>
vnoremap [fugitive] <Nop>
nmap <Leader>g [fugitive]
vmap <Leader>g [fugitive]
nnoremap [fugitive]d :<C-u>Gdiff<Enter>
nnoremap [fugitive]g :<C-u>Gstatus<Enter>
nnoremap [fugitive]c :<C-u>Gcommit -v<Enter>
nnoremap [fugitive]a :<C-u>Gcommit -v --amend<Enter>
nnoremap [fugitive]b :<C-u>Gblame<Enter>
nnoremap [fugitive]p :<C-u>Gpush origin HEAD<Enter>
nnoremap [fugitive]o :<C-u>Gbrowse<Enter>
vnoremap [fugitive]o :<C-u>'<,'>Gbrowse<Enter>
