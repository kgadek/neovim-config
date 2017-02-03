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

"===============================================================================
" Plugins
"===============================================================================
" Using vim-plug for management -- https://github.com/junegunn/vim-plug
"-------------------------------------------------------------------------------
call plug#begin('~/.nvim/vim-plug')

Plug 'neomake/neomake'
Plug 'tpope/vim-surround'
Plug 'haya14busa/incsearch.vim'
Plug 'godlygeek/tabular'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'sjl/badwolf/'
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-fugitive', { 'do': ':helptags ~/.nvim/vim-plug/vim-fugitive/doc' }

" Haskell
Plug 'Shougo/vimproc.vim', { 'do': 'make' } | Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }

call plug#end()

" Customization
"-------------------------------------------------------------------------------

" badwolf
colorscheme badwolf

" haya14busa/incsearch.vim
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" ctrlp
map <silent> <leader>p :CtrlP()
noremap <leader>bp :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = '\v[\/]dist$'

" deoplete
let g:deoplete#enable_at_startup = 1

" NERDTree
map <leader>n :NERDTreeToggle

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["usnippets"]

" tagbar
nmap <leader>t :TagbarToggle

" Haskell
"===============================================================================
" First, install tools:
"   stack install hlint ghc-mod hdevtools pointfree fast-tags
"   syspip3 install --user --upgrade neovim
" Second, prepare the wrapper script called pointfreexargs:
"   #!/bin/bash
"   myvar=`cat`
"   pointfree "$myvar"
" Third, use this wrapper script called init-tags:
"   #!/bin/zsh
"   # fast-tags wrapper to generate tags automatically if there are none.
"   # https://github.com/elaforge/fast-tags/blob/master/init-tags
"   
"   setopt extended_glob
"   
"   fn=$1
"   if [[ ! -r tags ]]; then
"       echo Generating tags from scratch...
"       exec fast-tags **/*.hs
"   else
"       exec fast-tags $fn
"   fi

augroup AugHaskell
  autocmd!
  au BufWritePost *.hs silent !init-tags %
  autocmd FileType haskell call SetHaskellFilesOptions()
augroup END

function! SetHaskellFilesOptions()
  autocmd BufEnter set formatprg=pointfreexargs

  " Neomake
  autocmd BufWritePost <buffer> Neomake
  " neco-ghc
  setlocal omnifunc=necoghc#omnifunc
  " tabular
  vmap <leader>a= :Tabularize /=
  vmap <leader>a; :Tabularize /::
  vmap <leader>a- :Tabularize /->
  " GHC-Mod
  map <silent> <leader>mi :GhcModTypeInsert<CR>
  map <silent> <leader>ms :GhcModSplitFunCase<CR>
  map <silent> <leader>mt :GhcModType<CR>
  map <silent> <leader>mx :GhcModTypeClear<CR>
endfunction

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.haskell = 'necoghc#omnifunc'


" tagbar
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }
