"
" ~/.vimrc
" Author: Dustin Tran <dustintran.com>
"
" Settings
" -----------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle')
Plug 'benjifisher/matchit.zip'
" Plug 'crusoexia/vim-monokai'  " for iterm2
Plug 'danro/rename.vim', { 'on': 'Rename' }
Plug 'godlygeek/tabular'
" fzf doesn't render correctly on MacVim. Use Ctrl-P for now.
" https://github.com/junegunn/fzf/issues/1108
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'
Plug 'lilydjwg/colorizer'
Plug 'maverickg/stan.vim'
Plug 'msanders/snipmate.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug '~/.vim/bundle/dvt'
call plug#end()

" System Settings
set encoding=utf-8
set showcmd                            " Display partial commands
augroup stahp
  autocmd!
  autocmd GUIEnter * set visualbell t_vb=  " Disable error bells
augroup END
" Auto-cd into the file's dir
augroup autocd
  autocmd BufEnter * silent! lcd %:p:h
augroup END
set hidden                             " Change buffers without saving
set shortmess=I                        " Disable intro message
set mouse=a                            " Mouse support in terminal
set autoread                           " Reload files outside vim
set clipboard=unnamed                  " Set to system's clipboard register

" Temp Directories
set backup                             " Enable backups
set noswapfile                         " It's the 21st century, Vim
set undofile                           " Enable persistent undo
set backupdir=~/.vim/tmp/backup
set undodir=~/.vim/tmp/undo
set viminfo='10,\"100,:20,%

" Searching, Highlighting, Replacing Settings
set ignorecase                         " Case-insensitive matching...
set smartcase                          "  except case-sensitive searches
set incsearch                          " Incremental searching
set gdefault                           " Substitute all occurrences only in line
set modelines=1                        " Let OS X read ft commands in files
set wildmenu                           " Tab-completion features in cmd-line mode
set wildmode=list:full

" Formatting
set backspace=indent,eol,start         " Expected backspacing
set linebreak                          " Don't linebreak words in the middle
set display=lastline                   " Displays partial wrapped lines
"set tw=80                              " Auto linebreak at 80 characters
set tw=70                              " Auto linebreak at 70 characters
set formatoptions=rotcq                " Format options with new lines
set autoindent                         " Hard wrap with autoindent
set cursorline                         " Cursor Highlight, Color
set number                             " Show absolute number for cursor line
set relativenumber                     " Line numbers relative to cursor line
set cmdwinheight=1                     " Self-explanatory
set ttyscroll=3                        " Speeds up screen redrawing
set lazyredraw                         " To avoid scroll lag on long ass lines
set scrolloff=10                       " Minimum # of lines shown above/below cursor
set splitbelow                         " Split windows as expected
set splitright
set wmh=0 wmw=0                        " Only see filename when minimized
augroup no_indent
  autocmd!
  autocmd FileType text set formatoptions=rol
augroup END

" Colors & Statusline
" Statusline modified from
" https://medium.com/@kadek/the-last-statusline-for-vim-a613048959b2
if has('gui_running')
  set guioptions=
  set guifont=Monaco
else
  " TODO(trandustin): for iterm2, monokai's color is warped
  " set t_Co=256
  " set termguicolors
