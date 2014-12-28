" File: haskell.vim
" Author: Akshay Hegde
" Description: Adds on and tweaks the default haskell syntax file shipped with Vim.
" Last Modified: December 26, 2015

" Matches: {{{1
syntax match hsTypeSig "[a-z][a-zA-Z']\+\ze\s::"
syntax match hsLambda "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ

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

syntax keyword preludeFunction abs all and any atan break ceiling
      \ chr compare concat concatMap const cos digitToInt div drop
      \ dropWhile elem error even exp filter flip floor foldl foldr
      \ foldl1 foldr1 fromInt fromInteger fst gcd head id init isAlpha
      \ isDigit isLower isSpace isUpper iterate last lcm length lines
      \ log map max maximum min minimum mod not notElem null odd or
      \ pi pred putStr putStrLn product quot rem repeat replicate
      \ reverse round show sin snd sort span splitAt sqrt subtract
      \ succ sum tail take takeWhile tan toLower toUpper truncate
      \ undefined unlines until unwords words zip zipWith

" Links: {{{1
highlight default link hsTypeClass Structure
highlight default link hsTypes Type
highlight default link hsTypeSig Function
highlight default link preludeFunction Function
