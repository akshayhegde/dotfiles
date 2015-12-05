" Format a c/cpp/java file.
" Uses clang-format for C/C++ and astyle for java.
function! format#file()
  let winview = winsaveview()
  let is_c_or_cpp = &filetype =~# 'c\(pp\)\?'
  execute is_c_or_cpp ? "%!clang-format" : "%!astyle --mode=java"
  call winrestview(winview)
endfunction

function! format#reindent()
  let winview = winsaveview()
  keepjumps normal! gg=G
  call winrestview(winview)
endfunction
