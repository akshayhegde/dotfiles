" File: haskell.vim
" Author: Akshay Hegde
" Description: Adds on and tweaks the default haskell syntax file shipped with Vim.
" Last Modified: December 26, 2015

" Matches: {{{1
syntax match hsTypeSig "[a-z][a-zA-Z']\+\ze\s::"
syntax match hsLambda "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ

" Links: {{{1
highlight default link hsTypeClass Structure
highlight default link hsTypeSig Special
