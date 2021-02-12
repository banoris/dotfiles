" README:
" clipboard=unnamedplus -- might cause VNC hang, refer below for WA


set visualbell t_vb=
set t_Co=256
set nocompatible
syntax on
filetype plugin on
set autoindent
"set smartindent " problem with verilog_systemverilog.vim
set tabstop=4
set expandtab " convert tab to spaces
set shiftwidth=4 " set reindent operations (<< and >>) as 4 spaces
set softtabstop=4
set number
set showcmd
set nowrap  " disable line wrap
set cursorline
set ignorecase
filetype indent on
set showmatch
"set incsearch
set hlsearch
" http://vim.wikia.com/wiki/Accessing_the_system_clipboard Seems ok?
" This will DISABLE autocopy on visual. E.g. using VNC, highlight using mouse,
" text won't be copied unless you yank (press 'y')
" PROs: vnc won't hang with auto copy on highlight huge chunk of text
" CONs: VNC hang if you delete huge amount of text: :g/string/d.
"   TODO:WA: use :g/string/d_  to not put deleted text to clipboard
set clipboard+=unnamedplus
set splitbelow  " default is horizontal split top, override to split below
set splitright " default is split at side
let mapleader = "\<Space>"
"set foldenable
" set paste will mess-up autoindent in insert mode
"set paste
set pastetoggle=<F2>
set backspace=2 "make backspace work like other apps
set laststatus=2 "Set statusline to always visible
set statusline=%f         " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines
set wildmode=longest:list,full  " bash like filename tab completion
" Refer wildmenu demo here https://www.youtube.com/watch?v=ri6pZo1TvKE
set wildmenu
"set path+=**
"set path+=*
set mouse=a " enable mouse for easier highlight and copy
set tabpagemax=100  " default max_tab=10, increase it
set wildignorecase  " case insensitive filename completion, e.g. tabnew <fileName>
" !!! EXTREME CAUTION HERE. Will disable the error when you open the same two files
" But you'll no longer have the backup swp file
" Please save after every little changes
set noswapfile
hi CursorLine cterm=NONE ctermbg=8 ctermfg=NONE
hi Search     cterm=NONE ctermbg=yellow ctermfg=black
colorscheme ron

" ============= BEGIN custom command {{{
" wrap lines without breaking words, list should be off for this feature
" usage:  :wrap
command! -nargs=* Wrap set wrap linebreak nolist

