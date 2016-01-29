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

" Tab completion
let b:vcm_tab_complete = "omni"

function! s:flake()
  let save = winsaveview()
  silent lexpr system("flake8 " . expand("%")) | silent redraw! | lwindow | wincmd p
  call winrestview(save)
endfunction

function! s:check()
  let makeprg_save = &l:makeprg
  try
    let &l:makeprg = "python -m py_compile " . expand("%")
    silent! make | silent redraw! | cwindow | wincmd p
  finally
    let &l:makeprg = makeprg_save
  endtry
endfunction

" Commands
command! -nargs=+ -buffer Pydoc call pydoc#run_pydoc("<args>")
command! -buffer Flake call s:flake()
command! -buffer Check call s:check()

" Maps
nnoremap <buffer> <leader>d o""""""2F"
nnoremap <buffer> <leader>D o"""yypkA.i
