setlocal makeprg=csslint\ --format=compact\ %
let &errorformat = '%-G,%-G%f: lint free!,%f: line %l\, col %c\, %trror - %m,' .
      \ '%f: line %l\, col%c\, %tarning - %m,%f: line %l\, col %c\, %m,'
