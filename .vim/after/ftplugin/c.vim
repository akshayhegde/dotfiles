" Compiler settings
compiler clang
let b:dispatch = 'clang %'
setlocal makeprg=clang\ %
let &errorformat = '%E%f:%l:%c: fatal error: %m,' .
      \ '%E%f:%l:%c: error: %m,' .
      \ '%W%f:%l:%c: warning: %m,' .
      \ '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
      \ '%E%m'

" General
setlocal nofoldenable foldmethod=syntax
setlocal commentstring=//\ %s
setlocal textwidth=80

" Commands
command! -nargs=0 Format call format#file()
command! A call buffer#alternate("e")
command! AV call buffer#alternate("v")
command! AS call buffer#alternate("s")
