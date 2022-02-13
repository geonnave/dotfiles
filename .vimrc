
" install Vundle from https://github.com/VundleVim/Vundle.vim
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" vim +PluginInstall +qall

set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" our plugins
" for first installation, do:
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Plugin 'gmarik/Vundle.vim'       " vundle

Plugin 'flazz/vim-colorschemes'  " nice colors!
Plugin 'jdevera/vim-opengrok-search'

Plugin 'bling/vim-airline'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'scrooloose/syntastic'

Plugin 'vim-scripts/a.vim'

"Plugin 'Raimondi/delimitMate'

"Plugin 'edkolev/tmuxline.vim'

"Plugin 'Valloric/YouCompleteMe'

Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'vim-ruby/vim-ruby'

Plugin 'elixir-lang/vim-elixir'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

Plugin 'JamshedVesuna/vim-markdown-preview'

Plugin 'easymotion/vim-easymotion'

Plugin 'tomlion/vim-solidity'

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
let g:syntastic_python_checkers = ['python3']

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
source ~/dev/config/dotfiles/.cscope_maps.vim

" setting a 80-column mark and a 120-column limit zone
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")

autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype jsx setlocal ts=2 sts=2 sw=2

let vim_markdown_preview_github=1

nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

" easymotion config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
