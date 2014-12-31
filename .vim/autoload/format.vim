" Format a c/cpp/java file.
" Uses clang-format for C/C++ and astyle for java.
function! format#file()
  norm! mf
  if &filetype == 'c' || &filetype == 'cpp'
    :%!clang-format
  elseif &filetype == 'java'
    :%!astyle --mode=java
  endif
  norm! `fzz
endfunction

