" Opens the buffer in the arrangement specified.
function! buffer#switchBySplitting(arrangement)
  let moreThanOneBuffer = len(filter(map(range(bufnr('$')), 'buflisted(v:val)'), 'v:val == 1')) > 1
  if a:arrangement ==? "horizontally"
    return moreThanOneBuffer ? ":buffer \<C-z>\<S-Tab>\<C-d>" : ":buffer \<C-d>"
  elseif a:arrangement ==? "vertically"
    return moreThanOneBuffer ? ":vertical sbuffer \<C-z>\<S-Tab>\<C-d>" : ":vertical sbuffer \<C-d>"
  endif
endfunction

" Opens the buffer with the specified arrangement. For buffer#alternate()
function! s:buffer_open(filename, edit_command)
  if filereadable(a:filename) || bufexists(a:filename)
    execute bufwinnr(a:filename) == -1 ? a:edit_command ." ". a:filename : "sbuffer " . a:filename
    return 1
  endif
  return 0
endfunction

" A dead simple header/source alternator.
" Without installing a 400+ plugin or having to write some stupid json file.
function! buffer#alternate(edit_command)
  let file_name = expand("%:t:r")
  let extension = expand("%:t:e")
  let source_list = ["cpp", "c", "cc", "cxx"]
  let header_list = ["h", "hpp", "hh", "hxx"]

  if index(source_list, extension) >= 0
    for l:header in header_list
      if s:buffer_open(file_name . "." . header, a:edit_command)
        return
      endif
    endfor
    echohl ErrorMsg | echo "Header file not found in path!" | echohl None
  elseif index(header_list, extension) >= 0
    for l:source in source_list
      if s:buffer_open(file_name . "." . l:source, a:edit_command)
        return
      endif
    endfor
    echohl ErrorMsg | echo "Source file not found in path!" | echohl None
  endif
endfunction
