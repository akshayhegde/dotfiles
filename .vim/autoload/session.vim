function s:session_file()
  return fnameescape(expand("~/.vim/sessions/") . fnamemodify(getcwd(), ':t') . "/Session.vim")
endfunction

function s:init_cscope()
  let cscope_db = fnameescape(expand("~/.vim/cscope/") . fnamemodify(getcwd(), ':t'))
  let cscope_conn = cscope_db . '/cscope.out'
  if executable('cscope') && has('cscope') && filereadable(cscope_conn)
    return 'cscope add ' . cscope_db
  endif
endfunction

function session#check()
  let session_file = s:session_file()
  if filereadable(session_file)
    return 'source ' . session_file . ' | ' . s:init_cscope()
  endif
endfunction

function session#mk()
  let session_file = s:session_file()
  call mkdir(fnamemodify(session_file, ':h'), 'p', 0700)
  return 'mksession ' . session_file . ' | '. s:init_cscope()
endfunction

function! session#save()
  return 'mksession! ' . s:session_file()
endfunction
