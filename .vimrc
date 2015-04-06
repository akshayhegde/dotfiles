" ------------ ajh's .vimrc ------------
" Plugins {{{1
execute pathogen#infect()
runtime macros/matchit.vim

" Syntax, FileType, Colorscheme {{{1
syntax on
filetype plugin indent on
colorscheme spacegray

" General {{{1
set autoread
set backspace=indent,eol,start
set clipboard^=unnamed
set completeopt+=longest,menuone
set dictionary+=/usr/share/dict/words
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8
set fileformats+=mac
set hidden
set mouse=n ttymouse=sgr
set nostartofline
set nrformats-=octal
set path=.,**
set switchbuf=useopen,usetab
set ttimeoutlen=50
set wildmenu wildcharm=<C-z>

" UI {{{1
if has("termtruecolor")
  let &t_8f="\e[38;2;%ld;%ld;%ldm"
  let &t_8b="\e[48;2;%ld;%ld;%ldm"
  set guicolors
endif
set formatoptions+=1j
set lazyredraw
set linebreak
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set nofoldenable
set nojoinspaces
set number relativenumber
set showcmd showbreak=↪

" GUI {{{1
if has("gui_running")
  set guioptions= lines=40 columns=140 guifont=Fira\ Mono:h11
endif

" Statusline {{{1
set laststatus=2
set statusline=[%n]\ %f\ [%{&ff}/%{strlen(&fenc)?&fenc:&enc}/%{&ft}]\ %m%r%w%q%{fugitive#head()}
set statusline+=%=%<[0x%B]\ [%P\ %l/%L\ at\ %c]

" Searching {{{1
set hlsearch incsearch
set ignorecase smartcase
set showmatch matchtime=2
set grepprg=ag\ --hidden\ --vimgrep grepformat^=%f:%l:%c:%m

" Indenting {{{1
set autoindent
set breakindent breakindentopt=shift:4,sbr
set smarttab expandtab
set softtabstop=4 shiftwidth=4 shiftround

" Backup {{{1
set history=200
set noswapfile
set backup backupdir=~/.vim/backup/
set undofile undodir=~/.vim/backup/undo/

" Wildignore {{{1
set wildignore+=.hg,.git,.svn,*.pyc,*.spl,*.o,*.out,*.DS_Store,*.class,*.manifest,*~,#*#,%*
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,*.xc*,*.pbxproj,*.xcodeproj/**,*.xcassets/**

" General Mappings {{{1
let g:mapleader = ' '

" Switch between splits
nnoremap <silent> <C-h> <C-w><C-h>
nnoremap <silent> <C-j> <C-w><C-j>
nnoremap <silent> <C-k> <C-w><C-k>
nnoremap <silent> <C-l> <C-w><C-l>

" Move by display lines
nnoremap <expr> j  v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k  v:count == 0 ? 'gk' : 'k'
nnoremap <expr> gj v:count == 0 ? 'j' : 'gj'
nnoremap <expr> gk v:count == 0 ? 'k' : 'gk'

" Remap some default keys to be more useful
nnoremap Q gq
nnoremap Y y$
nnoremap S i<CR><ESC>^m`gk:silent! s/\s\+$//<CR>:noh<CR>``
nnoremap + za
xnoremap * :<C-u>call visualfuncs#start('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call visualfuncs#start('?')<CR>/<C-R>=@/<CR><CR>
nnoremap zS :<C-u>echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>

" The only mappings I used from vim-unimpaired
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprevious<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [l :lprevious<CR>zz
nnoremap coh :set hlsearch! <bar> set hlsearch?<CR>
nnoremap col :set list! <bar> set list?<CR>
nnoremap cos :set spell! <bar> set spell?<CR>

" Quicker cgn/cgN
nnoremap <leader>* *``cgn
nnoremap <leader># #``cgN

" Visually Select a line without indentation
nnoremap <leader>v ^vg_

" re-indent file while retaining cursor position.
nnoremap <leader>= :call format#reindent()<CR>

" Remove trailing whitespace
nnoremap <leader>w m`:%s/\s\+$//<CR>:let @/=''<CR>``

" cd to the current file's path
nnoremap <leader>c :cd %:p:h<CR>:pwd<CR>

" Buffer switching
nnoremap <expr> <leader>b buffer#switchBySplitting("horizontally")
nnoremap <expr> <leader>B buffer#switchBySplitting("vertically")

" Search mappings
xnoremap K :<C-u>grep! <C-r>=visualfuncs#getSelection()<CR> <bar> cwindow <bar> redraw!<CR>
nnoremap g/ /\<\><left><left>
nnoremap <leader>j :tjump /
nnoremap <leader>J :ptjump /

" Plugin Settings {{{1
let [html_indent_script1, html_indent_style1] = ["inc", "inc"]
let [hs_highlight_boolean, hs_highlight_types, hs_highlight_more_types] = [1, 1, 1]
let [python_highlight_all, java_highlight_all] = [1, 1]
let [netrw_winsize, netrw_banner, netrw_liststyle] = [20, 0, 3]
let [fist_in_private, fist_anonymously] = [0, 0]
let g:clang_complete_auto = 0
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'

" Plugin Maps {{{1
" Fugitive {{{2
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<bar>wincmd p<CR>
nnoremap <leader>gs :Gstatus<CR>

" Autocommands {{{1
augroup VIMRC
  autocmd!
  autocmd BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  autocmd BufReadPost * silent! execute 'normal! g`"zzzv'
  autocmd BufWritePost * if &diff | diffupdate | endif
  autocmd InsertLeave * if bufname('%') != "[Command Line]" | pclose | endif
  autocmd VimEnter * call cursor#changeShape()
augroup END

" Commands {{{1
command! BD silent e# | bd#
command! Scriptnames call setqflist(scripts#get()) | copen
command! -nargs=+ -complete=file_in_path Grep silent grep! <args> | silent redraw! | cwindow
command! Make silent make! | silent redraw! | cwindow
command! Lmake silent lmake! | silent redraw! | lwindow
