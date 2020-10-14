compiler swift
setlocal shiftwidth=2 softtabstop=2

function! s:lint()
  if !executable("swift-format")
    echoerr "Cannot find 'swift-format'!"
    return
  endif
  let view = winsaveview()
  silent lexpr system("swift-format lint " . shellescape(expand("%"))) | silent redraw! | lwindow
  call winrestview(view)
endfunction

command! -buffer Lint call s:lint()
