" File: haskell.vim
" Author: Akshay Hegde
" Description: Adds on and tweaks the default haskell syntax file shipped with Vim.
" Last Modified: December 26, 2015

" Matches: {{{1
syntax match hsFunction "\w\+'\?\ze ::"

" Keywords: {{{1
" Defines some more types to syntax highlight
syntax keyword hsTypes
      \ Maybe
      \ Just
      \ Nothing
      \ Num
      \ Integral
      \ Double
      \ False
      \ True

highlight default link hsTypes Type
highlight default link hsFunction Function
