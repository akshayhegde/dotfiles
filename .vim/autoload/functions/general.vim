" Format a c/cpp/java file with AStyle
function! functions#general#AStyleFormat()
  norm! mf
  if &filetype == 'c' || &filetype == 'cpp'
    :%!astyle --mode=c
  elseif &filetype == 'java'
    :%!astyle --mode=java
  endif
  norm! `fzz
endfunction

" A simple buffer navigation function.
function! functions#general#bufNav(arrangement)
  let moreThanOneBuffer = len(filter(map(range(bufnr('$')), 'buflisted(v:val)'), 'v:val == 1')) > 1
  if a:arrangement ==? "horizontal"
      return moreThanOneBuffer ? ":buffer \<C-z>\<S-Tab>" : ":buffer "
  elseif a:arrangement ==? "vertical"
      return moreThanOneBuffer ? ":vertical sbuffer \<C-z>\<S-Tab>" : ":vertical sbuffer "
  endif
endfunction

function! functions#general#vSSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\n\n', 'g')
  let @s = temp
endfunction

" Returns a list of the :scriptnames
function! s:names()
  let scripts = ''
  redir => scripts
  execute 'silent! scriptnames'
  redir END
  return scripts
endfunction

" Load :scriptnames into the quickfix list.
function! functions#general#scriptnames()
  let names = s:names()
  let list = []
  for line in split(names, "\n")
    if line =~# ':'
      call add(list, { 'text' : matchstr(line, '\d\+'), 'filename': expand(matchstr(line, ': \zs.*'))})
    endif
  endfor
  return list
endfunction

" Get the buffer list
function! functions#general#bufferList()
  let buflist = []
  for i in range(1, bufnr('$'))
    if bufexists(i)
      let buflist += [bufname(i)]
    endif
  endfor
  return join(map(buflist, 'escape(v:val, " ")'), ' ')
endfunction