endif
colorscheme monokai
syntax enable
set noshowmode
set notitle
set laststatus=2
set statusline=
set statusline+=%2*\ %{fugitive#head()}
set statusline+=%2*\ ››
set statusline+=\ %*
set statusline+=%1*\ %m             " Modified flag
set statusline+=%1*\ %r             " Read-only flag
set statusline+=%1*\ %f\ %*         " Relative path to file
set statusline+=%1*\ ››
set statusline+=%=                  " Switch to right-hand-side
set statusline+=%3*\ ‹‹
set statusline+=%3*\ %{&ft}         " Filetype
set statusline+=%3*\ %cC            " Column number
set statusline+=%3*\ %p%%\ %*       " Percentage through file
hi User1 guifg=#FFFFFF guibg=#191f26 gui=BOLD
hi User2 guifg=#000000 guibg=#959ca6
hi User3 guifg=#000000 guibg=#4cbf99

" Tab Settings
set expandtab                          " Spaces as tabs
set shiftwidth=2                       " 2-character tabs
set softtabstop=2                      " Fix it to 2

" 1 sec <Esc> delay in terminal? Vim pls
set noesckeys
nnoremap <Esc> <Nop>

augroup misc
  autocmd!
  " Remove any trailing whitespace in the file
  autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
  " Auto-open last file if calling Vim without arguments
  " Currently bugged when trying to use Vim also as manpager
  if has('gui_running')
    autocmd VimEnter * nested if
      \ argc() == 0 &&
      \ bufname("%") == "" &&
      \ bufname("2" + 0) != "" |
      \   exe "normal! `0" |
      \ endif
  endif
augroup END

" Functions
" -----------------------------------------------------------------------------

"###############################################################################
" folding styles
"###############################################################################

function! FoldLevels()
  let thisline = getline(v:lnum)
  if thisline != ''
    let nextline = getline(v:lnum + 1)
    if match(nextline, '-\{5,\}$') >= 0
      return ">1"
    endif
  endif
  return "="
endfunction

function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('»' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldmethod=expr
set foldexpr=FoldLevels()
set foldtext=NeatFoldText()

"###############################################################################
" When 'dd'ing blank lines, don't yank them into the register
"###############################################################################

function! DDWrapper()
  if getline('.') =~ '^\s*$'
    normal! "_dd
  else
    normal! dd
  endif
endfunction
nnoremap <silent> dd :call DDWrapper()<CR>

"###############################################################################
" Restore cursor to previous position and unfold just enough to see cursor line
"###############################################################################

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

if has("folding")
  function! UnfoldCur()
  if !&foldenable
    return
  endif
  let cl = line(".")
  if cl <= 1
    return
  endif
  let cf  = foldlevel(cl)
  let uf  = foldlevel(cl - 1)
  let min = (cf > uf ? uf : cf)
  if min
    execute "normal!" min . "zo"
    return 1
  endif
  endfunction
endif

augroup resCur
  autocmd!
  if has("folding")
    autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
  else
    autocmd BufWinEnter * call ResCur()
  endif
augroup END

"###############################################################################
" Fold all toggle
"###############################################################################

let g:foldtoggle = 0
function! FoldAllToggle()
  if g:foldtoggle == 0
    let g:foldtoggle = 1
    normal! zR
  else
    let g:foldtoggle = 0
    normal! zM
  endif
endfunction
noremap <silent> <S-Space> :call FoldAllToggle()<CR>
" A temporary workaround for terminal Vim, since foldlevelstart ain't working
"noremap <silent> <S-F1> :call FoldAllToggle()<CR>
if !has('gui_running')
augroup auto_fold
  autocmd!
  autocmd VimEnter * call FoldAllToggle()
augroup END
endif

"####
" Shortcut to delete current file
"####
function! Delete()
  call delete(expand('%')) | bdelete!
endfunction

" Mappings
" -----------------------------------------------------------------------------

"###############################################################################
" General
"###############################################################################

let mapleader = ","
nnoremap <silent> <C-e> :silent e#<CR>
noremap j gj
noremap gj j
noremap k gk
noremap gk k
noremap ; :
nnoremap <C-a> ggVG
nnoremap <Space> za
nnoremap <silent> <Leader><Space> :set hlsearch!<CR>
vnoremap < <gv
vnoremap > >gv
noremap <S-CR> O<Esc>
noremap <CR> o<Esc>
nnoremap x "_x
nnoremap Y y$
cnoremap <C-v> <C-R>*<BS>
inoremap <C-v> <C-R>*
noremap Q @
nnoremap ' '.
noremap <silent> <C-y> :let @+=expand("%:p:h")<CR>

"###############################################################################
" Buffers, Windows, & Tabs
"###############################################################################
" I use a combination of windows and tabs. I use netrw for a file
" explorer. I use fzf for farther searching across directories. I
" don't use buffers or markers.

noremap  <silent> <C-t> :tabe<CR>
noremap! <silent> <C-t> :tabe<CR>
" Lexplore doesn't toggle if directory or opened file changes. Use
" this hack instead.
let g:NetrwIsOpen = 0
function! ToggleLexplore()
  if g:NetrwIsOpen
    let i = bufnr("$")
    while (i >= 1)
      if (getbufvar(i, "&filetype") == "netrw")
        silent exe "bwipeout " . i
      endif
      let i-=1
    endwhile
    let g:NetrwIsOpen=0
  else
    let g:NetrwIsOpen=1
    silent Lexplore
  endif
endfunction
" TODO(trandustin): close netrw after opening
nnoremap <silent> <C-q> :call ToggleLexplore()<CR>
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_list_hide = '.DS_Store,.*\.pyc$'
let g:netrw_liststyle = 3
let g:netrw_winsize = 30

" Plugins
" -----------------------------------------------------------------------------

"###############################################################################
" Ctrl-P
"###############################################################################

" nnoremap <C-p> :History<CR>
" let g:fzf_history_dir = '~/.cache/fzf'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
set wildignore+=*.doc,*.docx,*.ods,*.xlsx
set wildignore+=*.db,*.epub,*.lnk,*.mobi,*.pdf
set wildignore+=*.git,*.pyc,*.pyo,*.exe,*.dll,*.obj,*.o,*.a,*.lib,*.so,*.dylib
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.flac,*.mp3
set wildignore+=*.mkv
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

"###############################################################################
" Matchit
"###############################################################################

map <Tab> %
" The new "go back to back". This is because <Tab> is equivalent to <C-i>
noremap <Leader>i <C-i>

"###############################################################################
" NERDCommenter
"###############################################################################

map <silent> <Leader>cc <plug>NERDCommenterComment
vmap <silent> <Leader>cc <plug>NERDCommenterAlignBoth
vmap <silent> <Leader>cs <plug>NERDCommenterSexy
vmap <silent> <Leader>cu <plug>NERDCommenterUncomment
map <silent> <Leader>cu <plug>NERDCommenterUncomment
 let NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters = {
  \ 'pentadactyl': { 'left': '"' },
  \ 'rtex': { 'left': '%' },
  \ 'snippet': { 'left': '#' },
  \ 'python': { 'left': '#' },
  \ }

"###############################################################################
" Snipmate
"###############################################################################

let g:snippets_dir = '~/.vim/bundle/dvt/snippets'

" To reload the snippets whenever I rewrite them
augroup snippets
  autocmd!
  " Works only for .snippets. Will reload them all once I leave its buffer
  " This doesn't quite work out
  " autocmd FileType snippets BufLeave call ReloadAllSnippets()
  "
  " This one does work, but it's computationally unpleasant in that I don't need to call it for /every/ file
  autocmd BufWritePost * call ReloadAllSnippets()
augroup END

" Specific Filetypes
" -----------------------------------------------------------------------------

let g:tex_flavor = "latex"

augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.Rtex set filetype=rtex
  autocmd BufNewFile,BufRead *.md,*.Rmd set filetype=markdown
  autocmd BufNewFile,BufRead *.Rhtml,*.hbs set filetype=html
  autocmd FileType plaintex,tex,rtex call TexMacros()
"temp
  autocmd FileType plaintex,tex,rtex set foldmethod=marker
  autocmd FileType plaintex,tex,rtex nnoremap <buffer> <silent> <Leader>p :call OpenPDF()<CR>
  autocmd FileType html,markdown nnoremap <buffer> <silent> <Leader>p :call OpenBrowser()<CR>
  autocmd FileType python setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype markdown call Markdown()
  " this sorts import statements; requires installation of isort
  "autocmd FileType python nnoremap <Leader>i :!isort %<CR><CR>
augroup END

function! s:Expr(default, repl)
  " Allows abbreviations starting with \
  if getline('.')[col('.')-2]=='\'
    return "\<bs>".a:repl
  else
    return a:default
  endif
endfunction

function! TexMacros()
  " Map TeX macros
  "inoreabbrev mb <c-r>=<sid>Expr('mb', '\mathbb')<cr>
  inoreabbrev mc <c-r>=<sid>Expr('mc', '\mathcal')<cr>
  inoreabbrev mf <c-r>=<sid>Expr('mf', '\mathfrak')<cr>
  inoreabbrev ms <c-r>=<sid>Expr('ms', '\mathscr')<cr>
  "inoreabbrev mbf <c-r>=<sid>Expr('mbf', '\mathbf')<cr>
  inoreabbrev mrm <c-r>=<sid>Expr('mrm', '\mathrm')<cr>
  inoreabbrev trm <c-r>=<sid>Expr('trm', '\textrm')<cr>
  inoreabbrev op <c-r>=<sid>Expr('op', '\operatorname')<cr>
  inoreabbrev tt <c-r>=<sid>Expr('tt', '\text')<cr>
  inoreabbrev tbf <c-r>=<sid>Expr('tbf', '\textbf')<cr>
  inoreabbrev tit <c-r>=<sid>Expr('tit', '\textit')<cr>
  inoreabbrev tsc <c-r>=<sid>Expr('tsc', '\textsc')<cr>
  inoreabbrev ttt <c-r>=<sid>Expr('ttt', '\texttt')<cr>
  inoreabbrev bs <c-r>=<sid>Expr('bs', '\backslash')<cr>
  inoreabbrev tbs <c-r>=<sid>Expr('tbs', '\textbackslash')<cr>
  inoreabbrev hat <c-r>=<sid>Expr('hat', '\widehat')<cr>
  inoreabbrev tilde <c-r>=<sid>Expr('tilde', '\widetilde')<cr>
  "inoreabbrev sub <c-r>=<sid>Expr('sub', '\subset')<cr>
  "inoreabbrev sup <c-r>=<sid>Expr('sup', '\supset')<cr>
  "inoreabbrev sube <c-r>=<sid>Expr('sube', '\subseteq')<cr>
  "inoreabbrev supe <c-r>=<sid>Expr('supe', '\supseteq')<cr>
  inoreabbrev latex <c-r>=<sid>Expr('latex', '\LaTeX')<cr>
endfunction

function! OpenPDF()
  " Open the pdf of the present working file
  "silent !open "%:r.pdf" &
  silent !open -n "/Applications/Skim.app" --args "%:p:r.pdf" &
endfunction

function! OpenBrowser()
  " Open the file in Safari
  if &filetype == "markdown"
    " Convert to html if markdown first
    "silent !grip "%" --export  "%:p:r.html"
    silent !pandoc "%" -f markdown_github -t html -c markdown7.css -s -S -o "%:p:r.html"
    silent !open "%:p:r.html" &
  elseif &filetype == "html"
    silent !open "%:p" &
  endif
endfunction

" TODO: Set it to run in background somehow. Then if it never updates/errors, have a keybind to do rubber-info
function! TeXCompile()
  " Compile tex file in its working directory, then remove auxiliary outputs.
  if &filetype == 'tex'
    " Compile the master file if in my lecture/section file naming convention.
    if expand("%") =~ "^[0-9abcr]\\+_lecture_[0-9]\\{2\\}\.tex"
      cd %:p:h
      let thisfile = split(expand("%"), "_lecture")[0]
      let thisfile = join([thisfile, "_lecture"], "")
      execute "!latexmk -pdf " . join([thisfile, ".tex"], "")
    elseif expand("%") =~ "^[0-9]\\+_section_[0-9]\\{2\\}\.tex"
      cd %:p:h
      let thisfile = split(expand("%"), "_section")[0]
      let thisfile = join([thisfile, "_lecture"], "")
      execute "!latexmk -pdf " . join([thisfile, ".tex"], "")
    " Compile current file.
    else
      cd %:p:h
      !latexmk -pdf "%"
      let thisfile = expand("%:r")
    endif
  " Generate tex file and then compile if rtex.
  elseif &filetype == 'rtex'
    cd %:p:h
    !Rscript -e "library(knitr); knit('%')"
    !latexmk -pdf "%:r.tex"
    silent !rm "%:r.tex"
    let thisfile = expand("%:r")
  endif
  if &filetype == 'tex' || &filetype == 'rtex'
    silent execute "!rm " . join([thisfile, ".aux"], "")
    silent execute "!rm " . join([thisfile, ".log"], "")
    silent execute "!rm " . join([thisfile, ".out"], "")
    silent execute "!rm " . join([thisfile, ".dvi"], "")
  endif
endfunction

function! Markdown()
  " Use folding style based on subsection headings
  function! MarkdownFoldLevels()
    let thisline = getline(v:lnum)
    if match(thisline, '^##[^#]') >= 0
      return ">1"
    elseif thisline != ''
      let nextline = getline(v:lnum + 1)
      if match(nextline, '-\{5,\}$') >= 0
        return ">1"
      endif
    endif
    return "="
  endfunction
  setlocal foldexpr=MarkdownFoldLevels()
endfunction
