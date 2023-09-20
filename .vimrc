" Bootstrap vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Core functionality plugins
Plug 'chriskempson/base16-vim'
Plug 'ervandew/supertab'
Plug 'dense-analysis/ale'
Plug 'OmniSharp/omnisharp-vim'
" UI plugins
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Utility/action plugions
Plug 'SirVer/ultisnips'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'ctrlpvim/CtrlP.vim'
Plug 'vim-scripts/DrawIt'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'prabirshrestha/vim-lsp'
" Language and library support pluins
Plug 'davidhalter/jedi-vim'
Plug 'sirtaj/vim-openscad'
Plug 'davisdude/vim-love-docs', {'branch': 'build'}
" Misc tools
Plug 'puremourning/vimspector'
Plug 'hashivim/vim-hashicorp-tools'
call plug#end()

"------------------------------------------------------------------------------
" Plugin specific config
"------------------------------------------------------------------------------

" Vim-Colors-Solarized
" --------------------
"set background=light
" if system("~/.zsh_themes/is_term_dark.sh")
"   set background=dark
" endif
" colorscheme solarized
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" ALE
" ---
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
let g:ale_c_parse_makefile = 1


" Easy Align
" ----------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


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

" Vimpsector
" -----
let g:vimspector_enable_mappings = 'HUMAN'

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

" Add relative line numbers
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Enable undo and backup
set undofile
set undolevels=100
set undoreload=1000
set backup

" Store vim files in their own location
silent !mkdir -p ~/.vim/backup
set backupdir=~/.vim/backup,/tmp
silent !mkdir -p ~/.vim/swp
set directory=~/.vim/swp
silent !mkdir -p ~/.vim/undo
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
" hi NonText ctermbg=0

" Use underline for spell check
hi SpellBad cterm=underline
set spellfile=~/.vim/spell.utf-8.add

" Usaeable mouse
set mouse=v
