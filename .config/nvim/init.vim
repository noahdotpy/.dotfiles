""""""""""""""""""""""""""""""""""""""""
" => General setup
""""""""""""""""""""""""""""""""""""""""
syntax on

let mapleader = " "

set encoding=UTF-8

set completeopt-=preview " For No Previews

" Timeout
set timeoutlen=500

" Show line number
set number

" Show relative line numbers
set relativenumber

" Auto indent
set autoindent

" Tab settings
set tabstop=4 " Set tabs to 4 spaces
set shiftwidth=4
set softtabstop=4

" Expand tabs to spaces instead
set expandtab

set smarttab

" Enables mouse on all modes
set mouse=a

" Show tab line even if only 1 file is open
set showtabline=2

" Disable auto comment on next line when adding newline
autocmd FileType * set formatoptions-=cro

" Smart search
set ignorecase
set smartcase

" Search as characters are entered
set incsearch

" System clipboard keybinds
nnoremap <leader>y "*y
nnoremap <leader>p "*p
""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""
call plug#begin()

"{{ Producivity }}
Plug 'tpope/vim-commentary' " For Commenting (gcc & gc)
Plug 'neoclide/coc.nvim'  " Coc auto completion
Plug 'preservim/tagbar' " Tagbar for code navigation
Plug 'jiangmiao/auto-pairs' " Automatically makes/removes pair [ -> []
Plug 'liuchengxu/vim-which-key' " Which-key to show keybinds
Plug 'terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'junegunn/fzf' " General purpose command line fuzzy finder

"{{ Web-Dev }}
Plug 'ap/vim-css-color' " CSS Color Preview
Plug 'mattn/emmet-vim' " Emmet snippets for Vim
Plug 'alvan/vim-closetag' " Vim-closetag for auto-closing tags
Plug 'tpope/vim-surround' " Vim-surround

"{{ Theming }}
Plug 'vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
Plug 'arcticicestudio/nord-vim' " Nord theme
Plug 'projekt0n/github-nvim-theme'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" {{ Other }}
Plug 'tpope/vim-fugitive' " Git integration (:Git {command})
Plug 'tc50cal/vim-terminal' " Vim Terminal
Plug 'preservim/nerdtree' " NerdTree file explorer
Plug 'lifepillar/pgsql.vim' " Syntax highlighting & auto-completion for PostgreSQL
Plug 'glepnir/dashboard-nvim' " Dashboard shown if no file specified

call plug#end()
""""""""""""""""""""""""""""""""""""""""
" => Set colorscheme
""""""""""""""""""""""""""""""""""""""""
colorscheme tokyonight
""""""""""""""""""""""""""""""""""""""""
" => Source other files
""""""""""""""""""""""""""""""""""""""""
source $HOME/.config/nvim/airline.vim
source $HOME/.config/nvim/closetag.vim
source $HOME/.config/nvim/which-key.vim
source $HOME/.config/nvim/coc.vim
source $HOME/.config/nvim/nerdtree.vim
source $HOME/.config/nvim/tagbar.vim
""""""""""""""""""""""""""""""""""""""""
" => Splits and tabbed files
""""""""""""""""""""""""""""""""""""""""
set splitbelow splitright

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make adjusting split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>

" Change 2 splits windows from vert to horiz or horiz to vert
map <leader>th <C-w>t<C-w>h
map <leader>tk <C-w>t<C-w>k
""""""""""""""""""""""""""""""""""""""""
" => Tab - Indent, S-Tab - Unindent
""""""""""""""""""""""""""""""""""""""""
nnoremap <Tab> >>
nnoremap <S-Tab> <<
xnoremap <Tab> >
xnoremap <S-Tab> <
""""""""""""""""""""""""""""""""""""""""
" => Leader+A to select whole file
""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>a gg <S-v> G
""""""""""""""""""""""""""""""""""""""""
" => Comment Keybinds
""""""""""""""""""""""""""""""""""""""""
noremap <leader>c :Commentary<CR>
""""""""""""""""""""""""""""""""""""""""
" => Open terminal inside Vim
""""""""""""""""""""""""""""""""""""""""
map <leader>tt :vnew term://zsh<CR>
""""""""""""""""""""""""""""""""""""""""
" => Neovide Configs
""""""""""""""""""""""""""""""""""""""""
let g:neovide_cursor_animation_length=0.05
let g:neovide_cursor_trail_length=0.8
""""""""""""""""""""""""""""""""""""""""
" => Other
""""""""""""""""""""""""""""""""""""""""
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
