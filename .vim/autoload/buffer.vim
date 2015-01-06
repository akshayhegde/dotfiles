" Opens the buffer in the arrangement specified.
function! buffer#switchBySplitting(arrangement)
  let moreThanOneBuffer = len(filter(map(range(bufnr('$')), 'buflisted(v:val)'), 'v:val == 1')) > 1
  if a:arrangement ==? "horizontally"
      return moreThanOneBuffer ? ":buffer \<C-z>\<S-Tab>" : ":buffer "
  elseif a:arrangement ==? "vertically"
      return moreThanOneBuffer ? ":vertical sbuffer \<C-z>\<S-Tab>" : ":vertical sbuffer "
  endif
endfunction

" Get the names of buffers as a string separated by a space.
function! buffer#list()
  let buflist = []
  for i in range(1, bufnr('$'))
    if bufexists(i)
      let buflist += [bufname(i)]
    endif
  endfor
  return join(map(buflist, 'escape(v:val, " ")'), ' ')
endfunction
