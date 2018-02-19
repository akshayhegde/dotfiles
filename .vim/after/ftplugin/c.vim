" General
setlocal nofoldenable foldmethod=syntax
setlocal commentstring=//\ %s
setlocal textwidth=80
setlocal makeprg=clang\ -Wall\ -Wpedantic\ %
let &errorformat = '%E%f:%l:%c: fatal error: %m,' .
      \ '%E%f:%l:%c: error: %m,' .
      \ '%W%f:%l:%c: warning: %m,' .
      \ '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
      \ '%E%m'

" Commands
command! -buffer A call buffer#alternate("edit")
command! -buffer AV call buffer#alternate("vsplit")
command! -buffer AS call buffer#alternate("split")
