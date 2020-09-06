" README:
" clipboard=unnamedplus -- might cause VNC hang, refer below for WA


set nocompatible
syntax enable
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
set clipboard=unnamedplus
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

" BEGIN good enough autocomplete setting {{{
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone,noinsert
" Add dictionary to autocomplete list https://vim.fandom.com/wiki/Dictionary_completions
set complete+=k

" Fill dictionary based on filetype,
" e.g. *.java will load ~/.vim/dictionary/java/*.txt
au FileType * call LoadDictionary()
function LoadDictionary()
    for file in split(glob('~/.vim/dictionary/'.&filetype.'/*.txt'), '\n')
        execute 'setlocal dict+='.file
    endfor
endfunction

" automatically runs C-p in insert mode
function! OpenCompletion()
    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
        call feedkeys("\<C-p>", "n")
    endif
endfunction
autocmd InsertCharPre * call OpenCompletion()
" END autocomplete setting }}}


" Auto reload file like Sublime. https://unix.stackexchange.com/a/383044
" set autoread
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
"     \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
"autocmd FileChangedShellPost *
"  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" https://stackoverflow.com/questions/8640276/how-do-i-change-my-vim-highlight-line-to-not-be-an-underline
" Line highlight do not override syntax highlight
set t_Co=256
hi CursorLine cterm=NONE ctermbg=8 ctermfg=NONE
hi Search     cterm=NONE ctermbg=yellow ctermfg=black

" wrap lines without breaking words, list should be off for this feature
" usage:  :wrap
command! -nargs=* Wrap set wrap linebreak nolist

" Auto highlight word under cursor. Not enabled by default, run cmd :HL
command! -nargs=* HL autocmd CursorMoved * exe printf('match Underlined /\V\<%s\>/', escape(expand('<cword>'), '/\')) 

" !!! EXTREME CAUTION HERE. Will disable the error when you open the same two files
" But you'll no longer have the backup swp file
" Please save after every little changes
set noswapfile


" BEGIN key mapping {{{

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

let g:netrw_liststyle=3  " enable tree in file explorer

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
" END key mapping }}}

let MRU_Max_Entries = 100

" Opening Large file configuration for better performance
 " file is large than 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile 
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

" Set scripts to be executable from the shell https://unix.stackexchange.com/questions/39982/vim-create-file-with-x-bit
" TODO:BUG problem with #!/usr/bin/env python ??? When you write :w, vim goes to bg
" au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/usr/bin/env" | silent execute "!chmod a+x <afile>" | endif | endif

" https://github.com/bfrg/vim-cpp-modern
let g:cpp_simple_highlight = 1

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

" BEGIN vimdiff {{{

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
" END vimdiff }}}

" BEGIN gvim setting {{{


" Set up color for GUI and Terminal
if has('gui_running')
    " Disable bell sound
    set vb t_vb=
    colorscheme desert
    set guifont=DejaVu\ Sans\ Mono\ 12
    set guioptions-=T  " remove toolbar
    set guicursor+=n-v-c:blinkon0  " disable blinking cursor
else
    "TODO colorscheme ron
endif

" END gvim setting }}}

" Useful stuff {{{
" ===================
" %s/\s\+$//e - remove whitespace noise
" Visual to highlight line > gq - wrap line based on colorcolumn. Useful for git commit
" }}}

