" Vim-Plug initialization
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'flazz/vim-colorschemes'
Plug 'preservim/nerdtree'       " File explorer
Plug 'junegunn/fzf'             " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'       " Alternative fuzzy finder
Plug 'jeetsukumaran/vim-buffergator' " Buffer manager
Plug 'mhinz/vim-startify'       " Start screen
Plug 'liuchengxu/vim-which-key' " Show available key bindings
Plug 'christoomey/vim-tmux-navigator' " Seamless Vim & Tmux navigation
Plug 'tpope/vim-fugitive'       " Git wrapper
Plug 'tpope/vim-rhubarb'        " GitHub extension
Plug 'airblade/vim-gitgutter'   " Show Git changes in gutter
Plug 'jiangmiao/auto-pairs'     " Auto-close brackets
Plug 'tpope/vim-surround'       " Edit surrounding quotes, brackets
Plug 'tpope/vim-commentary'     " Code commenting
Plug 'andymass/vim-matchup'     " Advanced matching (includes comments)
Plug 'machakann/vim-sandwich'   " Better surround & matching
Plug 'sheerun/vim-polyglot'     " Syntax support for YAML, JSON, Bash
Plug 'stephpy/vim-yaml'         " YAML support
Plug 'elzr/vim-json'            " JSON highlighting & formatting
Plug 'cespare/vim-toml'         " TOML support
Plug 'vim-airline/vim-airline'  " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree'          " Undo history visualization
Plug 'machakann/vim-highlightedyank' " Highlight copied text
Plug 'arcticicestudio/nord-vim' " Nord theme
Plug 'morhetz/gruvbox'          " Gruvbox theme
Plug 'jiangmiao/auto-pairs'     " Auto close brackets
Plug 'airblade/vim-gitgutter'   " Git changes in gutter
Plug 'arcticicestudio/nord-vim'
Plug 'flazz/vim-colorschemes'

call plug#end()

" run the :PlugInstall command in Vim after adding a new plugin

" Enable color scheme   

syntax enable                   " Enable syntax 
colorscheme nord                " Set colortheme
set background=dark             " Set background
set showmode                    " Show mode in status line
set termguicolors               " Enable better colors
set clipboard=unnamedplus       " Use system clipboard

" Airline theme for Nord
let g:airline_theme='nord'

" Enable Vim-Airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme='nord'

" Basic settings
set number                    " Show line numbers
" set relativenumber            " Relative line numbers
set tabstop=4 shiftwidth=4    " Tab size
set expandtab                 " Use spaces instead of tabs

