" Run `pydoc` on a given string
function! pydoc#run_pydoc(cmd)
  if !executable("pydoc")
    echoerr "Cannot find 'pydoc'"
    return
  endif

  let reg_save = @/
  silent! execute "pedit pydoc"
  wincmd p
  execute "-read! pydoc ".a:cmd
  set buftype=nofile
  set syntax=python
  silent! %s/\s\+$//g
  wincmd p

  let @/ = reg_save
endfunction
