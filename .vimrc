" Basics
syntax on
filetype plugin indent on

" Colors
let g:spacegray_low_contrast = 1
colorscheme spacegray

if has('termguicolors') && $COLORTERM ==# 'truecolor'
  if &term =~# '\(tmux\|screen\)-256color'
    let [&t_8f, &t_8b] = ["\<Esc>[38:2:%lu:%lu:%lum", "\<Esc>[48:2:%lu:%lu:%lum"]
  endif
  set termguicolors
endif

" General Behaviors
set autoread
set backspace=indent,eol,start
set clipboard^=unnamed
set complete=.,w,b,t,kspell
set dictionary+=/usr/share/dict/words
set diffopt+=algorithm:histogram,indent-heuristic
set formatoptions+=1j
set hidden
set modelines=1
set mouse=n ttymouse=sgr
set nofoldenable
set nojoinspaces
set nostartofline
set nrformats-=octal
set sessionoptions-=options sessionoptions-=blank
set splitright
set switchbuf=useopen
set ttimeout ttimeoutlen=50
set visualbell t_vb=
set wildmenu wildcharm=<C-z> wildignore+=tags,*.pyc,*.o,*.xcodeproj/*

" Display
set laststatus=2
set lazyredraw
set linebreak
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set showcmd showbreak=↪
set statusline=[%n]\ %f\ %y\ %m%r%w%q%=%-15(%l,%c%V\ 0x%B%)\ %P

" Search
set tags^=.git/tags
set grepprg=git\ grep\ --untracked\ -n\ $*
set hlsearch incsearch
set showmatch matchtime=2

" Indent
set autoindent
set breakindent breakindentopt=shift:4,sbr
set smarttab expandtab
set softtabstop=4 shiftwidth=4 shiftround

" Backup
set backupdir=~/.vim/backup/
set directory^=~/.vim/swap/
set history=2000
set undofile undodir=~/.vim/backup/undo/

" Keymaps
nnoremap Q gq
nnoremap Y y$
nnoremap S i<CR><ESC>^m`gk:silent! s/\s\+$//<CR>:noh<CR>``
nnoremap zy :<C-u>echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>
nnoremap coh :<C-u>nohlsearch<CR>
nnoremap col :<C-u>set list! <bar> set list?<CR>
nnoremap cos :<C-u>set spell! <bar> set spell?<CR>
nnoremap con :<C-u>set relativenumber! number!<CR>
nnoremap <expr> j  v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k  v:count == 0 ? 'gk' : 'k'
nnoremap <expr> gj v:count == 0 ? 'j' : 'gj'
nnoremap <expr> gk v:count == 0 ? 'k' : 'gk'

" Navigation
nnoremap g<CR> :ls<CR>:buffer<space>
nnoremap gs :<C-u>ls<CR>:sbuffer<space>
nnoremap g\ :<C-u>ls<CR>:vertical sbuffer<space>
nnoremap z, :<C-u>find ./**/*
nnoremap z< :<C-u>find ./<C-r>=expand("%:h")<CR>/**/*
nnoremap z\ :<C-u>vertical sfind ./**/*
nnoremap z<bar> :<C-u>vertical sfind ./<C-r>=expand("%:h")<CR>/**/*
nnoremap z' :<C-u>sfind ./**/*
nnoremap z" :<C-u>sfind ./<C-r>=expand("%:h")<CR>/**/*
nnoremap zp :<C-u>tjump /\<
nnoremap z] :<C-u>psearch <C-r>=expand("<cword>")<CR><CR>
nnoremap z<C-]> :<C-u>ptjump <C-r>=expand("<cword>")<CR><CR>

" Searching
nnoremap cg* *``cgn
nnoremap cg# #``cgN
nnoremap g/ /\<\><left><left>
xnoremap * :<C-u>call visualfuncs#start('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call visualfuncs#start('?')<CR>/<C-R>=@/<CR><CR>
nnoremap zS viw:<C-u>grep! <C-R>=visualfuncs#getSelection()<CR><CR>:cwindow<bar>redraw!<CR>
xnoremap zS :<C-u>grep! <C-r>=visualfuncs#getSelection()<CR><CR>:cwindow<bar>redraw!<CR>

" Utilities
nnoremap gb :<C-u>echo system('git rev-parse --abbrev-ref @ <bar> tr -d "\n"')<CR>
nnoremap gB :<C-u>silent !tig blame % +<C-r>=expand(line('.'))<CR><CR>:silent redraw!<CR>
nnoremap gO :<C-u>silent !tig<CR>:silent redraw!<CR>
nnoremap gx :<C-u>execute util#browser('<C-r>=expand("<cWORD>")<CR>')<CR><CR>

" Filetype Settings
let g:python_highlight_all = 1
let [hs_highlight_types, hs_highlight_more_types, hs_highlight_debug] = [1, 1, 1]
let [html_indent_script1, html_indent_style1] = ['inc', 'inc']

" Commands
command! Scriptnames call setqflist(scripts#get()) | copen

augroup VIMRC
  autocmd!
  autocmd VimEnter * nested execute session#load()
  autocmd QuickFixCmdPost l* execute 'botright lwindow ' . max([4, min([8, len(getloclist(0))])])
  autocmd QuickFixCmdPost [^l]* execute  'botright cwindow ' . max([4, min([8, len(getqflist())])])
  autocmd BufWritePost * if &diff | diffupdate | endif
  autocmd VimLeavePre * execute session#save()
augroup END
