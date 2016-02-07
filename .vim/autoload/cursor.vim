" Changes the cursor shape between insert and normal modes.
" These escape codes are iTerm2 specific.
function! cursor#changeShape()
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endfunction
