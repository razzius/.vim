if !empty($VIM_TERMINAL)
  let tapi_args = '["call", "Tapi_TerminalEdit", ["' . argv()[0] . '"]]'
  let escaped_args = '\033]51;' . tapi_args . '\x07'
  execute "!echo -e '" . escaped_args . "'"
endif

highlight Search cterm=NONE ctermfg=grey ctermbg=blue

try
  colorscheme zaibatsu
catch
endtry

let mapleader = ' '
set autoindent
set expandtab

" folding
set nofoldenable
set foldmethod=syntax

" substitution
set gdefault

" Automatically reopen a file that has been changed outside of vim
set autoread

" Make editing files start in the same dir as the current file
set autochdir

" Allows hidden buffers
set hidden

" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase

set linebreak

set mouse=a

set undofile

" Disable swap files, editors crashing doesn't lose much data
set noswapfile

" Indentation
set shiftwidth=2
set smartindent
set smarttab
set tabstop=2

" Splits
set splitbelow
set splitright

" Allow backspace in insert mode to go outside of the inserted region
set backspace=indent,eol,start

" Show partially-entered commands
set showcmd

map gf :e <cfile><cr>

noremap <C-@><C-@> <C-w><C-w>
noremap <C-@><leader> <C-w><C-w>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <C-@><Tab> gt
nnoremap <C-@><S-Tab> gT
noremap <C-@>h <C-w>h
noremap <C-@>j <C-w>j
noremap <C-@>k <C-w>k
noremap <C-@>l <C-w>l

inoremap <C-]> <C-q><TAB>
inoremap <C-k> <C-o>D
inoremap <C-t> <esc>hxpa
inoremap <C-l> <esc>lxep

" This is the default kitty symbol for Alt+v;
" since I don't type it I am just remapping it to paste.
inoremap ö <C-r>+
cnoremap ö <C-r>+

nnoremap ^ 0
nnoremap 0 ^
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-@>c :tab ter<cr>
nnoremap <C-@>' :RazziTerm<cr>
nnoremap <C-@>% :vert terminal<cr>
nnoremap <C-@><space> <c-w><c-p>
nnoremap <C-@>c :tab ter<cr>
nnoremap <C-@>h <C-w>h
nnoremap <C-@>j <C-w>j
nnoremap <C-@>k <C-w>k
nnoremap <C-@>l <C-w>l
nnoremap - ddp
nnoremap gm gM
nnoremap gM gm
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> D D:call TrimTrailingWhitespace()<cr>
nnoremap <silent> Q @q

nnoremap <leader>, A,<esc>
nnoremap <leader>fi :e $MYVIMRC<cr>
nnoremap <leader>h :help<space>
nnoremap <leader><leader> :write<cr>
nnoremap <leader>f<space> :let @+ = expand("%") <bar> :echom expand("%")<cr>

nnoremap [<leader> O<esc>j
nnoremap ]<leader> o<esc>k
nnoremap <leader>o o<esc>P
nnoremap <leader>q :qa<cr>
nnoremap <leader>Q :q!<cr>
nnoremap <leader><return> :nohlsearch<cr>
nnoremap <leader>r :source $MYVIMRC <bar> :echom "RELOAD"<cr>
nnoremap <leader><tab> :e #<cr>
nnoremap <leader>" :RazziTerm<cr>
nnoremap <leader>' :RazziTerm<cr>
nnoremap <leader>v <C-v>
nnoremap <leader>% :vertical terminal<cr>
nnoremap <leader>w <C-w>
nnoremap _ :m .-2<cr>
nnoremap q<leader> :q<cr>

nnoremap <silent> <leader><esc> :bdelete<cr>
nnoremap <esc>v <C-@>"+

tnoremap <C-@>% <C-@>:vert terminal<cr>
tnoremap <C-@>' <C-@>:RazziTerm<cr>

" shouldn't really use this, but muscle memory
tnoremap <C-@>" <C-@>:RazziTerm<cr>

