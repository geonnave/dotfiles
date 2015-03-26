
set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" our plugins
" for first installation, do:
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Plugin 'gmarik/Vundle.vim'       " vundle

Plugin 'flazz/vim-colorschemes'  " nice colors!
Plugin 'jdevera/vim-opengrok-search'  " nice colors!

Plugin 'bling/vim-airline'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'scrooloose/syntastic'

Plugin 'vim-scripts/a.vim'

"Plugin 'Raimondi/delimitMate'

Plugin 'edkolev/tmuxline.vim'

"Plugin 'Valloric/YouCompleteMe'
call vundle#end()

filetype plugin indent on

" vim ide start
"
set backspace=indent,eol,start
set ruler
set showcmd

" start searching when you type the first character
set incsearch

" turns on search highlighting
set hlsearch

colorscheme wombat256
"set background=dark
"colorscheme solarized

" - vim-airline options
set laststatus=2
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled=1

" - vim-nerdtree-tabs
" open/close nt-tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" have nt always on startup
let g:nerdtree_tabs_open_on_console_startup=1

" - syntastic
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
	au!
	au FileType tex let b:syntastic_mode = "passive"
augroup END

" - delimitMate
"let delimitMate_expand_cr=1
"augroup mydelimitMate
"	au!
"	au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
"	au FileType tex let b:delimitMate_quotes = ""
"	au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
"	au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
"augroup END

" vim ide end

set term=screen-256color

set ic

set smartcase

hi Comment ctermfg=LightBlue

set nu

syntax enable

set cindent

" highlight current line
set cursorline

" highlight one line and stay highglighted when cursor moves
nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>

" CSCOPE
source ~/dev/dotfiles/.cscope_maps.vim

" setting a 80-column mark and a 120-column limit zone
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")