" Auto highlight word under cursor. Not enabled by default, run cmd :HL
command! -nargs=* HL autocmd CursorMoved * exe printf('match Underlined /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" ============= END custom command }}}

" ========================== BEGIN keyboard mapping {{{
" Disable Ex mode when pressing Q
nnoremap Q <nop>
" open ctag file symbol under cursor
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap <Leader>/ :noh<CR>
" change to current file dir
nnoremap <Leader>cd :lcd %:p:h<CR>
" center screen in search
nnoremap n nzz
nnoremap N Nzz
nnoremap <Leader>n :tabnew
" Copy current buffer path relative to root of VIM session to system clipboard
nnoremap <Leader>yp :let @*=expand("%")<cr>:echo "Copied file path to clipboard"<cr>
" Copy file full path
nnoremap <Leader>yfp :let @*=expand("%:p")<cr>:echo "Copied full file path to clipboard"<cr>
" Copy from cursor to EOL without \n character
nnoremap Y vg_y:echo "Copy success"<cr>

" open file under cursor in new tab
nnoremap gt <C-w>gf

" easier to indent code, no need to reselect
nnoremap > gv>
nnoremap < gv<

" Scroll 20 characters to the right
" Scroll 20 characters to the left
nnoremap <C-h> 20zh
nnoremap <C-l> 20zl
" Ctrl-c copy to system clipboard
vnoremap <C-c> "*y

" http://superuser.com/questions/214715/map-shift-insert-in-vim
" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" added 'l' because Esc default behavior is move one cursor to the left
imap <C-j> <Esc>l
map <C-j> <Esc>

" Clang learning - to compile and run the executable by pressing F8.
" https://stackoverflow.com/questions/2627886/how-do-i-run-a-c-program-from-vim
map <F8> <Esc>:w<CR>:!clear; gcc % -o %< && ./%<<CR>
imap <F8> <Esc>:w<CR>:!clear; gcc % -o %< && ./%<<CR>

" Shift-z-q quit a buffer, Shift z-w to quit all
nnoremap <S-z><S-w> <Esc>:qa<CR>

if has('nvim')
    " https://github.com/neovim/neovim/blob/master/runtime/doc/lsp.txt#L44
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <silent> <F5>    <cmd>lua vim.lsp.buf.formatting()<CR>
endif

" Terminal setting.
tnoremap <C-j> <C-\><C-n>

" ======================== END key mapping }}}


" ========= BEGIN misc plugin setting {{{

" vim-haskell
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" luochen1990/rainbow
let g:rainbow_active = 1

" enable tree in file explorer
let g:netrw_liststyle=3

let MRU_Max_Entries = 100

" https://github.com/bfrg/vim-cpp-modern
let g:cpp_simple_highlight = 1

" ========= END misc plugin setting {{{

" ========== BEGIN Autocomplete: LSP, basic dictionary, syntax {{{
if has('nvim') " LSP setup
    set omnifunc=lsp#omnifun
    packadd nvim-lspconfig
    packadd completion-nvim

lua<<EOF

vim.cmd('packadd nvim-lspconfig')
vim.cmd('packadd completion-nvim')
local nvim_lsp = require'nvim_lsp'
nvim_lsp.pyls.setup{
    root_dir = nvim_lsp.util.root_pattern('.git');
}

nvim_lsp.jdtls.setup{
    root_dir = nvim_lsp.util.root_pattern('.git');
    on_attach=require'completion'.on_attach;
}

EOF

    "lua require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach}
    "autocmd BufEnter * lua require'completion'.on_attach()
    "set completeopt=menuone
    "set omnifunc=v:lua.vim.lsp.omnifunc

    autocmd BufEnter * lua require'completion'.on_attach()

    " https://stackoverflow.com/q/3538785/1091116
    " https://github.com/neovim/neovim/blob/master/runtime/doc/indent.txt#L964
    let g:pyindent_open_paren = 'shiftwidth()'
    let g:pyindent_nested_paren = 'shiftwidth()'
    let g:pyindent_continue = 'shiftwidth() * 2'

else
    set omnifunc=syntaxcomplete#Complete
endif " if nvim

" Like ST3, press Ctrl-Space to pick suggested autocomplete
inoremap <C-Space> <C-y>

" Fill dictionary based on filetype,
" e.g. *.java will load ~/.vim/dictionary/java/*.txt
au FileType * call LoadDictionary()
function LoadDictionary()
    for file in split(glob('~/.vim/dictionary/'.&filetype.'/*.txt'), '\n')
        execute 'setlocal dict+='.file
    endfor
endfunction

" automatically runs C-p in insert mode
set completeopt=menu,menuone,noinsert
" Add dictionary to autocomplete list https://vim.fandom.com/wiki/Dictionary_completions
set complete+=k
function! OpenCompletion()
    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
        call feedkeys("\<C-p>", "n")
    endif
endfunction

autocmd InsertCharPre * call OpenCompletion()

" bnfc grammar file is somewhat similar to haskell
au BufRead,BufNewFile *.cf setfiletype haskell

" ============= END autocomplete }}}

" =========== BEGIN vimdiff {{{
" superb vimdiff https://vimways.org/2018/the-power-of-diff/
" Change the diff algorithm to be sort of like in meld
if v:version > 800
    set diffopt+=algorithm:patience
    set diffopt+=indent-heuristic
endif

" Refer demo https://github.com/banoris/dotfiles/issues/6
hi DiffAdd      ctermfg=NONE          ctermbg=DarkGreen
hi DiffChange   ctermfg=NONE          ctermbg=NONE
hi DiffDelete   ctermfg=LightBlue     ctermbg=Red
hi DiffText     ctermfg=Yellow        ctermbg=Blue
" ========= END vimdiff }}}

" ========== BEGIN gvim setup {{{

" Set up color for GUI and Terminal
if has('gui_running')
    " Disable bell sound
    set vb t_vb=
    colorscheme desert
    set guifont=DejaVu\ Sans\ Mono\ 12
    set guioptions-=T  " remove toolbar
    set guicursor+=n-v-c:blinkon0  " disable blinking cursor
endif

" ========== END gvim setup }}}

" ========= Uncategorized stuff ======

" Opening Large file configuration for better performance
 " file is large than 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
    autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
    " no syntax highlighting etc
    " set eventignore+=FileType  " acerun don't have any syntax?
    " save memory when other file is viewed
    setlocal bufhidden=unload
    " is read-only (write with :w new_filename)
    setlocal buftype=nowrite
    " no undo possible
    setlocal undolevels=-1
    " display message
    autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

