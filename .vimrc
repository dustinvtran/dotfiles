"
" ~/.vimrc
" Author: Dustin Tran <dustinvtran.com>
"
" Settings
" -----------------------------------------------------------------------------

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'benjifisher/matchit.zip'
Plugin 'bling/vim-airline'
Plugin 'bufexplorer.zip'
Plugin 'dahu/MarkMyWords'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'lilydjwg/colorizer'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'msanders/snipmate.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
"Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'file:///home/dvt/.vim/dvt'
call vundle#end()
filetype plugin on

" System Settings
set encoding=utf-8
set showcmd                            " Display partial commands
augroup stahp
  autocmd!
  autocmd GUIEnter * set visualbell t_vb=  " Disable error bells
augroup END
set autochdir                          " Auto-cd into the file's dir
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
set wildmenu                           " Tab-completion features in cmd-line mode
set wildmode=list:full

" Formatting
set backspace=indent,eol,start         " Expected backspacing
set linebreak                          " Don't linebreak words in the middle
set display=lastline                   " Displays partial wrapped lines
set tw=80                              " Auto linebreak at 80 characters
set formatoptions=rotcq                " Format options with new lines
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

" Tab Settings
set expandtab                          " Spaces as tabs
set shiftwidth=2                       " 2-character tabs
set softtabstop=2                      " Fix it to 2

" 1 sec <Esc> delay in terminal? Vim pls
set noesckeys
nnoremap <Esc> <Nop>

" Set floating window size to Github's character limit
if has("gui_running")
  set lines=70 columns=127
endif

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

"##############################################################################
" Let twiddle convert swap cases, lowercase all characters, or uppercase all characters
"##############################################################################

function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', twiddlecase(@"), getregtype(''))<cr>gv""pgv

"##############################################################################
" folding styles
"##############################################################################

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

"##############################################################################
" When 'dd'ing blank lines, don't yank them into the register
"##############################################################################

function! DDWrapper()
  if getline('.') =~ '^\s*$'
    normal! "_dd
  else
    normal! dd
  endif
endfunction
nnoremap <silent> dd :call DDWrapper()<CR>

"##############################################################################
" Restore cursor to previous position and unfold just enough to see cursor line
"##############################################################################

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

"##############################################################################
" Open URL in browser
"##############################################################################

nnoremap <silent> ] :silent !rifle <C-R>=escape("<C-R><C-F>", "#?&;\|%")<CR><CR>

"##############################################################################
" Fold all toggle
"##############################################################################

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

"##############################################################################
" Insert Character Function, which is also an atomic operator and has nice shadings
"##############################################################################

let loaded_InsertChar = 1
function! InsertChar(count)
  call inputsave()
  let l:count = a:count
  if ! l:count
    call inputrestore()
    return
  endif
  let l:inserted = ''
  let l:old_match = matcharg(1)
  let l:old_eventignore = &eventignore
  set eventignore+=insertenter,insertleave
  try
    execute 'normal! i' . repeat('_', l:count) . "\<ESC>" . repeat('h', l:count - 1)

    for l:pos in range(l:count)
      execute 'match Error /\%#' . repeat('.', l:count - l:pos) . '/'
      redraw
      let l:char = getchar(0)
      if ! l:char
        redraw
        echohl MoreMsg
        echo 'Char ' . (l:pos + 1) . '/' . l:count . ': '
        echohl None
        let l:char = getchar()
        echo
      endif
      if l:char == 27
        execute 'normal! ' . repeat('h', l:pos) . repeat('x', l:count)
        return
      endif
      undojoin
      execute 'normal! r' . nr2char(l:char)
      let l:inserted .= nr2char(l:char)
      if l:char != 13 && (l:count - l:pos) > 1
        execute 'normal! l'
      endif
    endfor
    silent! call repeat#set('i' . l:inserted . "\<ESC>", -1)
  finally
    if type(l:old_match) == type([]) && strlen(l:old_match[0]) && strlen(l:old_match[1])
      execute 'match' l:old_match[0] '/' . l:old_match[1] . '/'
    else
      match
    endif
    let &eventignore = l:old_eventignore
    call inputrestore()
  endtry
endfunction

" Mappings
" -----------------------------------------------------------------------------

"##############################################################################
" Colemak
"##############################################################################

noremap n gj|noremap N J|noremap <C-n> <C-d>|cnoremap <C-n> <Down>
noremap e gk|noremap E i<CR><Esc>k$|vnoremap K <Esc>i<CR><Esc>k$gv|noremap <C-e> <C-u>|cnoremap <C-e> <Up>
augroup farkin_easymotion
  autocmd!
  autocmd VimEnter * noremap t l
  autocmd VimEnter * noremap s h
