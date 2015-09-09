function! git#branch()
  let l:in_git_workdir  = system("git rev-parse --is-bare-repository") =~# "false"
  if l:in_git_workdir
    return system("git rev-parse --abbrev-ref @ | tr -d '\n'")
  endif
  return ""
endfunction
