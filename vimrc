if !empty($VIM_TERMINAL)
  if len(argv()) > 1
    let tapi_args = '["call", "Tapi_TerminalEdit", ["' . argv()[0] . '"]]'
    let escaped_args = '\033]51;' . tapi_args . '\x07'
    execute "!echo -e '" . escaped_args . "'"
  endif
endif

try
  colorscheme zaibatsu
  autocmd ColorScheme zaibatsu highlight MatchParen ctermfg=white ctermbg=NONE cterm=NONE
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

" Enable spell checking
set spell spelllang=en_us
nnoremap - ddp
nnoremap _ :m .-2<cr>
nnoremap 0 ^
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap ^ 0
nnoremap gf :e <cfile><cr>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> D D:call TrimTrailingWhitespace()<cr>
nnoremap <silent> Q @q

noremap <C-@><C-@> <C-w><C-w>
noremap <C-@><leader> <C-w><C-w>
nnoremap <C-@><Tab> gt
nnoremap <C-@><S-Tab> gT
noremap <C-@>h <C-w>h
noremap <C-@>j <C-w>j
noremap <C-@>k <C-w>k
noremap <C-@>l <C-w>l

inoremap <C-]> <C-q><TAB>
inoremap <C-k> <C-o>D
inoremap <C-l> <esc>lxep

" This is the default kitty symbol for Alt+v;
" since I don't type it I am just remapping it to paste.
" It would be better to remap this on the kitty side tho.
inoremap ö <C-r>+
cnoremap ö <C-r>+

nnoremap <C-@>c :tab terminal<cr>
nnoremap <C-@>' :RazziTerm<cr>

" For some reason <C-@>" doesn't work
nnoremap <C-Space>" :RazziTerm<cr>

nnoremap <C-@>% :vert terminal<cr>
nnoremap <C-@><space> <c-w><c-p>
nnoremap <C-@>c :tab ter<cr>
nnoremap <C-@>h <C-w>h
nnoremap <C-@>j <C-w>j
nnoremap <C-@>k <C-w>k
nnoremap <C-@>l <C-w>l

