" File: haskell.vim
" Author: Akshay Hegde
" Description: Adds on and tweaks the default haskell syntax file shipped with Vim.
" Last Modified: December 26, 2015

" Matches: {{{1
syntax match hsTypeSig "[a-z][a-zA-Z']\+\ze\s::"

" Keywords: {{{1
" Defines some more types to syntax highlight
syntax keyword hsTypeClass
      \ Bounded
      \ Eq
      \ Enum
      \ Floating
      \ Integral
      \ Num
      \ Ord
      \ Read
      \ RealFloat
      \ RealFrac
      \ Show

syntax keyword hsTypes
      \ Just
      \ Maybe
      \ Nothing

" Links: {{{1
highlight default link hsTypeClass Structure
highlight default link hsTypes Type
highlight default link hsTypeSig Function
