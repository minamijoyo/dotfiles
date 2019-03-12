setlocal foldmethod=indent
setlocal foldlevel=100

" CircleCIの設定を保存したら自動でvalidateする
augroup yaml_circleci
  autocmd!
  autocmd BufWritePost .circleci/config.yml !circleci config validate <afile>
augroup END