vnoremap $ $h
vnoremap ^ 0
vnoremap 0 ^
vnoremap ! !sort<cr>
vmap ` s`
vnoremap <leader>` v`>a```<esc>`<i```<esc>

nnoremap <leader>, A,<esc>
nnoremap <leader>; A;<esc>
nnoremap <leader>` o```<esc>
nnoremap <leader>fi :e $MYVIMRC<cr>
nnoremap <leader>fs :w<cr>
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
nnoremap q<leader> :q<cr>

nnoremap <silent> <leader><esc> :bdelete<cr>
nnoremap <esc>v <C-@>"+

onoremap <space> iW

function! EnsurePackage(url)
  let name = split(a:url, '/')[-1]
  let target = $HOME . '/.vim/pack/vendor/opt/' . name

  if !isdirectory(target)
    silent execute '!git clone --depth=1 ' . a:url . ' ' . target
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

" scroll up/down in the other window
" only works if you have 2 windows
nmap <c-j> <c-w>w<c-e><c-w>w
nmap <c-k> <c-w>w<c-y><c-w>w

cnoremap <C-a> <HOME>
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
cnoremap <C-k> <Left>
cnoremap <C-up> <C-f>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
      \ '' : getcmdline()[:getcmdpos()-2]<cr>

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" feature idea: allow writing "readonly files" after having some visual indication that the file is readonly

" nnoremap <leader>b :only <bar> :below terminal python3 %<cr><C-w><C-w>

Package https://github.com/chaoren/vim-wordmotion

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
  call mkdir(&undodir, "p", 0o700)
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
nnoremap <silent> <C-Space><Space> g<tab>
nnoremap <C-@><space> g<tab>
nnoremap <C-@>n gt
nnoremap <C-@>p gT

nnoremap <silent> <C-Space>h <C-w>h
nnoremap <silent> <C-Space>j <C-w>j
nnoremap <silent> <C-Space>k <C-w>k
nnoremap <silent> <C-Space>l <C-w>l

nnoremap <C-@>" <C-@>:RazziTerm<cr>
nnoremap <C-Space>% vert terminal<cr>

tnoremap <C-Space>% <C-@>:vert terminal<cr>
tnoremap <C-Space>' <C-@>:RazziTerm<cr>
tnoremap <C-Space>" <C-@>:RazziTerm<cr>
tnoremap <C-Space>h <C-@>:wincmd h<cr>
tnoremap <C-Space>j <C-@>:wincmd j<cr>
tnoremap <C-Space>k <C-@>:wincmd k<cr>
tnoremap <C-Space>l <C-@>:wincmd l<cr>
tnoremap <C-Space>\\ <C-@>:vert terminal<cr>

" shouldn't really use this, but muscle memory
tnoremap <C-@>" <C-@>:RazziTerm<cr>

tnoremap <C-@><C-i> <C-@>gt
tnoremap <C-@>[ <C-@>N
tnoremap <C-@>c <C-@>:tab terminal<cr>
tnoremap <C-[> <C-@>N
tnoremap <esc>v <C-@>"+

tnoremap <C-Space><space> <C-@>g<tab>
tnoremap <C-Space>n <C-@>:tabnext<cr>
tnoremap <C-Space>p <C-@>:tabprev<cr>

nnoremap <C-Space>n :tabnext<cr>
nnoremap <C-Space>p :tabprev<cr>

" The following need to be remapped using os hotkeys for this to work
" See https://www.reddit.com/r/neovim/comments/uc6q8h/ability_to_map_ctrl_tab_and_more/
tnoremap <C-Tab> <C-@>:tabnext<cr>
tnoremap <C-S-tab> <C-@>:tabprevious<cr>

nnoremap <C-Tab> :tabnext<cr>
nnoremap <C-S-Tab> :tabprev<cr>

" Set signcolumn so when gitgutter loads there's no refresh
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

" taken from https://www.reddit.com/r/vim/comments/6llcp0/transpose_characters/
inoremap <expr> <C-T> TransposeChars()
cnoremap <expr> <C-T> TransposeChars()

func! TransposeChars()
  let l:col  = CursorPos()
  let l:line = CursorLine()

  if l:col == 1
    return ''
  elseif l:col > len(l:line)
    return TransposePrecedingChars(l:line, l:col)
  else
    return TransposeSurroundingChars(l:line, l:col)
  endif
endf

func! CursorPos()
  return mode() == 'c' ? getcmdpos() : col('.')
endf

func! CursorLine()
  return mode() == 'c' ? getcmdline() : getline('.')
endf

func! TransposePrecedingChars(line, col)
  if a:col > 2
    return "\<BS>\<BS>" . a:line[ a:col-2 ] . a:line[ a:col-3 ]
  else
    return mode() == 'i' ? "\<C-G>U\<Left>" : "\<Left>"
  end
endf

func! TransposeSurroundingChars(line, col)
  return "\<BS>\<Del>" . a:line[ a:col-1 ] . a:line[ a:col-2 ]
endf


Package https://github.com/kana/vim-textobj-user
Package https://github.com/kana/vim-textobj-line
Package https://github.com/kana/vim-textobj-entire

Package https://github.com/farmergreg/vim-lastplace

Package https://github.com/jaawerth/fennel.vim

let g:html_indent_style1 = "inc"

" Has to be after packages have added their ftdetects
filetype plugin indent on
syntax on

highlight link markdownError Normal
let g:markdown_folding = 1

" This augroup has to be after filetype
augroup comment_continuation
  autocmd!
  " Don't continue comments by default, opening or hitting return
  autocmd BufNewFile,BufRead * setlocal formatoptions-=r formatoptions-=o
augroup END

augroup switch_windows
  autocmd!
  autocmd BufLeave,FocusLost * silent! wall
augroup END
