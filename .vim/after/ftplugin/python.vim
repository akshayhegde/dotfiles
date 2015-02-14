setlocal errorformat=%f:%l:%c:\ %m
setlocal errorformat+=%f:%l:\ %m
setlocal makeprg=flake8\ --max-complexity\ 11\ %
let b:dispatch = "flake8 %"
let b:vcm_tab_complete = "omni"
nnoremap <buffer> <leader>d o""""""2F"
nnoremap <buffer> <leader>D o"""yypO
