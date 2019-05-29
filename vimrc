" stolen from akash shaji
" Vundle Init
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle Plugins 

" Vundle Base Plugin
Plugin 'VundleVim/Vundle.vim'

" Theme
Plugin 'liuchengxu/space-vim-dark'

" Plugins for bars on the top and the bottom
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Basic git integration
Plugin 'tpope/vim-fugitive'

" File viewer
Plugin 'scrooloose/nerdtree'

" Guides for Indents
"Plugin 'nathanaelkane/vim-indent-guides'

" Display marks in the gutter 
Plugin 'kshenoy/vim-signature'

" Autocomplete braces and such
Plugin 'Raimondi/delimitMate'

" IDE type autocomplete
Plugin 'ajh17/VimCompletesMe'

" Java autocompletion
" Plugin 'artur-shaik/vim-javacomplete2'

" Snippets
" Plugin 'SirVer/ultisnips'

"vue
Plugin 'posva/vim-vue'

" Fuzzy File Finder
Plugin 'kien/ctrlp.vim'

" Autocomplete when searching
Plugin 'vim-scripts/SearchComplete'

" Background Lint Engine
" Plugin 'w0rp/ale'

" Openscad Support
Plugin 'sirtaj/vim-openscad'

" Async Code Execution
" Plugin 'skywind3000/asyncrun.vim'

" Indent 
Plugin 'Yggdroot/indentLine'

" c.vim
Plugin 'c.vim'

" Vundle Closing
call vundle#end()

" CSS coloring
Plugin 'ap/vim-css-color'


let g:NERDTreeDirArrows=0

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size=1

let g:airline#extensions#tabline#enabled = 1

let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips/"
let g:UltiSnipsExpandTrigger="<c-]>"
let g:UltiSnipsJumpForwardTrigger="<c-]>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsRemoveSelectModeMappings = 0

filetype plugin indent on

" User settings
" Shows syntax
syntax on

" searches for tag file in current directory then recursively up parent directories
set tags=./tags;

" Cursor will select things
set mouse=a

" Making jj escape
imap jj <Esc>

" Show line numbering
set number
set relativenumber

" tabbing
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Left column width
set foldcolumn=6

" Fix backspace
set backspace=indent,eol,start

" Pretty dank cursor column highlighting
set cursorcolumn

" Wrap guide at 92 chars
set colorcolumn=92

" 'nuff said
set encoding=utf-8

" Choose color scheme
colorscheme space-vim-dark
let g:space_vim_dark_background = 235
color space-vim-dark

" Toggle Nerd Tree to F2
map <F2> :NERDTreeToggle<CR>

" Macros for windowed mode
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <F7> <C-w>+
map <F8> <C-w>-
map <F9> <C-w><
map <F10> <C-w>>

" getting rid of pgdwn/pgup
map <PageUp> <BS>
map <PageDown> <BS>
inoremap <PageUp> <BS>
inoremap <PageDown> <BS>
" Adding lines when in normal mode
map <Enter> o<ESC>

" Toggle folds with space bar in normal mode
nnoremap <space> za

" Surround the highlighted string
map <Leader>9 s()<ESC>P
map <Leader>[ s[]<ESC>P
map <Leader>; s''<ESC>P
map <Leader>' s""<ESC>P
map <Leader>, s<><ESC>P
map <Leader>d <ESC>`>x`<x

" Adding support for moving up and down on wrapped lines
map j gj
map k gk

" Bind F5 to save file if modified and execute python script in a buffer.
" Tooken from https://stackoverflow.com/questions/18948491/running-python-code-in-vim
nnoremap <silent> <F5> :call SaveAndExecutePython()<CR>
vnoremap <silent> <F5> :<C-u>call SaveAndExecutePython()<CR>

function! SaveAndExecutePython()
    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    silent execute ".!time python " . shellescape(s:current_buffer_file_path, 1)

    " resize window to content length
    " Note: This is annoying because if you print a lot of lines then your code buffer is
    "   forced to a height of one line every time you run this function.
    " However without this line the buffer starts off as a default size and if you
    "   resize the buffer then it keeps that custom size after repeated runs of this
    "   function.
    "   But if you close the output buffer then it returns to using the default size
    "   when its recreated
    " execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
endfunction


