setlocal iskeyword+='
setlocal omnifunc=necoghc#omnifunc
let b:vcm_tab_complete = "omni"

" Search Hoogle
nnoremap <leader>h :cexpr system('hoogle ""')<left><left><left>
