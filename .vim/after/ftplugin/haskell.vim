setlocal iskeyword+='
setlocal omnifunc=necoghc#omnifunc
setlocal conceallevel=1
let b:vcm_tab_complete = "omni"

" Search Hoogle
nnoremap <leader>h :cexpr system('hoogle ""')<left><left><left>
