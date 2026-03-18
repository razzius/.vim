if !empty($VIM_TERMINAL) && len(argv()) > 0
  let tapi_args = '["call", "Tapi_TerminalEdit", ["' . argv()[0] . '"]]'
  let escaped_args = '\033]51;' . tapi_args . '\x07'
  silent execute "!echo -e '" . escaped_args . "'"
endif

try
  colorscheme zaibatsu
  autocmd ColorScheme zaibatsu
    \ highlight MatchParen
    \ ctermfg=white
    \ ctermbg=NONE
    \ cterm=NONE
catch
endtry

" folding
set nofoldenable
set foldmethod=syntax

" substitution
set gdefault

" Automatically reopen a file that has been changed outside of vim
set autoread

" Make editing files start in the same dir as the current file
set autochdir

" Allows hidden buffers (needed to put buffers in background)
set hidden

" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase

" Wrap lines visually
set linebreak

set undofile

" Disable swap files, editors crashing doesn't lose much data
set noswapfile

" Indentation
set shiftwidth=2
set smartindent
set smarttab
set tabstop=2
set autoindent
set expandtab

" Display whitespace
set list
set listchars=tab:⇥\ ,trail:·

" Show count of search
set shortmess-=S

if has("clipboard")
  set clipboard=unnamed,unnamedplus
endif

" Splits
set splitbelow
set splitright

" Make vim : commandline show options vertically
set wildmenu
set wildoptions=pum
set wildmode=longest:full,full

let g:mapleader = ' '

" Editing commands
nnoremap <silent> - ddp
nnoremap <silent> _ :m .-2<cr>
nnoremap <silent> D D:call TrimTrailingWhitespace()<cr>
nnoremap <leader>, A,<esc>
nnoremap <leader>; A;<esc>
nnoremap [<leader> O<esc>j
nnoremap ]<leader> o<esc>k
nnoremap <leader>o o<esc>P

onoremap <space> iW

" Movement commands
noremap 0 ^
noremap ^ 0
nnoremap <silent> j gj
nnoremap <silent> k gk
" I don't use the capital K manpage command but I do type K by accident
nnoremap K k
vnoremap $ $h

" File commands
nnoremap <silent> gf :e <cfile><cr>
nnoremap <silent> <leader>fi :e $MYVIMRC<cr>
nnoremap <silent> <leader>fa :execute 'edit ' . g:abbrevs_file<cr>
nnoremap <silent> <leader><space> :write<cr>
nnoremap <silent> <leader><esc> :bdelete<cr>
nnoremap <silent> <leader>q :qa<cr>
nnoremap <silent> <leader>Q :q!<cr>
nnoremap q<leader> :q<cr>

function! ProjectFilePath()
  let root = ProjectRootGuess()
  let filename = expand("%:p")
  return slice(filename, strlen(root) + 1)
endfunction

nnoremap <silent> <leader>fp :let @+ = ProjectFilePath() <bar> :echo ProjectFilePath()<cr>
nnoremap <silent> <leader>fn :let @+ = expand("%") <bar> :echom expand("%")<cr>
nnoremap <silent> <leader>f<space> :let @+ = expand("%:p") <bar> :echom expand("%:p")<cr>
nnoremap <silent> <leader>fo :exe ':silent !open %'<cr>:redraw!<cr>

" Macro commands
nnoremap <silent> Q @q

" Insert mode keybindings
inoremap <C-k> <C-o>D
inoremap <C-b> <C-o>h
inoremap <C-d> <C-o>x
inoremap <S-tab> <C-o><<

" Command mode keybindings
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <del>
cnoremap <C-f> <Right>
cnoremap <C-k> <C-\>e''<cr>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Misc commands
nnoremap <silent> <return> :nohlsearch<cr>
nnoremap <C-i> :help<space><C-r><C-w><cr>
nnoremap <leader>k :make<cr>
nnoremap <leader>m :messages<cr>

" See ./pack/mine/opt/package.vim
packadd package.vim

Package https://github.com/chaoren/vim-wordmotion

if has('nvim')
  autocmd TermOpen * startinsert
  set undodir=~/.config/nvim/undo
else
  set termwinkey=<C-@>
  set autoshelldir
  set undodir=~/.vim/undo
endif

if !isdirectory(&undodir)
  call mkdir(&undodir, "p", 0o700)
endif

function Tapi_TerminalEdit(bufnum, arglist)
  execute 'edit' a:arglist[0]
endfunc

function! TrimTrailingWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  keeppatterns %s/$\n\+\%$//e
  call winrestview(l:save)
endfunction

augroup trim-trailing-whitespace
  autocmd!
  autocmd BufWritePre * :call TrimTrailingWhitespace()
