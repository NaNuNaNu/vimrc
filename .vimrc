" Set search path from environment variable (sub : with , for vim path format)
let &path = &path . "," . substitute($PATH, ';', ',', 'g') . "," . $GOPATH . "/**"
set rtp+=~/.vim/bundle/Vundle.vim

" Vundle plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'fatih/molokai'
Plugin 'nanotech/jellybeans.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'SirVer/ultisnips'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'elzr/vim-json'
call vundle#end()

" settings
set nocompatible
filetype off
filetype plugin indent off
filetype plugin indent on
set ts=4 " Set tabs to 2 spaces
set ttymouse=xterm2
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set nu " Default to line numbers on
set incsearch   " Set incremental search on
set splitbelow " Open new split panes to right and bottom, which feels more natural
set splitright
set backupdir=/tmp
set directory=/tmp
set statusline+=%F " Show the full path on the status line
set autowrite
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set laststatus=2                " Show status line always
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set ttyscroll=3                 " Speedup scrolling


" color scheme
syntax on
set t_Co=256
let g:rehash256 = 1
set background=dark 
colorscheme jellybeans

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" F1 = list and select buffer
nnoremap <F1> :buffers<CR>:buffer<Space>
inoremap <F1> :buffers<CR>:buffer<Space>

" F9 = Go to previous/next buffer
map <F9> :bp<CR>
map <F10> :bn<CR>

" F11 = Go to previous/next tab
map <F11> :tabp<CR>
map <F12> :tabn<CR>
map <M-h> :tabp<CR>
map <M-l> :tabn<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

" Set syntax highliting for cfg files (json)
autocmd BufNewFile,BufRead *.cfg   set syntax=json

" go-vim stuff (https://github.com/fatih/vim-go)
let mapleader = ","
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_type_info = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>
let g:go_decls_includes = "func,type"

" neocomplete (autocomplete)
let g:neocomplete#enable_at_startup = 1
" Plugin key-mappings.
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call<SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc-browser)
 
  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  
  " :GoSameIdsToggle
  autocmd FileType go nmap <Leader>s :GoSameIdsToggle<CR>


" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
     call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
     call go#cmd#Build(0)
  endif
endfunction


