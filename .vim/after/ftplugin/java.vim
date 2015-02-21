" General settings
setlocal makeprg=javac\ %
command! -nargs=0 Format call format#file()