augroup END

noremap k n|noremap K N
noremap h e|noremap H )hh|onoremap H )hh|noremap gH (hh|onoremap gH (hh|nnoremap <silent> <C-h> :silent e#<CR>
nnoremap l :<C-U>call InsertChar(v:count1)<CR>
nnoremap L l:<C-U>call InsertChar(v:count1)<CR>
augroup farkin_easymotion2
  autocmd!
  autocmd VimEnter * nnoremap j xph
augroup END

noremap gn j
noremap ge k
noremap <silent> <C-s> :silent update<CR>:call TeXCompile()<CR>
noremap! <silent> <C-s> <Esc>:silent update<CR>:call TeXCompile()<CR>
nnoremap <Leader>s <C-w>W
nnoremap <Leader>t <C-w>w
nnoremap <silent> S :tabp<CR>
nnoremap <silent> T :tabn<CR>

"##############################################################################
" General
"##############################################################################

let mapleader = ","
noremap ; :
nnoremap <C-a> ggVG
nnoremap <Space> za
nnoremap <silent> <Leader><Space> :set hlsearch!<CR>
vnoremap < <gv
vnoremap > >gv
noremap <S-CR> O<Esc>
noremap <CR> o<Esc>
nnoremap <Leader><CR> o<Esc>k
nnoremap <Leader><S-CR> O<Esc>j
nnoremap <Leader>c "_c
vnoremap <Leader>c "_c
nnoremap <Leader>C "_C
vnoremap <Leader>C "_C
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>D "_D
vnoremap <Leader>D "_D
nnoremap x "_x
nnoremap Y y$
cnoremap <C-v> <C-R>*<BS>
inoremap <C-v> <C-R>*
nnoremap z s
vnoremap z s
noremap Q @
nnoremap ' '.
noremap W )|onoremap W )
noremap B (|onoremap B (
nnoremap <Leader>w }
nnoremap <Leader>b {

"##############################################################################
" Buffers, Windows, & Tabs
"##############################################################################

" Buffers
" See BufExplorer

" Windows
nnoremap      <C-x> <C-w>s
nnoremap      <C-v> <C-w>v
noremap  <silent> <C-w> :q<CR>
noremap! <silent> <C-w> :q<CR>
noremap       <F1>  <C-w>+
noremap       <F2>  <C-w>-
noremap       <F3>  <C-w>>
noremap       <F4>  <C-w><
noremap       <F5>  <C-w>=
function! MarkWindowSwap()
  let g:markedWinNum = winnr()
endfunction
function! DoWindowSwap()
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe g:markedWinNum . "wincmd w"
  let markedBuf = bufnr( "%" )
  exe 'hide buf' curBuf
  exe curNum . "wincmd w"
  exe 'hide buf' markedBuf
endfunction
nnoremap <silent> <Leader>m         :call MarkWindowSwap()<CR>
nnoremap <silent> <Leader><Leader>m :call DoWindowSwap()<CR>

" Tabs
noremap  <silent> <C-t> :tabe<CR>
noremap! <silent> <C-t> :tabe<CR>

" Plugins
" -----------------------------------------------------------------------------

"##############################################################################
" Buffer Explorer
"##############################################################################

nnoremap <silent> <C-c> :silent BufExplorer<CR>

"##############################################################################
" Colors & Airline
"##############################################################################

" Temporary until I can get monokai working for terminal
if has('gui_running')
  colorscheme monokai
else
  colorscheme molokai
endif
syntax enable
set guioptions=
set notitle
set guifont=tewi\ 8
set laststatus=2
set noshowmode
"let g:airline_theme='molokai'
augroup airlineTheme
  autocmd!
  autocmd VimEnter * AirlineTheme molokai
augroup END
let g:airline_left_sep='⮀'
let g:airline_right_sep='⮂'
let g:airline#extensions#whitespace#enabled = 0
"let g:airline_section_c='%f%m'
let g:airline_section_x=''
let g:airline_section_y="%{strlen(&filetype)>0?&filetype:''}"
let g:airline_section_z='%p%%'
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V·L',
  \ '' : 'V·B',
  \ 's'  : 'S',
  \ 'S'  : 'S·L',
  \ '' : 'S·B',
  \ }

"##############################################################################
" Ctrl-P
"##############################################################################

let g:ctrlp_map = '<C-f>'
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-e>', '<up>'],
  \ 'PrtHistory(-1)':     [''],
  \ 'PrtCurEnd()':      [''],
  \ }
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

"##############################################################################
" EasyMotion
"##############################################################################