noremap <C-@>r <C-@>:source $MYVIMRC <bar> :echom "RELOAD"<cr>
noremap <C-@>v <C-@>:tabe $MYVIMRC<cr>

tnoremap <C-@><C-i> <C-@>gt
tnoremap <C-@>[ <C-@>N
tnoremap <C-@>c <C-@>:tab terminal<cr>
tnoremap <C-[> <C-@>N
tnoremap <esc>v <C-@>"+

" TODO implement tab stack
tnoremap <C-@><space> <C-@>:tabnext<cr>
nnoremap <C-@><space> <C-@>:tabnext<cr>

onoremap <space> iW

function! EnsurePackage(url)
  let name = split(a:url, '/')[-1]
  let target = $HOME . '/.vim/pack/vendor/opt/' . name

  if !isdirectory(target)
    silent execute '!git clone ' . a:url . ' ' . target
  endif

  execute 'packadd! ' . name
endfunction

command! -nargs=1 Package :call EnsurePackage(<q-args>)

command! RazziTerm :terminal ++kill=term
command! RazziTermVertical :vertical terminal ++kill=term

function! TerminalInsertOnFocus()
  if &buftype == 'terminal'
    silent! normal i
  endif
endfunction

autocmd BufWinEnter,WinEnter * call TerminalInsertOnFocus()

autocmd Filetype fish setlocal shiftwidth=4

vnoremap $ $h
vnoremap ^ 0
vnoremap 0 ^
vnoremap ! !sort<cr>
vnoremap <leader>` v`>a```<esc>`<i```<esc>

" scroll up/down in the other window
" only works if you have 2 windows
nmap <c-j> <c-w>w<c-e><c-w>w
nmap <c-k> <c-w>w<c-y><c-w>w

" The following need to be remapped using os hotkeys for this to work
" See https://www.reddit.com/r/neovim/comments/uc6q8h/ability_to_map_ctrl_tab_and_more/
tnoremap <C-tab> <C-@>:tabnext<cr>
tnoremap <C-S-tab> <C-@>:tabprevious<cr>

cnoremap <C-a> <HOME>
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
cnoremap <C-k> <Left>
cnoremap <C-t> <C-f>$Xp<C-c><right><C-l>
cnoremap <C-up> <C-f>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
      \ '' : getcmdline()[:getcmdpos()-2]<cr>

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" feature idea: allow writing "readonly files" after having some visual indication that the file is readonly

" nnoremap <leader>b :only <bar> :below terminal python3 %<cr><C-w><C-w>

Package https://github.com/bkad/CamelCaseMotion

function! ConfigCamelCase()
  map <silent> w <Plug>CamelCaseMotion_w
  map <silent> b <Plug>CamelCaseMotion_b
  map <silent> e <Plug>CamelCaseMotion_e
  map <silent> ge <Plug>CamelCaseMotion_ge
endfunction

autocmd VimEnter * call ConfigCamelCase()

if has('nvim')
  autocmd TermOpen * startinsert
  set undodir=~/.config/nvim/undo
endif

if !has('nvim')
  set termwinkey=<C-@>
  set autoshelldir

  set undodir=~/.vim/undo
endif

if !isdirectory(&undodir)
  call mkdir(&undodir, "p", 0700)
endif

function Tapi_TabEdit(bufnum, arglist)
  execute 'tabedit' a:arglist[0]
endfunc

function Tapi_TerminalEdit(bufnum, arglist)
  execute 'edit' a:arglist[0]
endfunc

function! TrimTrailingWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  keeppatterns %s/$\n\+\%$//e
  call winrestview(l:save)
endfunction

augroup cleanup
  autocmd!
  autocmd BufWritePre * :call TrimTrailingWhitespace()
augroup END

Package https://github.com/prabirshrestha/vim-lsp

let g:lsp_document_highlight_enabled = 0

nmap <buffer> g] <plug>(lsp-definition)
nmap <buffer> <leader>en <plug>(lsp-next-diagnostic)
nmap <buffer> <leader>ep <plug>(lsp-previous-diagnostic)

Package https://github.com/Vimjas/vim-python-pep8-indent

Package https://github.com/kana/vim-smartinput

if executable('pylsp')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

" doesn't work
" autocmd BufRead,BufNewFile * if &readonly | call lsp#disable()

Package https://github.com/SirVer/ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

function! EditSnippets()
  execute 'edit ~/.vim/UltiSnips/' . &filetype . '.snippets'
endfunction

nnoremap <leader>es :call EditSnippets()<cr>

" Cursor styling for kitty
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" kitty-aware keybindings
nnoremap <silent> <C-Space>' :RazziTerm<cr>
nnoremap <silent> <C-Space>% :RazziTermVertical<cr>
nnoremap <silent> <C-Space>c :tab terminal<cr>

nnoremap <silent> <C-Space>h <C-w>h
nnoremap <silent> <C-Space>j <C-w>j
nnoremap <silent> <C-Space>k <C-w>k
nnoremap <silent> <C-Space>l <C-w>l

tnoremap <silent> <C-Space>h <C-\><C-n><C-w>h
tnoremap <silent> <C-Space>j <C-\><C-n><C-w>j
tnoremap <silent> <C-Space>k <C-\><C-n><C-w>k
tnoremap <silent> <C-Space>l <C-\><C-n><C-w>l

tnoremap <silent> <C-Space>' <C-\><C-n>:term<cr>
tnoremap <silent> <C-Space>% <C-\><C-n>:vertical term<cr>

nnoremap <silent> <C-Space>j <C-w>j
nnoremap <silent> <C-Space>k <C-w>k
" tnoremap <silent> <C-Space><space> <C-w>:tabp<cr>

highlight link markdownError Normal

" Set signcolumn when gitgutter loads there's no refresh
set signcolumn=yes
Package https://github.com/airblade/vim-gitgutter

Package https://git.sr.ht/~razzi/razzi-abbrevs

Package https://github.com/DataWraith/auto_mkdir

Package https://github.com/suy/vim-context-commentstring

Package https://github.com/tpope/vim-commentary

Package https://github.com/tpope/vim-surround
vmap s S
nmap dss ds<space><space>
let g:surround_{char2nr("\<cr>")} = "\n\r\n"

Package https://github.com/tpope/vim-repeat

Package https://github.com/tpope/vim-fugitive
nnoremap gb :Git blame<cr>

function! RenameFile()
  let prompt = "Rename " . expand("%") . " to: "
  let new_name = input(prompt)
  execute "GRename " . new_name
endfunction

nnoremap <leader>fR :call RenameFile()<cr>

Package https://github.com/tpope/vim-abolish

Package https://git.sr.ht/~razzi/any-jump.vim

Package https://github.com/dahu/vim-fanfingtastic

Package https://github.com/leafgarland/typescript-vim

Package https://github.com/alvan/vim-closetag
let g:closetag_filetypes = 'html,vue'

Package https://github.com/junegunn/fzf
Package https://github.com/junegunn/fzf.vim

nnoremap <leader>pf :Files<cr>
nnoremap <leader>/ :Rg<cr>
nnoremap <silent> <leader>fr :History<cr>

if has("clipboard")
  set clipboard=unnamed,unnamedplus
endif

Package https://github.com/kana/vim-textobj-user
Package https://github.com/kana/vim-textobj-line
Package https://github.com/kana/vim-textobj-entire

Package https://github.com/farmergreg/vim-lastplace

let g:html_indent_style1 = "inc"

" Has to be after packages have added their ftdetects
filetype plugin indent on
syntax on

" This augroup has to be after filetype
augroup comment_continuation
  autocmd!
  " Don't continue comments by default, opening or hitting return
  autocmd BufNewFile,BufRead * setlocal formatoptions-=r formatoptions-=o
augroup END
