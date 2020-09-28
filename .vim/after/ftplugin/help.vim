
" Maps
nnoremap <buffer> <CR> <C-]>
nnoremap <buffer> <BS> <C-T>
nnoremap <buffer> o /'[a-z]\{2,\}'<CR>
nnoremap <buffer> O ?'[a-z]\{2,\}'<CR>
nnoremap <buffer> s /\|\S\+\|<CR>l
nnoremap <buffer> S h?\|\S\+\|<CR>l
nnoremap <buffer> q :q<CR>
nnoremap <buffer> <leader>j :cnext<CR>
nnoremap <buffer> <leader>k :cprev<CR>

augroup HELP
  autocmd!
  autocmd BufWinEnter <buffer> wincmd K
augroup END
