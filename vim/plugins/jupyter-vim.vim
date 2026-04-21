let g:vim_virtualenv_path = '.venv'
if exists('g:vim_virtualenv_path')
    pythonx import os; import vim
    pythonx activate_this = os.path.join(vim.eval('g:vim_virtualenv_path'), 'bin/activate')
    pythonx with open(activate_this) as f: exec(f.read(), {'__file__': activate_this})
endif
