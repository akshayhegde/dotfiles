setlocal iskeyword+='
setlocal conceallevel=1
setlocal makeprg=runhaskell\ %
setlocal errorformat=%W%f:%l:%c:\ Warning:\ %m,
                    \%E%f:%l:%c:\ %m,
                    \%E%>%f:%l:%c:,
                    \%+C\ \ %#%m,
                    \%W%>%f:%l:%c:,
                    \%+C\ \ %#%tarning:\ %m,
                    \%-Z\ %#%$,
                    \%-Z\ %#,
                    \%-G\ %#,
                    \%-GLinking\ %.%#\ ...,
                    \%-G%.%#[%.%#of%.%#]\ Compiling\ %.%#,

setlocal omnifunc=necoghc#omnifunc
let b:vcm_tab_complete = "omni"

" Search Hoogle
nnoremap <leader>h :cexpr system('hoogle ""')<left><left><left>
