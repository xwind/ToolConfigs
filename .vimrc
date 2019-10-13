" set expandtab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
" search
set hlsearch
set incsearch
" encoding config
set encoding=utf-8
set nu
" Configuration file for vim
set modelines=0		" CVE-2007-2438
set showmatch
set helplang=cn
set clipboard+=unnamed
"Compile Keyboard
"
augroup plantuml
    au BufWriteCmd *.puml,*.uml write | AsyncRun! java -jar /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/lib/plantuml.jar % && open %<.png
augroup end
"Color Keyboard
nnoremap <C-F4> <Esc>:hi Normal ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f0f0f0 guibg=#252c31 gui=NONE<CR><Esc>:hi NonText ctermfg=59 ctermbg=NONE cterm=NONE guifg=#414e58 guibg=#232c31 gui=NONE<CR>
nnoremap <C-F5> <Esc>:hi Normal ctermfg=231 ctermbg=16 cterm=NONE guifg=#f0f0f0 guibg=#252c31 gui=NONE<CR><Esc>:hi NonText ctermfg=59 ctermbg=16 cterm=NONE guifg=#414e58 guibg=#232c31 gui=NONE<CR>
" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set backspace=2		" more powerful backspacing

" grep config
set shellpipe=2>/dev/null>
set grepprg=rg\ --column\ $*
set grepformat=%f:%l:%c:%m

"" 适配airline
set laststatus=2
"" 配置NERDTree
let NERDTreeWinPos='left'
let NERDTreeWinSize=30
map <F2> :NERDTreeToggle<CR>

"" 配置YouCompleteMe
" 设置在下面几种格式的文件上屏蔽ycm
"" 配置YouCompleteMe
let g:ycm_rust_src_path="/Users/dongxuewu/RustSrc/src"
" 设置在下面几种格式的文件上屏蔽ycm
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'nerdtree' : 1,
      \}
nnoremap <C-b> :YcmCompleter GoToDefinition<CR>
nnoremap <C-e> :YcmCompleter GoToDeclaration<CR>
inoremap <leader>; <C-x><C-o>

"" 配置fugitive
nnoremap <S-w> :Gblame<CR>

"" 配置syntastic
auto BufRead,BufNewFile *.go set filetype=go
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
let g:syntastic_python_checkers=['flake8'] " 使用pyflakes,速度比pylint快
let g:syntastic_python_flake8_args='--ignore=E501,W503'
let g:syntastic_go_checkers=['go', 'golint']
let g:syntastic_html_checkers=['tidy', 'jshint']
" let g:syntastic_javascript_checkers = ['jsl', 'jshint']

" 修改高亮的背景色, 适应主题
highlight SyntasticErrorSign guifg=white guibg=black

" to see error location list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>

" 配置 tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_autofocus = 1


set nocompatible	" Use Vim defaults instead of 100% vi compatibility
filetype off

if has('win32')
    set rtp+=$HOME/.vim/bundle/Vundle.vim/
    call vundle#begin("$HOME/.vim/bundle/")
else
    " markdown preview
    let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"

    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/groovyindent'
Plugin 'pangloss/vim-javascript'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'aklt/plantuml-syntax'
Plugin 'antlypls/vim-colors-codeschool'
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plugin 'Valloric/YouCompleteMe'
Plugin 'NLKNguyen/papercolor-theme'

call vundle#end()

filetype plugin on
syntax on

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

if has('gui_running')
    " GUI colors
    set guioptions-=m
    set guioptions-=T
    set guifont=Source\ Code\ Variable:h11
    colorscheme codeschool
else
    " Non-GUI (terminal) colors
    set t_Co=256
    colorscheme PaperColor
    set background=dark
endif
