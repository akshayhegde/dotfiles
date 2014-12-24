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
  if a:arrangement ==? "horizontal"
    if len(filter(map(range(bufnr('$')), 'buflisted(v:val)'), 'v:val == 1')) > 1
      return ":buffer \<C-z>\<S-Tab>"
    else
      return ":buffer "
    endif
  elseif a:arrangement ==? "vertical"
    if len(filter(map(range(bufnr('$')), 'buflisted(v:val)'), 'v:val == 1')) > 1
      return ":vertical sbuffer \<C-z>\<S-Tab>"
    else
      return ":vertical sbuffer "
    endif
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
