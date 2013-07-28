"----------------------------
"| ~/.vimrc                 |
"| Last update: Jun 1, 2013 |
"----------------------------
" Vundle Settings {{{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

"}}}
" Installed Plugins {{{
Bundle 'coderifous/textobj-word-column.vim'
Bundle 'ervandew/supertab'
Bundle 'fsouza/go.vim'
Bundle 'godlygeek/tabular'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'kana/vim-textobj-user'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/zencoding-vim'
Bundle 'mileszs/ack.vim'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplete.vim'
Bundle 'Shougo/neosnippet.vim'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tsaleh/vim-matchit'
Bundle 'w0ng/vim-hybrid'

" }}}
" General Settings {{{
set number relativenumber       " Use relative numbering but show the actual line number instead of 0 (vim 7.4)
set showcmd                     " Show the current command below the status
set cmdheight=2                 " Statusline height
set showmode                    " Show the mode we are in
set hidden                      " Allow hidden buffers
set mouse=a                     " Turn on mouse for everything
set scrolloff=4                 " Scroll when cursor is 4 off the top or bottom
set nrformats-=octal            " Prevents (in|de)crementing a 0 padded number to octal
set clipboard^=unnamed          " System clipboard support!
set virtualedit=block           " Allow editing in visual block mode
set laststatus=2                " Always show the statusline
set backspace=indent,eol,start  " Vim likes to think this is the 1970s sometimes and won't backspace
set ttyfast                     " Fast terminal connection
set cpoptions+=$                " Shows a dollar sign when changing text
set lazyredraw                  " Don't redraw while executing macros
set fileformats=unix,dos,mac
set encoding=utf-8
set termencoding=utf-8
set formatoptions+=1
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,nbsp:·,trail:·
set autoread                    " Detect when a file has been changed externally
set autochdir                   " Automatically change the cwd when editing a file, switching, etc
set spellfile=~/.vim/custom-dictionary.utf-8.add
set ttymouse=xterm2             " Recognize the mouse inside tmux
if &term =~ '^screen-.*-bce$'   " Background color erase support!
    set t_ut=y
endif
let mapleader=','               " Let leader key be , instead of \
set splitbelow splitright       " Split below or right to the current buffer for sp and vsp respectively
" Vim doesn't escape from insert mode fast enough.
set timeout timeoutlen=1000 ttimeoutlen=100

"}}}
" Colorscheme / Syntax {{{
set synmaxcol=800
filetype plugin indent on
syntax on
let g:hybrid_use_Xresources=1
colorscheme hybrid

" Hybrid Colorscheme better settings {{{2
if (g:colors_name == "hybrid")
    hi! Pmenu ctermfg=137 ctermbg=233 cterm=none
    hi! PmenuSel ctermfg=196 ctermbg=234 cterm=bold
    hi! PmenuSbar ctermfg=000 ctermbg=233 cterm=none
    hi! PmenuThumb ctermfg=137 ctermbg=235 cterm=none
    hi! StatusLine ctermfg=234 ctermbg=136 guifg=#1c1c1c guibg=#af8700
    hi! StatusLineNC ctermfg=234 ctermbg=100 guifg=#1c1c1c guibg=#878700
    hi! MatchParen ctermfg=196 ctermbg=234 cterm=bold
endif
""}}}2

