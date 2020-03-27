autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'priority': 5,
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))
