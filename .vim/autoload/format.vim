" Format a c/cpp/java file.
" Uses clang-format for C/C++ and astyle for java.
function! format#file()
  let l:winview = winsaveview()
  let l:is_c_or_cpp = &filetype =~# 'c\(pp\)\?'
  execute l:is_c_or_cpp ? "%!clang-format" : "%!astyle --mode=java"
  call winrestview(l:winview)
endfunction