"}}}
" Status Line {{{
set statusline=\ \%{&ff}\ \%{&fenc}\ buf\:\%1.3n\ \%{tagbar#currenttag('[%s]','')}
set statusline+=\ %{SyntasticStatuslineFlag()}
set statusline+=\ \%#StatusRO#\%R\ \%#StatusHLP#\%H\ \%#StatusPRV#\%W
set statusline+=\ \%#StatusModFlag#\%M\ \ \%{fugitive#statusline()}
set statusline+=\%=\ \%#StatusLine#\%f\ \|\ \%#StatusFTP#\%Y\ \|\ \%p%%\ \|
set statusline+=\ LN\ \%1.7l\:\%1.7c\ 

"}}}
" Search Settings {{{
nnoremap / /\v
xnoremap / /\v
set incsearch
set smartcase
set ignorecase
set showmatch
set matchtime=2  " 2 tenths of a second to show the matching paren (instead of 5)
set hlsearch     " highlight matches

"}}}
" Tab, Indent and Folds {{{
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set cindent
set shiftround
set textwidth=80
set nofoldenable
set foldmethod=indent
"}}}
" Completions {{{
set wildmenu
set wildmode=full
set wildchar=<Tab>
set completeopt+=longest
set previewheight=4
set omnifunc=syntaxcomplete#Complete

" }}}
" Wildignore {{{
if has('wildignorecase')
    set wildignorecase
endif
set wildignore+=.hg,.git,.svn,*.pyc,*.spl,*.out,*.DS_Store
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.bmp,*.zip,*.so,*.swp,*/tmp/*
set wildignore+=*.o,*.obj,*.manifest,*~,#*#,*.sw?,%*,*=

"}}}
"Backup settings {{{
set noswapfile
set history=1000
set backup
set backupdir=~/.vim/backup/
set undofile
set undodir=~/.vim/backup/undo/
set undolevels=1000

"}}}
" GUI Settings {{{
if has("gui_running")
    autocmd! FocusLost * :wa
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guifont=Anonymous\ Pro:h14
endif

"}}}
" Window Management {{{
" -- Switching between windows
nnoremap <silent> <C-h> <C-w><C-h>
nnoremap <silent> <C-j> <C-w><C-j>
nnoremap <silent> <C-k> <C-w><C-k>
nnoremap <silent> <C-l> <C-w><C-l>
" -- Moving windows
nnoremap <silent> <leader>sh <C-W>H
nnoremap <silent> <leader>sj <C-W>J
nnoremap <silent> <leader>sk <C-W>K
nnoremap <silent> <leader>sl <C-W>L
" -- Closing windows
nnoremap <silent> <leader>cc :close<CR>
nnoremap <silent> <leader>cq :cclose<CR>
nnoremap <silent> <leader>ch :wincmd h<CR>:close<CR>
nnoremap <silent> <leader>cj :wincmd j<CR>:close<CR>
nnoremap <silent> <leader>ck :wincmd k<CR>:close<CR>
nnoremap <silent> <leader>cl :wincmd l<CR>:close<CR>

" Automatically resize splits
au! WinEnter * setlocal winfixheight
au! WinEnter * wincmd =

" }}}
" Plugin Preferences and Mappings {{{

" Neosnippet
inoremap <C-k>     <Plug>(neosnippet_expand_or_jump)
xnoremap <C-k>     <Plug>(neosnippet_expand_target)
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
  endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" Haskellmode
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" Tagbar
let g:tagbar_expand=1
let g:tagbar_compact=1
let g:tagbar_width=35
nnoremap <silent> <F1> :TagbarToggle<CR>

" Syntastic
let g:syntastic_auto_loc_list=0
let g:syntastic_loc_list_height=4
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_javascript_checkers=['jslint']
let g:syntastic_mode_map = {'mode': 'active',
            \ 'active_filetypes': ['c', 'cpp', 'java', 'ruby', 'perl', 'haskell', 'javascript'],
            \ 'passive_filetypes': ['python', 'objc', 'objcpp'] }

" Supertab
let g:SuperTabCrMapping=0
let g:SuperTabClosePreviewOnPopupClose=1
let g:SuperTabMappingForward='<S-Tab>'
let g:SuperTabMappingBackward='<Tab>'

" Python-mode
let g:pymode_doc=1
let g:pymode_doc_key='K'
let g:pymode_lint=1
let g:pymode_lint_checker="pyflakes,pep8"
let g:pymode_lint_write=1
let g:pymode_syntax=1
let g:pymode_syntax_all=1
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_folding=0
let g:python_run_key='<leader>R'
let g:pymode_lint_message=1
let g:pymode_lint_cwindow = 0
let g:pymode_rope = 1

" Clang_Complete
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_close_preview=1
let g:clang_complete_patterns=1
let g:clang_complete_macros=1

" Tabular
xnoremap <leader>t :Tabular<space>/

" Ctrlp
nnoremap <leader>F :CtrlP<CR>
nnoremap <leader>f :CtrlPCurWD<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>k :CtrlPMRUFiles<CR>
nnoremap <leader>t :CtrlPTag<CR>
nnoremap <leader>T :CtrlPBufTag<CR>
nnoremap <leader>w :CtrlPLine<CR>
let g:ctrlp_extensions = ['tag', 'line']
let g:ctrlp_map='<F3>'
let g:ctrlp_mruf_max=25
let g:ctrlp_max_files=10000
let g:ctrlp_use_caching=1
let g:ctrlp_max_depth=40
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_cache_dir='~/.cache/ctrlp'
let g:ctrlp_show_hidden=1
let g:ctrlp_follow_symlinks=1
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_root_markers = ['tags']

"}}}
" Vim Niceties {{{

" Reselect visual block after indent/outdent
xnoremap < <gv
xnoremap > >gv

" Open folds when searching, always centering the cursor.
nnoremap n nzzzv
nnoremap N Nzzzv

" Force save files requiring root permissions
cmap w!! %!sudo tee > /dev/null %

" Select the line that was last pasted
nnoremap <leader>V V`]

" select the entire line but ignore the indentation
nnoremap vv ^vg_

" Splits a line -- opposite of J (join lines)
nnoremap ,sp i<cr><esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

" Map jk to move between visual lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Keep search pattern at the center of the screen
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Reformat a C/C++/Obj-C file with astyle (Uses .astylerc for 1TBS)
command! -nargs=0 Format call AStyleFormat()
function! AStyleFormat()
    if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'objc'
        :%!astyle
    endif
endfunction

" Haskell syntax
let hs_highlight_boolean=1
let hs_highlight_types=1
let hs_highlight_more_types=1
let hs_highlight_debug=1
let hs_allow_hash_operator=1

" C Syntas
let c_space_errors = 1
let c_comment_strings = 1

" Java syntax 
let java_highlight_java_lang_ids=1
let java_highlight_java_io=1
let java_highlight_util=1
let java_highlight_java=1
let java_highlight_debug=1
let java_allow_cpp_keywords=1

" Python sytax
let python_highlight_builtins=1
let python_highlight_exceptions=1
let python_highlight_space_errors=1

" Perl syntax
let perl_extended_vars=1

" }}}
" General Mappings {{{

" Restore , for searching with f/F/t/T
nnoremap \ ,

" Use the arrow keys to move around quickfix list keeping the cursor in the
" middle.
nnoremap <up> :lprev<CR>zvzz
nnoremap <down> :lnext<CR>zvzz
nnoremap <left> :cprev<CR>zvzz
nnoremap <right> :cnext<CR>zvzz
inoremap <up> <Esc>
inoremap <down> <Esc>
inoremap <left> <Esc>
inoremap <right> <Esc>

" Screw Ex-mode
nnoremap Q gq

" Readline-line movement for command mode
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" Quickly edit stuff
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <silent> <leader>ez :e ~/.zshrc<CR>
nnoremap <silent> <leader>et :e ~/.tmux.conf<CR>

" Reindent entire file and return cursor to the same line
nnoremap <leader>ef maggVG=`a

" Never felt the need to use H or L
nnoremap H ^
nnoremap L $

" UpperCase in insert mode
inoremap <C-u> <esc>mzgUiw`z

nnoremap <sile> <leader>p :set invpaste<CR>:setlocal paste?<CR>

" Remove trailing whitespace
nnoremap <leader>W mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" Use space to toggle folds
nnoremap <Space> za

" Yank to the end of the line
nnoremap Y y$

" Focus only on fold that is on the cursor position
nnoremap <leader>z zMzvzz

"}}}
" Tmux Cursor Bullcrap {{{
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"}}}
" Quick Filetype Settings {{{

" Haskell compiler
augroup haskell
    au!
    au BufEnter *.hs compiler ghc
    au BufEnter *.hs setlocal cmdheight=2
augroup END

" Better CR expansion
autocmd FileType * inoremap {<CR> {<CR>}<Esc>O
autocmd FileType * inoremap (<CR>  (<CR>)<ESC>O

"}}}
" Misc Autocommands {{{
augroup line_return  " Return vim to the last known position
    au!
    au BufreadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   execute "normal! g'\"" |
                \ endif
augroup END
"}}}
