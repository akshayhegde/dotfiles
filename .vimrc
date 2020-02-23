" ------------ ajh's .vimrc ------------
syntax on
filetype plugin indent on
colorscheme spacegray

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
set wildmenu wildcharm=<C-z> wildignore+=tags,*.pyc,*.o,*.xcodeproj/*
set sessionoptions-=options sessionoptions-=blank
set diffopt+=algorithm:histogram,indent-heuristic

" UI
if &term =~# '\(tmux\|screen\)-256color'
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif
set termguicolors
set laststatus=2
set statusline=[%n]\ %f\ %y\ %m%r%w%q%=%-15(%{&ff}/%{strlen(&fenc)?&fenc:&enc}%)\ %-15(%l,%c%V:0x%B%)\ %P
set formatoptions+=1j
set lazyredraw
set linebreak
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set showcmd showbreak=↪

" Search
set hlsearch incsearch
set ignorecase smartcase
set showmatch matchtime=2
set cscopetag tags^=.git/tags

" Indent
set autoindent
set breakindent breakindentopt=shift:4,sbr
set smarttab expandtab
set softtabstop=4 shiftwidth=4 shiftround

" Backup
set history=2000
set directory^=~/.vim/swap/
set backupdir=~/.vim/backup/
set undofile undodir=~/.vim/backup/undo/

" Keymaps
nnoremap Q gq
nnoremap Y y$
nnoremap S i<CR><ESC>^m`gk:silent! s/\s\+$//<CR>:noh<CR>``
nnoremap zy :<C-u>echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>
nnoremap coh :nohlsearch<CR>
nnoremap col :set list! <bar> set list?<CR>
nnoremap cos :set spell! <bar> set spell?<CR>
nnoremap con :set relativenumber! number!<CR>
nnoremap <expr> j  v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k  v:count == 0 ? 'gk' : 'k'
nnoremap <expr> gj v:count == 0 ? 'j' : 'gj'
nnoremap <expr> gk v:count == 0 ? 'k' : 'gk'

" Navigation
nnoremap g<CR> :ls<CR>:buffer<space>
nnoremap gs :ls<CR>:sbuffer<space>
nnoremap g\ :ls<CR>:vertical sbuffer<space>
nnoremap z, :find ./**/*
nnoremap z\ :vertical sfind ./**/*
nnoremap z' :sfind ./**/*
nnoremap z} :tjump /
nnoremap zp :ptjump /

" Searching
nnoremap cg* *``cgn
nnoremap cg# #``cgN
nnoremap g/ /\<\><left><left>
xnoremap * :<C-u>call visualfuncs#start('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call visualfuncs#start('?')<CR>/<C-R>=@/<CR><CR>
nnoremap zS viw:<C-u>Grep <C-R>=visualfuncs#getSelection()<CR><CR>:cwindow<bar>redraw!<CR>
xnoremap zS :<C-u>Grep <C-r>=visualfuncs#getSelection()<CR><CR>:cwindow<bar>redraw!<CR>

" Git
nnoremap gb :echo system('git rev-parse --abbrev-ref @ <bar> tr -d "\n"')<CR>
nnoremap gB :silent !tig blame % +<C-r>=expand(line('.'))<CR><CR>:silent redraw!<CR>
nnoremap gO :silent !tig<CR>:silent redraw!<CR>

" Filetype Settings
let g:python_highlight_all = 1
let [hs_highlight_types, hs_highlight_more_types, hs_highlight_debug] = [1, 1, 1]
let [html_indent_script1, html_indent_style1] = ['inc', 'inc']

" Commands
command! Scriptnames call setqflist(scripts#get()) | copen
command! -nargs=+ -complete=dir Grep call grep#search(<f-args>)

augroup VIMRC
  autocmd!
  autocmd VimEnter * nested execute session#load()
  autocmd QuickFixCmdPost l* execute 'lwindow ' . max([4, min([8, len(getloclist(0))])])
  autocmd QuickFixCmdPost [^l]* execute  'cwindow ' . max([4, min([8, len(getqflist())])])
  autocmd BufWritePost * if &diff | diffupdate | endif
  autocmd VimLeavePre * execute session#save()
augroup END