augroup END

Package https://github.com/Vimjas/vim-python-pep8-indent

" Matching parenthesis
Package https://github.com/kana/vim-smartinput

if has('python3')
  Package https://github.com/SirVer/ultisnips
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  nnoremap <leader>es :UltiSnipsEdit<cr>
endif

" Cursor styling for terminal
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Set signcolumn so when gitgutter loads there's no refresh
set signcolumn=yes
Package https://github.com/airblade/vim-gitgutter

Package https://github.com/tpope/vim-abolish

Package https://git.sr.ht/~razzi/razzi-abbrevs.vim
autocmd InsertEnter * set virtualedit=onemore
autocmd InsertLeave * set virtualedit=none
inoremap <C-c> <esc>

Package https://git.sr.ht/~razzi/transpose-chars

Package https://git.sr.ht/~razzi/auto-source.vim

Package https://github.com/DataWraith/auto_mkdir

Package https://github.com/suy/vim-context-commentstring

Package https://github.com/tpope/vim-commentary
nmap <leader>c gcc

Package https://github.com/tpope/vim-surround
vmap s S
vmap s<space> S<space><space>
nmap dss ds<space><space>
let g:surround_{char2nr("\<cr>")} = "\n\r\n"
let g:surround_{char2nr("")} = ""

Package https://github.com/tpope/vim-fugitive
nnoremap gb :Git blame<cr>

function! RenameFile()
  let prompt = "Rename " . expand("%") . " to: "
  let new_name = input(prompt)
  execute "GRename " . new_name
endfunction

nnoremap <leader>fR :call RenameFile()<cr>

Package https://github.com/chrisbra/improvedft

Package https://github.com/alvan/vim-closetag
let g:closetag_filetypes = 'html,vue,markdown'

Package https://github.com/kana/vim-textobj-user
Package https://github.com/kana/vim-textobj-line
Package https://github.com/kana/vim-textobj-entire

Package https://github.com/farmergreg/vim-lastplace

Package https://github.com/adelarsq/vim-matchit

Package https://github.com/dense-analysis/ale
nnoremap <leader>en :ALENext<cr>
nnoremap <leader>ep :ALEPrevious<cr>
let g:ale_lint_on_enter = 0

Package https://github.com/junegunn/fzf
Package https://github.com/junegunn/fzf.vim
Package https://github.com/dbakker/vim-projectroot

nnoremap <leader>ff :execute 'Files' ProjectRootGuess()<CR>

let g:html_indent_style1 = "inc"

" Has to be after packages have added their ftdetects
filetype plugin indent on
syntax on

highlight link markdownError Normal
let g:markdown_folding = 1
autocmd Filetype markdown setlocal shiftwidth=2

" Markdown files are like html in that kebab-case identifiers are a single token
autocmd Filetype markdown set iskeyword+=-

autocmd Filetype fish setlocal shiftwidth=4

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

