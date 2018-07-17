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

function! s:flake()
  if !executable("flake8")
    echoerr "Cannot find 'flake8'!"
    return
  endif

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
