function grep#search(...)
  let grepprg_save = &grepprg
  if system('git rev-parse --is-inside-work-tree') =~# 'true'
    let &grepprg = 'git grep -n $*'
  else
    let &grepprg = "grep -HIrn --exclude=tags --exclude='*.xib' --exclude-dir='*.xcodeproj' $*"
  endif

  let grep_args = 'grep!'
  for arg in a:000
    let grep_args .= ' ' . arg
  endfor

  " If we're using normal grep, and we didn't specify a directory, add the
  " current directory for recursive grep
  if &grepprg !~# 'git' && !isdirectory(split(get(grep_args, -1)))
    let grep_args .= ' .'
    echom "grep args = ". grep_args
  endif

  silent execute grep_args
  redraw!
  cwindow
  let &grepprg = grepprg_save
endfunction
