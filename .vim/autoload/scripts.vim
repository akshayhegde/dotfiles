" Returns a list of the :scriptnames
function! s:names()
  let scripts = ''
  redir => scripts
  execute 'silent! scriptnames'
  redir END
  return scripts
endfunction

" Load :scriptnames into the quickfix list.
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

