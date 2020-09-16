function grep#search(...)
  " If we're using normal grep, and we didn't specify a directory, add the
  " current directory for recursive grep
  let grep_args = 'grep!'
  for arg in a:000
    let grep_args .= ' ' . arg
  endfor
  let last_arg = get(split(grep_args), -1)
  if &grepprg !~# 'git' && (!isdirectory(last_arg) && !filereadable(last_arg))
    let grep_args .= ' .'
    echom "grep args = ". grep_args
  endif

  silent execute grep_args
  redraw!
endfunction

function grep#set()
  if system('git rev-parse --is-inside-work-tree') =~# 'true'
    let &grepprg = 'git grep --untracked -n $*'
  endif
endfunction
