" Daniel Oosthuizen's .nvimrc (2016)
" Setting up Vundle {{{
   let bundleExists = 1
  if (!isdirectory(expand("$HOME/.vim/bundle/neobundle.vim")))
     call system(expand("mkdir -p $HOME/.vim/bundle"))
     call system(expand("git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim"))
     let bundleExists = 0
  endif

  if 0 | endif

  if has('vim_starting')
    if &compatible
      " Be iMproved
      set nocompatible
    endif

" Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif

" Required:
  call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
  NeoBundleFetch 'Shougo/neobundle.vim'
 " syntax
  " NeoBundle 'wavded/vim-stylus'
  " NeoBundle 'tpope/vim-markdown'
  " NeoBundle 'scrooloose/syntastic'
  " NeoBundle 'tmux-plugins/vim-tmux'
  " NeoBundle 'digitaltoad/vim-jade'
  " NeoBundle 'othree/yajs.vim'
  " NeoBundle 'pangloss/vim-javascript'
  " NeoBundle 'mxw/vim-jsx'
  " NeoBundle '1995eaton/vim-better-javascript-completion'
  " NeoBundle 'nikvdp/ejs-syntax',{'autoload':{'filetypes':['ejs']}}
  " NeoBundle 'elzr/vim-json'
  " NeoBundle 'othree/javascript-libraries-syntax.vim'
" Typescript
  " NeoBundle 'leafgarland/typescript-vim'
  " NeoBundle 'Shougo/vimproc.vim', {
  "      \ 'build' : {
  "      \     'windows' : 'tools\\update-dll-mingw',
  "      \     'cygwin' : 'make -f make_cygwin.mak',
  "      \     'mac' : 'make -f make_mac.mak',
  "      \     'linux' : 'make',
  "      \     'unix' : 'gmake',
  "      \    },
  "      \ }

" colorscheme & syntax highlighting
  " NeoBundle 'sjl/badwolf'
  NeoBundle 'altercation/vim-colors-solarized'
  " NeoBundle 'gosukiwi/vim-atom-dark'
  " NeoBundle 'mhartington/oceanic-next'
  " NeoBundle 'kien/rainbow_parentheses.vim'
  " NeoBundle 'chrisbra/Colorizer'
  NeoBundle 'Yggdroot/indentLine'
  NeoBundle 'jiangmiao/auto-pairs'
  " NeoBundle 'valloric/MatchTagAlways'
 " Git helpers
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'Xuyuanp/nerdtree-git-plugin'

" untils
  " NeoBundle 'matze/vim-move'
  " NeoBundle 'editorconfig/editorconfig-vim'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'terryma/vim-multiple-cursors'
  " NeoBundle 'ctrlpvim/ctrlp.vim'
  " NeoBundle 'christoomey/vim-tmux-navigator'
  NeoBundle 'vim-airline/vim-airline'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'sjl/gundo.vim'
  " NeoBundle 'tomtom/tcomment_vim'
  " NeoBundle 'mattn/emmet-vim'
  " NeoBundle 'Chiel92/vim-autoformat'
  " NeoBundle 'Shougo/neocomplete.vim'
  " NeoBundle 'Quramy/tsuquyomi'

  " NeoBundle 'rking/ag.vim'
  " NeoBundle 'mileszs/ack.vim'
  " " NeoBundle 'ashisha/image.vim'
  " NeoBundle 'Shougo/neosnippet'
  " NeoBundle 'Shougo/neosnippet-snippets'
  " NeoBundle 'matthewsimo/angular-vim-snippets'
  NeoBundle 'ryanoasis/vim-webdevicons'
  " NeoBundle 'guns/xterm-color-table.vim'
  " NeoBundle 'sjl/clam.vim'
  " NeoBundle 'vim-scripts/CSApprox'
  " NeoBundle 'fmoralesc/vim-tutor-mode'
  call neobundle#end()

" Required:
  filetype plugin indent on
  NeoBundleCheck
  if bundleExists == 0
    echo "Installing Bundles, ignore errors"
  endif
" }}}
" Other (miscellaneous) settings {{{
  " Miscellaneous
    set number relativenumber
    set visualbell cursorline
    set colorcolumn=80
    set textwidth=79

  " Colorscheme
    set t_Co=16
    syntax enable
    colorscheme solarized
    " highlight the current line number
    " highlight CursorLineNR guifg=#ffffff ctermfg=15
    set background=dark
    " let g:badwolf_tabline = 1
    " let g:badwolf_darkgutter = 1

  " Show invisibles
    set list!
    set listchars=tab:▸\ ,eol:¬
    highlight NonText guifg=#4a4a59
    highlight SpecialKey guifg=#4a4a59

  " Tabs and indentation
    set hlsearch incsearch
    set autoindent smartindent
    set tabstop=2 softtabstop=2 expandtab shiftwidth=2

  " Airline
    set guifont=Ubuntu\ Mono\ derivative\ Powerline:h20
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    set laststatus=2
" }}}
" Mappings {{{
  " Leader Mappings
    let localleader = ","
    let leader = "\\"
    nnoremap <leader><space> :nohlsearch<CR>
    nnoremap <leader>ev :vsplit $HOME/.config/nvim/init.vim<CR>
    nmap <leader>l :set list!<CR>
    nnoremap <leader>w :set formatoptions+=a<CR>
    nnoremap <leader>ww :set formatoptions-=a<CR>

  " Movement
    " inoremap jk<esc>
    " (the relic of a broken finger)
    inoremap jl <esc>
    nnoremap E $
    nnoremap B ^

  " Navigating splits
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

  " Navigating buffers
    nnoremap <leader>p :bn<CR>
    nnoremap <leader>P :bp<CR>

  " Folding
    set foldmethod=marker
    nnoremap <space> za

  " Gundo
    nnoremap <leader>u :GundoToggle<CR>

  " Terminal mode
    tnoremap <leader>e <C-\><C-n>

  " NerdTree
    nnoremap <leader>n :NERDTreeToggle<CR>
" }}}
" Autogroups {{{
    augroup configgroup
      autocmd!
      " autocmd BufWritePost ~/.config/nvim/init.vim source %
      autocmd BufWritePre * call <SID>StripTrailingWhitespaces()
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      autocmd BufWritePost ~/.config/nvim/init.vim :source ~/.config/nvim/init.vim
      augroup END
" }}}
" Custom Functions {{{
  " Strip trailing whitespace
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
