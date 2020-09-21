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

function! s:lint()
  if !executable("flake8")
    echoerr "Cannot find 'flake8'!"
    return
  endif

  let save = winsaveview()
  silent lexpr system("flake8 " . expand("%")) | silent redraw! | lwindow
  call winrestview(save)
endfunction

" Commands
command! -nargs=+ -buffer Pydoc call pydoc#run_pydoc("<args>")
command! -buffer Lint call s:lint()
