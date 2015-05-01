" Daniel Oosthuizen
" My .vimrc file!
" Pathogen {{{
execute pathogen#infect()
filetype plugin indent on
" }}}
" Misc. Settings {{{
set ruler laststatus=2 relativenumber title wildmenu lazyredraw cursorline
set tabstop=4 softtabstop=4 expandtab
" }}}
" Colour Scheme {{{ 
let g:solarized_termcolors=16
set t_Co=16
syntax enable
set background=dark
colorscheme solarized

" let &colorcolumn=join(range(81,999),",")

" }}}
" Tabs and Indentation {{{
set hlsearch incsearch
set autoindent smartindent
filetype indent on
" }}}
" Folding {{{ 
set foldmethod=marker
nnoremap <space> za
" }}}
" Mappings {{{
" Leader Mappings {{{
let localleader = ","
let mapleader="\\"
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>n :call ToggleNumber()<CR> " Toggles between 'relativenumber' and 'number'
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" SILVER SEARCHER {{{
" e    to open file and close the quickfix window
" o    to open (same as enter)
" go   to preview file (open but maintain focus on ag.vim results)
" t    to open in new tab
" T    to open in new tab silently
" h    to open in horizontal split
" H    to open in horizontal split silently
" v    to open in vertical split
" gv   to open in vertical split silently
" q    to close the quickfix window
nnoremap <leader>a :Ag! 
" }}}
" }}}
" Misc. Mappings {{{
" Preferable way to get out of INSERT mode!
inoremap jk <esc>

nnoremap E $
nnoremap B ^
nnoremap $ <nop>
nnoremap ^ <nop>

" Navigating splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Training myself to use jkhl!
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop> 
inoremap <Right> <nop> 

nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop> 
nnoremap <Right> <nop> 
" }}}
" }}}
" Autogroups {{{
augroup configgroup
        autocmd!
        autocmd BufWritePost .vimrc source %
        autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.mdcall call <SID>StripTrailingWhitespaces()
augroup END
" }}}
" Custom Functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
        if(&relativenumber == 1)
                set norelativenumber
                set number
        else
                set nonumber
                set relativenumber
        endif
endfunc

" strips trailing whitespace at the end of files. this
" " is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
     " save last search & cursor position
        let _s=@/
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        let @/=_s
        call cursor(l, c)
endfunction
" }}}
" Airline {{{
let g:airline#extensions#tabline#enabled = 1 
let g:airline_powerline_fonts = 1
" }}}
" Gundo {{{
nnoremap <leader>u :GundoToggle<CR> " Super Undo! Uses Gundo by Steve Losh
" }}}
" Yankring {{{
nnoremap <leader>p :YRShow<CR> " Displays the yankring 
" }}}
" Instant Markdown {{{
""let g:instant_markdown_slow = 1
" }}}
