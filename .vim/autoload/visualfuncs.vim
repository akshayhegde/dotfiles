" Visual star search
function! visualfuncs#start(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\n\n', 'g')
  let @s = temp
endfunction

" get the visual selection for a search as a string
function! visualfuncs#getSelection()
  try
    let reg_save = @v
    normal! gv"vy
    let enclose_in_quotes = substitute(@v, '^\|$', '"', 'g')
    return substitute(enclose_in_quotes, '\n', '\\n', 'g')
  finally
    let @v = reg_save
  endtry
endfunction