" Keys are written by optimizin via homerow, then tweaked by personal preference
let g:EasyMotion_keys = 'hneiotsradluygpfwqkmvc;xzbjEIOTSRAHDLUYGPFWQKMVCXZBJ'
" I require only two EasyMotion keybinds for all my nifty teleportation: f/F. The 'f/F' defaults are set for normal/visual
" modes, and the 't/T' defaults are set for operator mode (primarily d/c/y)
let g:EasyMotion_mapping_f = 'f'
let g:EasyMotion_mapping_F = 'F'
let g:EasyMotion_mapping_t = 't'
let g:EasyMotion_mapping_T = 'T'
augroup tilthefs
  autocmd!
  autocmd VimEnter * omap f t
  autocmd VimEnter * omap F T
augroup END

"##############################################################################
" Matchit
"##############################################################################

map <Tab> %
" The new "go back to back". This is because <Tab> is equivalent to <C-i>
noremap <C-p> <C-i>

"##############################################################################
" MarkMyWords
"##############################################################################

nnoremap <silent> <Leader>h :silent MMWSelect helpmark<CR>

"##############################################################################
" NERDCommenter
"##############################################################################

map <silent> <Leader>cc <plug>NERDCommenterComment
vmap <silent> <Leader>cc <plug>NERDCommenterAlignBoth
vmap <silent> <Leader>cs <plug>NERDCommenterSexy
vmap <silent> <Leader>cu <plug>NERDCommenterUncomment
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters = {
  \ 'pentadactyl': { 'left': '"' },
  \ 'rtex': { 'left': '%' },
  \ 'snippet': { 'left': '#' }
  \ }

"##############################################################################
" NERDTree
"##############################################################################

nnoremap <silent> <C-q> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1

"##############################################################################
" Set Color
"##############################################################################

"augroup color_scheme
"  autocmd!
"  autocmd VimEnter * silent SetColors all
"augroup END
"nnoremap <silent> <Leader>e :call NextColor(-1)<CR>
"nnoremap <silent> <Leader>r :call NextColor(1)<CR>

"##############################################################################
" Snipmate
"##############################################################################

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

"##############################################################################
" Surround
"##############################################################################

" Let 's' be the surround function for visual mode. This defaults to 'S', but I can always 'c' in visual mode over 's' anyways
vmap s <Plug>VSurround
" So the '\' surround command does '\[...\]'
let g:surround_92 = "\\[\n\r\n\\]"
" Remaps \[ as shortcut to in-line surround with '\[...\]'. It requires 'map' since I need the above hotkey for 's\'
nmap <silent> \[ yss\

" Specific Filetypes
" -----------------------------------------------------------------------------

let g:tex_flavor = "latex"

augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.Rtex set filetype=rtex
  autocmd BufNewFile,BufRead *.md,*.Rmd set filetype=markdown
  autocmd BufNewFile,BufRead *.Rhtml,*.hbs set filetype=html
  autocmd FileType plaintex,tex,rtex call TexMacros()
  autocmd FileType plaintex,tex,rtex nnoremap <silent> <Leader>s :call OpenPDF()<CR>
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd Filetype markdown call Markdown()
augroup END

function! TexMacros()
  inoreabbrev bb <c-r>=<sid>Expr('bb', '\mathbb')<cr>
  inoreabbrev rm <c-r>=<sid>Expr('rm', '\mathrm')<cr>
  inoreabbrev trm <c-r>=<sid>Expr('trm', '\textrm')<cr>
  inoreabbrev tt <c-r>=<sid>Expr('tt', '\text')<cr>
  inoreabbrev ttt <c-r>=<sid>Expr('ttt', '\texttt')<cr>
  inoreabbrev latex <c-r>=<sid>Expr('latex', '\LaTeX')<cr>
endfunction

"This allows abbreviations starting with \
function! s:Expr(default, repl)
  if getline('.')[col('.')-2]=='\'
    return "\<bs>".a:repl
  else
    return a:default
  endif
endfunction

function! OpenPDF()
  silent !zathura "%:r".pdf &
endfunction

function! TeXCompile()
  if &filetype=='tex'
    " TODO: Set it to run in background somehow. Then if it never updates/errors, have a keybind to do rubber-info
    "if @% == "[0-9]+-lecture-[0-9]{2}.tex"
    "  compile master
    "else
      cd %:p:h
      !xelatex "%"
      silent !rm "%:r.aux"
      silent !rm "%:r.log"
      silent !rm "%:r.out"
    "endif
  endif
  if &filetype=='rtex'
    cd %:p:h
    !Rscript -e "library(knitr); knit('%')"
    !rubber -d "%:p:r.tex"
    silent !rm "%:r.aux"
    silent !rm "%:r.log"
    silent !rm "%:r.out"
    silent !rm "%:r.tex"
  endif
endfunction

function! Markdown()
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
