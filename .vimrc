set mouse=
set number
set scrolloff=7
set autoread
set incsearch
set hlsearch
"set smartindent
set autoindent
syntax on


" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz


set foldmethod=syntax
set foldlevel=99
let xml_syntax_folding=1

" force markdown for .md files ( https://github.com/tpope/vim-markdown )
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" don't hide long lines by showing @ characters ( http://stackoverflow.com/questions/21955785/why-does-vim-hide-wrapped-lines-and-prints-multiple-s )
:set display+=lastline

" auto-reload vim configs when they're changed (cross-platform), from http://stackoverflow.com/a/2403926
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" for python files: tab = 4 spaces ( http://stackoverflow.com/a/9986497 )
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