""" scratch beyond this point
" Show partially-entered commands
" set showcmd
" " Enable spell checking
" set spell spelllang=en_us

""" EVERYTHING TERMINAL """
" nnoremap <C-@>c :tab terminal<cr>
" nnoremap <C-@>' :RazziTerm<cr>
" " For some reason <C-@>" doesn't work
" nnoremap <C-Space>" :RazziTerm<cr>
" nnoremap <silent> <C-@>% :vert terminal<cr>
" nnoremap <silent> <leader>\ :vertical terminal<cr>
" nnoremap <leader>" :RazziTerm<cr>
" nnoremap <leader>% :vertical terminal<cr>
" nnoremap <leader>' :RazziTerm<cr>
" command! RazziTerm :terminal ++kill=term
" command! RazziTermVertical :vertical terminal ++kill=term
" function! TerminalInsertOnFocus()
"   if &buftype == 'terminal'
"     silent! normal i
"   endif
" endfunction
" autocmd BufWinEnter,WinEnter * call TerminalInsertOnFocus()
" " kitty-aware keybindings
" nnoremap <silent> <C-Space>' :RazziTerm<cr>
" nnoremap <silent> <C-Space>% :RazziTermVertical<cr>
" nnoremap <silent> <C-Space>c :tab terminal<cr>
" nnoremap <silent> <C-Space><Space> g<tab>
" nnoremap <silent> <C-@>" <C-@>:RazziTerm<cr>
" nnoremap <silent> <C-Space>% :vert terminal<cr>
" tnoremap <silent> <C-Space>% <C-@>:vert terminal<cr>
" tnoremap <C-Space>' <C-@>:RazziTerm<cr>
" tnoremap <C-Space>" <C-@>:RazziTerm<cr>
" tnoremap <C-Space>h <C-@>:wincmd h<cr>
" tnoremap <C-Space>j <C-@>:wincmd j<cr>
" tnoremap <C-Space>k <C-@>:wincmd k<cr>
" tnoremap <C-Space>l <C-@>:wincmd l<cr>
" tnoremap <silent> <C-Space>\\ <C-@>:vert terminal<cr>
" " shouldn't really use this, but muscle memory
" tnoremap <C-@>" <C-@>:RazziTerm<cr>
" tnoremap <C-@><C-i> <C-@>gt
" tnoremap <C-@>[ <C-@>N
" tnoremap <C-@>c <C-@>:tab terminal<cr>
" tnoremap <C-[> <C-@>N
" tnoremap <esc>v <C-@>"+
" tnoremap <C-Space><space> <C-@>g<tab>
" tnoremap <C-Space>n <C-@>:tabnext<cr>
" tnoremap <C-Space>p <C-@>:tabprev<cr>

""" EVERYTHING WINDOWS""""
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" nnoremap <C-@><space> g<tab>
" nnoremap <C-@>n gt
" nnoremap <C-@>p gT
" nnoremap <silent> <C-Space>h <C-w>h
" nnoremap <silent> <C-Space>j <C-w>j
" nnoremap <silent> <C-Space>k <C-w>k
" nnoremap <silent> <C-Space>l <C-w>l
" tnoremap <C-Space>H <C-@>:vertical resize +5<cr>
" tnoremap <C-Space>J <C-@>:resize +5<cr>
" tnoremap <C-Space>K <C-@>:resize -5<cr>
" tnoremap <C-Space>L <C-@>:vertical resize -5<cr>
" nnoremap <C-Space>H :vertical resize +5<cr>
" nnoremap <C-Space>K :resize -5<cr>
" nnoremap <C-Space>J :resize +5<cr>
" nnoremap <C-Space>L :vertical resize -5<cr>
" nnoremap <C-Space>n :tabnext<cr>
" nnoremap <C-Space>p :tabprev<cr>
" " The following need to be remapped using os hotkeys for this to work
" " See https://www.reddit.com/r/neovim/comments/uc6q8h/ability_to_map_ctrl_tab_and_more/
" noremap <C-Tab> <C-@>:tabnext<cr>
" noremap <C-S-tab> <C-@>:tabprevious<cr>
" nnoremap <C-@><space> <c-w><c-p>
" nnoremap <C-@>c :tab ter<cr>
" nnoremap <C-Space>h <C-w>h
" nnoremap <C-Space>j <C-w>j
" nnoremap <C-Space>k <C-w>k
" nnoremap <C-Space>l <C-w>l
" noremap <C-@><C-@> <C-w><C-w>
" noremap <C-@><leader> <C-w><C-w>
" nnoremap <C-@><Tab> gt
" nnoremap <C-@><S-Tab> gT
" noremap <C-@>h <C-w>h
" noremap <C-@>j <C-w>j
" noremap <C-@>k <C-w>k
" noremap <C-@>l <C-w>l
" nnoremap <leader>w <C-w>
" nnoremap <leader>w2 :vsplit<cr>
" nnoremap <silent> <leader>wm :only<cr>
" nnoremap <leader>b :bnext<cr>
" nnoremap <S-Tab> gT
" nnoremap <Tab> gt

" onoremap <c-g> <esc>

" " Would be nice to have this have no visual... TODO
" " nnoremap <expr> <C-L> nr2char(getchar())
" " nnoremap <expr> r nr2char(getchar())
" " nnoremap r<c-g> <nop>
" " nnoremap rx rl
" " nnoremap
" " set guicursor=o:hor1
" set guifont=Menlo\ Regular:h18

" inoremap <c-g> <nop>

" WIP
" function! RazziLastFile()
"   if bufexists(0)
"     execute ":e #"
"   else
"     execute "'1"
"   endif
" endfunction

" command! -nargs=0 RazziLastFile :call RazziLastFile()

" nnoremap <silent> <leader><tab> :RazziLastFile<cr>

" function! RazziChange()
"   " Ok ideally this would allow for example deleting matching quotes
"   " It's ok to for example delete quotes as long as they're matched.
"   " This is based on paredit and one of the few functions I used to use
"   " there...
"   let save_cursor = getpos('.')
"   let has_quote = search('"', '', line('.'))
"   call setpos('.', save_cursor)
"   if has_quote
"     normal! dt"h
"   else
"     normal! D
"   endif
" endfunction

" nnoremap <silent> C :call RazziChange()<cr>a

" Package https://github.com/leafgarland/typescript-vim

" Package https://github.com/jaawerth/fennel.vim
