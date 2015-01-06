" Returns a list of vimscripts currently loaded.
function! s:names()
  let scripts = ''
  redir => scripts
  execute 'silent! scriptnames'
  redir END
  return scripts
endfunction

" Returns a list of dictionaries containing the vimscripts currently loaded.
" Suitable for use in the quickfix list.
function! scripts#get()
  let names = s:names()
  let list = []
  for line in split(names, "\n")
    if line =~# ':'
      call add(list, { 'text' : matchstr(line, '\d\+'), 'filename': expand(matchstr(line, ': \zs.*'))})
    endif
  endfor
  return list
endfunction
