" Run `pydoc` on a given string
function! pydoc#run_pydoc(cmd)
  if !executable("pydoc")
    echoerr "Cannot find 'pydoc'"
    return
  endif

  let reg_save = @/
  try
    silent! execute "topleft pedit pydoc"
    wincmd P
    resize 20

    execute "-read! pydoc ".a:cmd . " 2>&1 "
    silent! %s/\s\+$//g
    set buftype=nofile
    set syntax=python
    setlocal bufhidden=delete
    normal! 1G

    wincmd p
  finally
    let @/ = reg_save
  endtry
endfunction
