let g:git_branch_name = ""

function! git#branch_detect()
  let l:in_git_workdir  = system("git rev-parse --is-bare-repository") =~# "false"
  let g:git_branch_name = in_git_workdir ? system("git rev-parse --abbrev-ref @ | tr -d '\n'") : ""
endfunction

function! git#branch_name()
  return g:git_branch_name
endfunction
