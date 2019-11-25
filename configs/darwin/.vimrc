" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

let skip_defaults_vim=1

" Line number
set number

" Encoding
set encoding=utf-8

" Syntax Lighting
syntax enable
syntax on

" Tabstop
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set cindent

" 设置vim-plug管理的插件安装位置
 call plug#begin('~/.vim/bundle')


" 下面就是一些插件的例子.
" 插件必须装在  plug#begin/end这两行命令之间.
" 对于在github上面的插件, 我们可以用以下方法添加, 只需要添加`用户名/插件名称`就行
"Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'srcery-colors/srcery-vim'
Plug 'scrooloose/nerdtree'
"Plug 'davidhalter/jedi-vim'
"Plug 'cespare/vim-toml'
"Plug 'python-mode/python-mode', { 'branch': 'develop' }
" 对于在http://vim-scripts.org/vim/scripts.html下的插件, 我们直接添加插件名称就行
" Plug 'L9'
" 对于不是github也不是vim-scripts的插件, 则需要用完整路径
"Plug 'git://git.wincent.com/command-t.git'
" 本地或者你自己的插件
"Plug 'file:///home/gmarik/path/to/plugin'


" 所有的插件都需要安装在这条命令之前
call plug#end()            " 必须的

" Color themes
set termguicolors
set t_Co=256
colorscheme srcery
let g:airline = {
      \ 'colorscheme': 'srcery',
      \ }
let g:srcery_italic = 1

" Cursor
set cul
set cuc

" Open a NERDTree
map <C-t> :NERDTreeToggle<CR>

" Python3 syntax
"let g:pymode_python = 'python3'
