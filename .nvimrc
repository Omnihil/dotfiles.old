if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" Make sure you use single quotes when typing plug names
" Plug 'Valloric/YouCompleteMe'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'tpope/vim-surround'
"Plug 'Yggdroot/indentLine'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/jlanzarotta/bufexplorer'
"Plug 'https://github.com/scrooloose/syntastic'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'MPage'
Plug 'reedes/vim-pencil'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
" Add plugin  call plug#end()s to &runtimepath
call plug#end()

" Enable filetype plugins
filetype indent on
filetype plugin on
syntax enable

if has("gui_running")
    colorscheme solarized
    set guifont=Meslo\ LG\ L\ DZ\ for\ Powerline:h13
    set guioptions-=r
    set background=dark
    colorscheme gruvbox
endif

" Recommend using Neovim with iterm2 on Mac, in that case,
" it should have same colorscheme with iterm2
let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
    set background=dark
elseif os == 'Linux'
    set background=dark
    colorscheme gruvbox
endif

"set numbers
set number
" Map leader to ,
let mapleader = ","
let g:mapleader = ","

" :W sudo saves the file
command! W w !sudo tee % > /dev/null


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => For Neovim interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set to auto read when a file is changed from the outside
set autoread

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

set noswapfile
set nobackup
set noshowmode

set tags=./tags;.tags

" share system clipboard
if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Show current postion
" set cursorline
" set cursorcolumn

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=5

"set textwidth=80

" 1 tab == 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

" Delete white space at end of line
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => For C and CPP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Color extra characters
"function ColorExtraCharacters()
 "   highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  "  match OverLength /\%81v.\+/
"endfunction

"autocmd Filetype c call ColorExtraCharacters()
"autocmd Filetype cpp call ColorExtraCharacters()
"autocmd Filetype h call ColorExtraCharacters()

" Update tags file automatically
au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
" map <leader>be :BufExplorer<cr>
map <F7> :BufExplorer<cr>

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_map='<c-f>'
let g:ctrlp_max_height=10
let g:ctrlp_custom_ignore='node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=0
let NERDTreeIgnore=['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=30
" map <leader>nt :NERDTreeToggle<cr>
map <F6> :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_width = 40
let g:tagbar_autoclose = 0
" map <leader>tb :TagbarToggle<cr>
map <F5> :TagbarToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"If you have installed powerline_fonts, set this to 1.
"If not, just comment it.
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_detect_paste=1

" Airline symbols, which requires patched powerline font.
" If you don't install powerline fonts patches, comment these
" lines and uncomment 'unicode symobols' instead.
" If you are using Neovim in terminal, set the terminal fonts
" first to avoid some annoying problems. If you are using
" Neovim in GUI, 'set guifont=' at the beginning of this file.
let g:airline_theme='luna'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = '☰'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = '∄'
"let g:airline_symbols.whitespace = 'Ξ'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gy :Goyo<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'
"let g:syntastic_mode_map = { 'mode': 'active',
"                                \ 'passive_filetypes': ['asm'] }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Commenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '**/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_char = '┆'
let g:indentLine_first_char = '┆'
let g:indentLine_first_char = '┆'
let g:indentLine_noConcealCursor = 1
let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude = []
let g:indentLine_fileType = ["c","cpp","python"]

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
