"===============================================================================
" Personalization
"===============================================================================
set number " line numbers
set shiftwidth=2 tabstop=2 expandtab smarttab
set smartindent
set scrolloff=3
set incsearch
set backspace=2 " backspace: work for auto-indentations
set breakindent " preserve indentation on breaking
set nohls
set cc=100
set mouse=a
set iskeyword+=-

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" Include custom syntax highlighing rules (add early to override default ones)
"-------------------------------------------------------------------------------
let &runtimepath='~/.config/nvim/syntax,'.&runtimepath
"filetype off
syntax on
filetype plugin indent on " enable file detect, load plugins & indentation files

" Key mappings
"-------------------------------------------------------------------------------
let mapleader = ","

" Interop with OS clipboard
map <leader>yy "*y
map <leader>yp "*p

" Tabs
"nnoremap <C-Left> :tabprevious<CR>
"nnoremap <C-Right> :tabnext<CR>
"nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
"cabbrev tabv tab sview +setlocal\ nomodifiable

"===============================================================================
" Plugins
"===============================================================================
" Using vim-plug for management -- https://github.com/junegunn/vim-plug
"-------------------------------------------------------------------------------
call plug#begin('~/.nvim/vim-plug')

"Plug 'vim-syntastic/syntastic'
Plug 'neomake/neomake'
Plug 'tpope/vim-surround'
Plug 'haya14busa/incsearch.vim'
Plug 'godlygeek/tabular'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips', { 'do': 'env PIP_REQUIRE_VIRTUALENV= pip3 install neovim' }
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'sjl/badwolf/'
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-fugitive', { 'do': ':helptags ~/.nvim/vim-plug/vim-fugitive/doc' }
"Plug 'bitc/lushtags', { 'do': 'stack install --install-ghc' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'sheerun/vim-polyglot'
Plug 'Rykka/riv.vim'

" Ansible
Plug 'pearofducks/ansible-vim'

" Haskell
"Plug 'Shougo/vimproc.vim', { 'do': 'make' } | Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }

" Rust
Plug 'rust-lang/rust.vim'

" Scala
"Plug 'derekwyatt/vim-scala'

call plug#end()

" Customization
"-------------------------------------------------------------------------------

" Enable fzf
set rtp+=/usr/local/opt/fzf

set cursorline
set cursorcolumn

" vim-fugitive
set diffopt+=vertical

" badwolf
colorscheme badwolf
set background=dark

" vim-airline
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1

" haya14busa/incsearch.vim
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" ctrlp
map <silent> <leader>p :CtrlP()
noremap <leader>bp :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = '\v[\/]dist$'
let g:ctrlp_user_command = ['.git', 'cd %s; and git ls-files -co --exclude-standard']
let g:ctrlp_extensions = ['line']

" deoplete
let g:deoplete#enable_at_startup = 1

" NERDTree
map <leader>n :NERDTreeToggle
let g:NERDTreeMouseMode=2  " toggle dirs with single click

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["usnippets"]

" tagbar
nmap <leader>t :TagbarToggle

" dash
let g:dash_map = { 'haskell': 'ha' }
nmap <silent> <leader>d <Plug>DashSearch


" Haskell
"===============================================================================
" First, install tools:
"   stack install hlint ghc-mod hdevtools pointfree hpack
"   syspip3 install --user --upgrade neovim
" Second, prepare the wrapper script called pointfreexargs:
"   #!/bin/bash
"   myvar=`cat`
"   pointfree "$myvar"

" augroup AugHaskell
"   autocmd!
"   autocmd FileType haskell call SetHaskellFilesOptions()
" augroup END
" 
" function! SetHaskellFilesOptions()
"   autocmd BufEnter set formatprg=pointfreexargs
" 
"   " Neomake
"   autocmd BufWritePost <buffer> Neomake
"   " neco-ghc
"   setlocal omnifunc=necoghc#omnifunc
"   " tabular
"   vmap <leader>a= :Tabularize /=
"   vmap <leader>a; :Tabularize /::
"   vmap <leader>a- :Tabularize /->
"   vmap <leader>aa :Tabularize /\<as\>
"   " GHC-Mod
"   map <silent> <leader>mi :GhcModTypeInsert<CR>
"   map <silent> <leader>ms :GhcModSplitFunCase<CR>
"   map <silent> <leader>mt :GhcModType<CR>
"   map <silent> <leader>mx :GhcModTypeClear<CR>
" endfunction
" 
" let g:deoplete#omni#functions = {}
" let g:deoplete#omni#functions.haskell = 'necoghc#omnifunc'

" Rust
"===============================================================================
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" Shell
"===============================================================================
autocmd FileType sh setlocal shiftwidth=4 tabstop=4
