autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'whitelist': ['*'],
    \ 'priority': 3,
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ }))
