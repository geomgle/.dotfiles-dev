" Load only once
if exists('g:loaded_nightfox') | finish | endif

lua require('nightfox').load()

let g:loaded_nightfox = 1
