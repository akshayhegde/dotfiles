" ------------ ajh's .vimrc ------------
syntax on
filetype plugin indent on
colorscheme spacegray
runtime macros/matchit.vim

" Basics
set autoread
set backspace=indent,eol,start
set clipboard^=unnamed
set complete=.,w,b,t,kspell
set dictionary+=/usr/share/dict/words
set hidden
set mouse=n ttymouse=sgr
set nostartofline
set nojoinspaces
set nofoldenable
set nrformats-=octal
set switchbuf=useopen,usetab
set ttimeout ttimeoutlen=50
set wildmenu wildcharm=<C-z> wildignore+=tags,*.pyc,*.o

" UI
if &term =~# '\(tmux\|screen\)-256color'
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif
set termguicolors
set laststatus=2
set statusline=%f\ %y\ %m%r%w%q%=%-15(%{&ff}/%{strlen(&fenc)?&fenc:&enc}%)\ %-15(%l,%c%V:0x%B%)\ %P
set formatoptions+=1j
set lazyredraw
set linebreak
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set showcmd showbreak=↪

" Search
set grepprg=grep\ -sHIrn
set hlsearch incsearch
set ignorecase smartcase
set showmatch matchtime=2
set cscopetag tags^=.git/tags
set path=.,**

" Indent
set autoindent
set breakindent breakindentopt=shift:4,sbr
set smarttab expandtab
set softtabstop=4 shiftwidth=4 shiftround

" Backup
set noswapfile
set backup backupdir=~/.vim/backup/
set undofile undodir=~/.vim/backup/undo/

" Maps
let g:mapleader = ' '

" Helpers
nnoremap Q gq
nnoremap Y y$
nnoremap S i<CR><ESC>^m`gk:silent! s/\s\+$//<CR>:noh<CR>``
nnoremap zS :<C-u>echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>
nnoremap coh :nohlsearch<CR>
nnoremap col :set list! <bar> set list?<CR>
nnoremap cos :set spell! <bar> set spell?<CR>
nnoremap con :set relativenumber! number!<CR>
nnoremap <leader>v ^vg_
nnoremap <leader>w m`:let @s = @/<CR>:silent! %s/\s\+$//<CR>:let @/ = @s<CR>:nohl<CR>``

" Navigation
nnoremap <expr> j  v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k  v:count == 0 ? 'gk' : 'k'
nnoremap <expr> gj v:count == 0 ? 'j' : 'gj'
nnoremap <expr> gk v:count == 0 ? 'k' : 'gk'
nnoremap <expr> <leader>b buffer#switchBySplitting('horizontally')
nnoremap <expr> <leader>B buffer#switchBySplitting('vertically')
nnoremap <leader>l :ls<CR>:b
nnoremap <leader>f :find *
nnoremap <leader>F :find <C-r>=expand('%:p:h').'/**/*'<CR>
nnoremap <leader>\ :vertical sfind *
nnoremap <leader><bar> :vertical sfind <C-r>=expand('%:p:h').'/**/*'<CR>
nnoremap <leader>- :sfind *
nnoremap <leader>_ :sfind <C-r>=expand('%:p:h').'/**/*'<CR>
nnoremap <leader>j :tjump /
nnoremap <leader>J :ptjump /

" Searching
nnoremap <leader>* *``cgn
nnoremap <leader># #``cgN
nnoremap g/ /\<\><left><left>
xnoremap * :<C-u>call visualfuncs#start('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call visualfuncs#start('?')<CR>/<C-R>=@/<CR><CR>
nnoremap <leader>s viw:<C-u>Grep <C-R>=visualfuncs#getSelection()<CR><CR>:cwindow<bar>redraw!<CR>
xnoremap <leader>s :<C-u>Grep <C-r>=visualfuncs#getSelection()<CR><CR>:cwindow<bar>redraw!<CR>

" Git
nnoremap <leader>gb :echo system('git rev-parse --abbrev-ref @ <bar> tr -d "\n"')<CR>
nnoremap <leader>go :silent !tig<CR>:silent redraw!<CR>
nnoremap <leader>gB :silent !tig blame % +<C-r>=expand(line('.'))<CR><CR>:silent redraw!<CR>

" Filetype Settings
let g:python_highlight_all = 1
let [html_indent_script1, html_indent_style1] = ['inc', 'inc']
let [netrw_winsize, netrw_banner, netrw_liststyle] = [20, 0, 3]

" Commands
command! Scriptnames call setqflist(scripts#get()) | copen
command! Make silent make! | redraw! | cwindow
command! Lake silent lmake! | redraw! | lwindow
command! LoadSession call session#load_session()
command! InitSession call session#init_session()
command! -nargs=+ -complete=tag Grep call grep#search(<f-args>)

augroup VIMRC
  autocmd!
  autocmd BufReadPost * if &ft !~# 'commit' | silent! execute 'normal! g`"zzzv' | endif
  autocmd BufWritePost * if &diff | diffupdate | endif
  autocmd InsertLeave * if bufname('%') != '[Command Line]' | pclose | endif
augroup END
