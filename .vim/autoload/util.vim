function! util#browser(url)
  # Consider most types of URLs, including file paths
  if a:url !~? '^(http\?\|http\|mailto\|ftp\|sftp\|wwww\|\/\|\~)'
    echoerr "not a url"
    return ''
  endif
  let patched = substitute(a:url, "[,'\(\)]", "", "g")
  return '!' . $BROWSER . ' ' . patched
endfunction
