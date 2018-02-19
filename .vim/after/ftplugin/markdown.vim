setlocal spell
setlocal textwidth=80

command! -buffer Preview silent execute "!open -a Markoff.app %" | redraw!
