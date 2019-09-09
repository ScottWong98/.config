"==========================================
"====== Auto load for first time use ======
"==========================================
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



"============================
"====== basic settings ======
"============================
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gb18030,utf-16,big5
syntax on
let &t_ut=''
set ai si ts=4 sw=4  "auto/smart indet, tabstop, shiftwidth
set softtabstop=4
set tw=0 indentexpr=
set list listchars=tab:▸\ ,trail:▫
set nu relativenumber
set cursorline
set showcmd ls=2 "laststatus
set hlsearch incsearch ignorecase smartcase
exec "nohlsearch"
set autochdir
set splitright
"set splitbelow
exec "nohlsearch"

silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo,.
endif

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



"==============================
"====== Terminal Behavior =====
"==============================
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert


"=========================
"====== key-mapping ======
"=========================
let mapleader=" "
nnoremap <LEADER>r :source /home/scott/.config/nvim/init.vim<CR>

"trun off hightlight in search
nnoremap <LEADER><CR> :nohlsearch<CR> 

nnoremap <LEADER>w :w<CR>
nnoremap <LEADER>q :q<CR>
nnoremap <LEADER>Q :q!<CR>

"open a new window in right direction
" vertically split window to right
nnoremap <LEADER>v :set splitright<CR>:vs<CR>

"Move cursor in windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" make horizontal window to vertical window
nnoremap <LEADER>V <C-w>t<C-w>H

" resize window
nnoremap <left> :vertical resize -5<CR>
nnoremap <right> :vertical resize +5<CR>

" tabe mapping
nnoremap tu :tabe<CR>
nnoremap t- :-tabnext<CR>
nnoremap t= :+tabnext<CR>

" copy in visual mode
vnoremap <C-c> "+y<ESC>



"======================
"====== Snippets ======
"======================
source ~/.config/nvim/snippets.vim



"================================
"====== Other useful stuff ======
"================================
" Opeaning a terminal 
nnoremap <LEADER>/ :set splitright<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
nnoremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Compile
nnoremap <LEADER>c :call MyCompile()<CR>
func! MyCompile()
  exec "w"
  if &filetype == 'cpp'
	  exec "!g++ -W -std=c++11 % -o a"
  elseif &filetype == 'markdown'
	  exec "MarkdownPreview"
  endif
endfunc




"======================
"====== vim-plug ======
"======================
call plug#begin('~/.config/nvim/plugged')
  Plug 'mhinz/vim-startify'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-airline/vim-airline'
  Plug 'mhartington/oceanic-next'
  Plug 'ryanoasis/vim-devicons'
  Plug 'mbbill/undotree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'vim-scripts/fcitx.vim'
call plug#end()




"===========================
"====== plug settings ======
"===========================

"=== Vim-Table-Mode ===
nnoremap <LEADER>tm :TableModeToggle<cr>

"=== UndoTree ===
nnoremap <LEADER>u :UndotreeToggle<cr>

"=== markdown-prerview ===
let g:mkdp_browser = 'chromium'

"=== oceanic-next ===
if (has("termguicolors"))
 set termguicolors
endif

"=== Theme ===
syntax enable
colorscheme OceanicNext
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1


"=== nerdtree ===
"  hot key
nnoremap ff :NERDTreeToggle<CR>
"  icons
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
"  location of nerdtree
let g:NERDTreeWinPos='left'
"  size of nerdtree
let g:NERDTreeSize=30
"  show line number
let g:NERDTreeShowLineNumbers=1
"  don't show hidden files
let g:NERDTreeHidden=0
" open nerdtree even if there is no content in this file
"autocmd vimenter * if !argc()|NERDTree|endif
" shut down nerdtree when it is the only thing in the window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" open nerdtree when the vim is opened
"autocmd vimenter * NERDTree

"=== nerdtree-git-plugin ===
let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "✹",
  \ "Staged"    : "✚",
  \ "Untracked" : "✭",
  \ "Renamed"   : "➜",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ "Unknown"   : "?"
  \ }


"=== airline ===
let g:airline_theme='oceanicnext'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

