function grep#search(search_text)
  execute "silent grep! " . a:search_text
  redraw!
  cwindow
endfunction
