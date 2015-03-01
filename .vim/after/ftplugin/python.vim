setlocal makeprg=python\ %
setlocal errorformat=%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
      \%C\ \ \ \ %.%#,
      \%+Z%.%#Error\:\ %.%#,
      \%A\ \ File\ \"%f\"\\\,\ line\ %l,
      \%+C\ \ %.%#,
      \%-C%p^,
      \%Z%m,
      \%-G%.%#

let b:vcm_tab_complete = "omni"
command! -buffer Flake silent lexpr system("flake8 ".expand("%")) | silent redraw! | lwindow

nnoremap <buffer> <leader>d o""""""2F"
nnoremap <buffer> <leader>D o"""yypkA.i
