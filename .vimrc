" Vim settings
"colorscheme wal
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set incsearch
set laststatus=2
set ruler
set wildmenu
set autoread
set number relativenumber
set hlsearch
set clipboard=unnamedplus
"set paste
set pastetoggle=<F10>
set go+=a
set whichwrap+=<,>,[,]
set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=3
set noshowmode
set ignorecase
set smartcase
"set cursorline
set ttimeoutlen=0

" Cursor shapes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Load plugins
call plug#begin('~/.vim/plugged')
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'junegunn/goyo.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mhinz/vim-startify'
Plug 'ap/vim-css-color'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'terryma/vim-multiple-cursors'
Plug 'alvan/vim-closetag'
Plug 'haya14busa/incsearch.vim'
Plug 'w0rp/ale'
Plug 'elzr/vim-json'
Plug 'itchyny/lightline.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'christianrondeau/vim-base64'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'suan/vim-instant-markdown'
Plug 'jtratner/vim-flavored-markdown'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()

" Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Closetag settings, maybe unnecessary
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" Latex settings
let g:livepreview_previewer = 'mupdf'

" Vim bindings
map <Leader> <Plug>(easymotion-prefix)
map <C-g> :Goyo<CR>
map <C-f> :call JsBeautify()<CR>
nmap <CR> o<Esc>
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db
nmap <C-_> gcc<Esc>
vmap <C-_> gcc<Esc>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
cmap w!! w !sudo tee > /dev/null %
nnoremap K i<CR><Esc>
map <C-l> :noh<CR>
inoremap <silent> <Esc> <C-O>:stopinsert<CR>
nnoremap <BS> X
"inoremap jj <Esc>`^
map OA <up>

" Functions
" mkdir parent folder if not exists
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
