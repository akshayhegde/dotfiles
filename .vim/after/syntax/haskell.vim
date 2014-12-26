" File: haskell.vim
" Author: Akshay Hegde
" Description: Adds on and tweaks the default haskell syntax file shipped with Vim.
" Last Modified: December 26, 2015

" Matches: {{{1
syntax match hsTypeSig "\w\+\('\?\(\w\+\)*\)*\ze\s*::"

" Keywords: {{{1
" Defines some more types to syntax highlight
syntax keyword hsTypes
      \ Floating
      \ Integral
      \ Just
      \ Maybe
      \ Nothing
      \ Num
      \ RealFloat
      \ RealFrac
      \ Show

" Links: {{{1
highlight default link hsTypes Type
highlight default link hsTypeSig Function
