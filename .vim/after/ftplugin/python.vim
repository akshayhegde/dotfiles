" Compiler
setlocal makeprg=python\ %
setlocal errorformat=%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
      \%C\ \ \ \ %.%#,
      \%+Z%.%#Error\:\ %.%#,
      \%A\ \ File\ \"%f\"\\\,\ line\ %l,
      \%+C\ \ %.%#,
      \%-C%p^,
      \%Z%m,
      \%-G%.%#

function s:flake()
  let saved_errorformat = &l:errorformat
  setlocal errorformat=
  silent lexpr system("flake8 ".expand("%")) | silent redraw! | lwindow
  let &l:errorformat=saved_errorformat
endfunction

" Tab completion
let b:vcm_tab_complete = "omni"

" Commands
command! -nargs=+ -buffer Pydoc call pydoc#run_pydoc("<args>")
command! -buffer Flake call s:flake()

" Maps
nnoremap <buffer> <leader>d o""""""2F"
nnoremap <buffer> <leader>D o"""yypkA.i
