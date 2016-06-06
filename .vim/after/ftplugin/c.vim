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

" Mappings
nnoremap <buffer> m<CR> :Make<CR>
nnoremap <buffer> M<CR> :make!<CR>
nnoremap <buffer> r<CR> :Make<CR>:!./a.out<CR>

" Commands
command! A call buffer#alternate("edit")
command! AV call buffer#alternate("vsplit")
command! AS call buffer#alternate("split")
