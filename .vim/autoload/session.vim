function! s:session_file()
  return fnameescape(expand("~/.vim/sessions/") . fnamemodify(getcwd(), ':t') . "/Session.vim")
endfunction

function! s:check_cscope()
  let cscope_db = fnameescape(expand("~/.vim/cscope/") . fnamemodify(getcwd(), ':t'))
  let cscope_conn = cscope_db . '/cscope.out'
  if executable('cscope') && has('cscope') && filereadable(cscope_conn)
    return 'cscope add ' . cscope_db
  endif
endfunction

function s:check_session()
  let session_file = s:session_file()
  if filereadable(session_file)
    return 'source ' . session_file
  endif
endfunction

function! session#load()
  let l:cscope = s:check_cscope()
  if !argc() && empty(v:this_session)
    let l:session = s:check_session()
    if empty(l:cscope) && !empty(l:session)
      return l:session
    elseif !empty(l:cscope) && !empty(l:session)
      return l:session . ' | ' . l:cscope
    endif
  endif
  if !empty(l:cscope)
    return l:cscope
  endif
endfunction

function! session#mk()
  let session_file = s:session_file()
  call mkdir(fnamemodify(session_file, ':h'), 'p', 0700)
  return 'mksession! ' . session_file
endfunction

function! session#save()
  return 'mksession! ' . s:session_file()
endfunction
