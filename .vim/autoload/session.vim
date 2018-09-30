function! session#load_session()
  let sessions_dir = expand("~/.vim/sessions/")
  let current_workspace = fnamemodify(getcwd(), ':t')
  let session_file = sessions_dir . current_workspace . "/Session.vim"

  let cscope_dir = expand("~/.vim/cscope/")
  let cscope_db = cscope_dir . current_workspace
  let cscope_conn = cscope_db . '/cscope.out'

  if filereadable(session_file)
    silent echomsg "Loading session file " . session_file
    execute 'source' fnameescape(session_file)
  endif

  if executable('cscope') && has('cscope') && filereadable(cscope_conn)
    silent echomsg 'Loading cscope database connection' . cscope_conn
    execute 'cs add -C' cscope_db
  endif
endfunction

function! session#init_session()
  let sessions_dir = expand("~/.vim/sessions/")
  let current_workspace = fnamemodify(getcwd(), ':t')
  let session_file = sessions_dir . current_workspace . "/Session.vim"

  if filereadable(session_file)
    call session#load_session()
  endif

  echomsg 'Creating a new session file for current project'
  let new_session_path = fnameescape(expand(sessions_dir . current_workspace))
  call mkdir(new_session_path)
  if exists(':Obsession')
    execute 'Obsession' new_session_path
  else
    echomsg 'Warning: Obsession not found. Falling back to mksession instead'
    execute 'mksession' session_file
  endif
endfunction
