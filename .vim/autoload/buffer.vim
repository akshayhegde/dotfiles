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

" A dead simple header/source alternater.
" Without installing a 400+ plugin or having to write some stupid json file.
function! buffer#alternate(arrangement)
  let file_name = expand("%:t:r")
  let extension = expand("%:t:e")

  let source_list = ["cpp", "c", "cc", "cxx"]
  let header_list = ["h", "hpp", "hh", "hxx"]
  let is_source = index(source_list, extension) >= 0
  let is_header = index(header_list, extension) >= 0

  let edit_command = "edit "
  if a:arrangement ==? "v"
    let edit_command = "vsplit "
  elseif a:arrangement ==? "s"
    let edit_command = "split "
  endif


  " Switch to header file if the current file is a source file
  if is_source
    for header in header_list
      let full_file_name = file_name . "." . header
      if filereadable(full_file_name)
        if bufexists(full_file_name) && a:arrangement !=? "e"
          execute a:arrangement ==? "v" ? "sbuffer " . full_file_name : "vert sbuffer " . full_file_name
        else
            execute edit_command . full_file_name
        endif
        return
      endif
    endfor
    echohl ErrorMsg | echo "Header file not found!" | echohl None
    return
  endif

  " Switch to the source file if the current file is a header file
  if is_header
    for l:source in source_list
      let full_file_name = file_name . "." . l:source
      if filereadable(full_file_name)
        if bufexists(full_file_name) && a:arrangement !=? "e"
          execute a:arrangement ==? "v" ? "sbuffer " . full_file_name : "vert sbuffer " . full_file_name
        else
          execute edit_command . full_file_name
        endif
        return
      endif
    endfor
    echohl ErrorMsg | echo "Source file not found!" | echohl None
  endif
endfunction
