" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" -- PLUGINS --

Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/CtrlP.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'hashivim/vim-hashicorp-tools'
Plugin 'junegunn/vim-easy-align'
Plugin 'majutsushi/tagbar'
"Plugin 'OmniSharp/omnisharp-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'thaerkh/rainbow_parentheses.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/DrawIt'
Plugin 'Xuyuanp/nerdtree-git-plugin'


call vundle#end()            " required
filetype plugin indent on    " required

"------------------------------------------------------------------------------
" Plugin specific config
"------------------------------------------------------------------------------

" Vim-Colors-Solarized
" --------------------
set background=dark
colorscheme solarized

" Syntastic
" ---------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_w = 0
let g:syntastic_check_on_wq = 0

" let g:syntastic_python_flake8_args = "--max-complexity 10"

command! Nostyle let g:syntastic_quiet_messages = { "type": "style" } | edit
command! Style let g:syntastic_quiet_messages = { } | edit


" Easy Align
" ----------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Jedi
" ----
let g:jedi#smart_auto_mappings = 0

" NERDtree
" --------
nmap <C-n>  :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\.meta$']

" Fugitive
" --------
set diffopt+=vertical

" Supertab
" --------
let g:SuperTabDefaultCompletionType = "<c-n>"

" Airline
" -------
let g:airline_powerline_fonts = 1
set laststatus=2 " Makes airlien load correctly, somehow

" Ctrlp
" -----
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/]\.(pyc|meta)$'

" Tagbar
" ------
nmap <C-t> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

"------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
"------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line

" make backspaces more powerfull
set backspace=indent,eol,start

set ruler               " show line and column number
syntax on   			" syntax highlighting
set showcmd 			" show (partial) command in status line

" Enable undo and backup
set undofile
set undolevels=100
set undoreload=1000
set backup

" Store vim files in their own location
silent !mkdir -p $HOME/vim/backup
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "p")
endif
set backupdir=~/.vim/backup,/tmp
if !isdirectory($HOME."/.vim/swp")
    call mkdir($HOME."/.vim/swp", "p")
endif
set directory=~/.vim/swp
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p")
endif
set undodir=~/.vim/undo

" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" Make coppy buffer better
set viminfo-=<50,s10

"Mak the <TAB> menu background distainct from main terminal BG
highlight Pmenu ctermbg=darkgrey

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Gutter + word wrap
set textwidth=80
let &l:colorcolumn="+".join(range(1,999),",+")

" Use underline for spell check
hi SpellBad cterm=underline
