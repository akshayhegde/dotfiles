setlocal makeprg=swift\ %
setlocal errorformat=%E%f:%l:%c:\ error:\ %m,%+C%.%#,%-C%p^,%C%.%#

let b:dispath = "swift %"
