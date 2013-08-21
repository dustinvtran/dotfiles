"
" Vim dotfile
" ~/.vimrc
" Name: nil
"
" Settings {{{
" -----------------------------------------------------------------------------

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'benjifisher/matchit.zip'
Bundle 'bling/vim-airline'
Bundle 'bufexplorer.zip'
Bundle 'dahu/MarkMyWords'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'skammer/vim-css-color'
"Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'file:///home/nil/.vim/bundle/nil'
filetype plugin on

" System Settings.
set encoding=utf-8
set showcmd                                  " Display partial commands.
set noerrorbells visualbell t_vb=            " Disable error bells.
augroup stahp
    autocmd!
    autocmd GUIEnter * set visualbell t_vb=  " I need this one to prevent screen flashes.
augroup END
set autochdir                                " Auto-cd into the file's dir.
set hidden                                   " Change buffers without saving.
set shortmess=I                              " Disable intro message.
set mouse=a                                  " Mouse support in terminal.
set autoread                                 " Reload files outside vim.
set clipboard=unnamed                        " Set to system's clipboard register.

" Temp Directories.
set backup                                   " Enable backups.
set noswapfile                               " It's 2013, Vim.
set undofile                                 " Enable persistent undo.
set backupdir=~/.vim/tmp/backup
set undodir=~/.vim/tmp/undo
set viminfo='10,\"100,:20,%

" Searching, Highlighting, Replacing Settings.
set ignorecase                               " Case-insensitive matching...
set smartcase                                "  except case-sensitive searches.
set incsearch                                " Incremental searching.
set gdefault                                 " Default: Substitute all occurrences only in line.
set wildmenu                                 " Tab-completion features in cmd-line mode.
set wildmode=list:full
set foldmethod=marker                        " Custom folding.

" Formatting.
set backspace=indent,eol,start               " Expected backspacing.
set linebreak                                " Don't linebreak words in the middle.
set display=lastline                         " Displays partial wrapped lines.
set cursorline                               " Cursor Highlight, Color
set number                                   " Show absolute number for cursor line.
set relativenumber                           " Line numbers relative to cursor line.
set cmdwinheight=1                           " Self-explanatory.
set ttyscroll=3                              " Speeds up screen redrawing.
set lazyredraw                               " To avoid scroll lag on long ass lines.
set scrolloff=10                             " Minimum # of lines shown above/below cursor.
set splitbelow                               " Split windows as expected.
set splitright
set wmh=0 wmw=0                              " Only see filename when minimized.
augroup no_indent
    autocmd!
    autocmd FileType * set formatoptions=rol
augroup END

" Tab Settings.
set expandtab                                " Spaces as tabs.
set shiftwidth=4                             " 4-character tabs.
set softtabstop=4                            " Fix it to 4.

" 1 sec <Esc> delay in terminal? Vim pls.
set noesckeys
nnoremap <Esc> <Nop>

" Set floating window size, but not for console Vim.
if has("gui_running")
  set lines=49 columns=127
endif

augroup misc
    autocmd!
    " Remove any trailing whitespace in the file.
    autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
    " Auto-open last file if invoked without arguments.
    autocmd VimEnter * nested if
      \ argc() == 0 &&
      \ bufname("%") == "" &&
      \ bufname("2" + 0) != "" |
      \   exe "normal! `0" |
      \ endif
    " Auto-load vimrc on write. The third line is simply to get my formatoptions again when it reloads. Cuz I hate 'em!
    autocmd BufWritePost $myvimrc nested source $myvimrc
    autocmd BufWritePost $myvimrc set formatoptions-=c formatoptions-=t formatoptions-=q formatoptions+=r formatoptions+=o formatoptions+=l
augroup END

" }}}
" Functions {{{
" -----------------------------------------------------------------------------

"##############################################################################
" Better styling of folds.
"##############################################################################

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
set foldtext=NeatFoldText()

"##############################################################################
" When 'dd'ing blank lines, don't yank them into the register.
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
" Restore cursor to previous position and unfold just enough to see cursor line.
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
" Open URL in browser.
"##############################################################################

nnoremap <silent> ] :silent !rifle <C-R>=escape("<C-R><C-F>", "#?&;\|%")<CR><CR>

"##############################################################################
" Fold all toggle.
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
" A temporary workaround for terminal Vim, since foldlevelstart ain't working.
"noremap <silent> <S-F1> :call FoldAllToggle()<CR>
if !has('gui_running')
augroup auto_fold
    autocmd!
    autocmd VimEnter * call FoldAllToggle()
augroup END
endif

"##############################################################################
" Insert Character Function, which is also an atomic operator and has nice shadings.
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
" Have to do autocmd for now, because of weird YankStack.
augroup fuck_you_yankstack
    autocmd!
    autocmd VimEnter * nnoremap s :<C-U>call InsertChar(v:count1)<CR>
    autocmd VimEnter * nnoremap S l:<C-U>call InsertChar(v:count1)<CR>
augroup END

" }}}
" Mappings {{{
" -----------------------------------------------------------------------------

"##############################################################################
" General
"##############################################################################

let mapleader = ","
noremap ; :
noremap <silent> <C-s> :silent update<CR>:call LaTeXBuild()<CR>
noremap! <silent> <C-s> <Esc>:silent update<CR>:call LaTeXBuild()<CR>
noremap <silent> j gj
noremap <silent> k gk
noremap gj j
noremap gk k
noremap <C-j> <C-d>
noremap <C-k> <C-u>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
nnoremap K i<CR><Esc>k$
nnoremap <C-a> ggVG
nnoremap <silent> <C-e> :silent e#<CR>
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
nnoremap z s
vnoremap z s
noremap Q @
nnoremap ' '.
augroup farkin_easymotion
    autocmd!
    autocmd VimEnter * nnoremap t xph
augroup END
noremap W )
noremap B (
noremap E )hh
noremap gE (hh
onoremap W )
onoremap B (
onoremap E )hh
onoremap gE (hh
nnoremap <Leader>w }
nnoremap <Leader>b {

"##############################################################################
" Buffers, Windows, & Tabs
"##############################################################################

" Buffers
" See BufExplorer/NERDTree>

" Windows
" See BufExplorer/NERDTree>
noremap <silent> <C-w> :q<CR>
noremap! <silent> <C-w> :q<CR>
noremap <silent> <F1> <C-w>+
noremap <silent> <F2> <C-w>-
noremap <silent> <F3> <C-w>>
noremap <silent> <F4> <C-w><
noremap <silent> <F5> <C-w>=
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
nnoremap <silent> <Leader>m :call MarkWindowSwap()<CR>
nnoremap <silent> <Leader><Leader>m :call DoWindowSwap()<CR>
nnoremap <c-h> <C-w>W
nnoremap <c-l> <C-w>w

" Tabs
nnoremap <silent> H :tabp<CR>
nnoremap <silent> L :tabn<CR>

" }}}
" Plugins {{{
" -----------------------------------------------------------------------------

"##############################################################################
" Buffer Explorer
"##############################################################################

nnoremap <silent> <C-c> :silent BufExplorer<CR>
nnoremap <silent> <C-x> <C-w>s:silent BufExplorer<CR>
nnoremap <silent> <C-v> <C-w>v:silent BufExplorer<CR>
noremap <silent> <C-t> :tabe<CR>:silent BufExplorer<CR>
noremap! <silent> <C-t> :tabe<CR>:silent BufExplorer<CR>

"##############################################################################
" Colors & Airline
"##############################################################################

colorscheme nil
set background=light
syntax enable
set guioptions=
set notitle
set guifont=lemon
set laststatus=2
set noshowmode
let g:airline_left_sep='⮀'
let g:airline_right_sep='⮂'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='solarized'
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
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
set wildignore+=*.doc,*.docx,*.ods,*.xlsx
set wildignore+=*.db,*.epub,*.lnk,*.mobi,*.pdf
set wildignore=.git,*.pyc,*.pyo,*.exe,*.dll,*.obj,*.o,*.a,*.lib,*.so,*.dylib
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.flac,*.mp3
set wildignore+=*.mkv
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

"##############################################################################
" EasyMotion
"##############################################################################

" Homerow optimized, then tweaked by personal preference.
let g:EasyMotion_keys = 'jklfdsaguiotrewqnmvcpxzbyKLFDSAHGUIOTREWQNMVCPXZBYh'
" I require only two EasyMotion keybinds for all my nifty teleportation: f/F. The 'f/F' defaults are set for normal/visual
" modes, and the 't/T' defaults are set for operator mode (primarily d/c/y).
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
" The new "go back to back". This is because <Tab> is equivalent to <C-i>.
noremap <C-p> <C-i>

"##############################################################################
" MarkMyWords
"##############################################################################

nnoremap <silent> <Leader>h :silent MMWSelect helpmark<CR>

"##############################################################################
" NERDCommenter
"##############################################################################

vmap <silent> <Leader>cc <plug>NERDCommenterAlignBoth
vmap <silent> <Leader>cs <plug>NERDCommenterSexy
vmap <silent> <Leader>cu <plug>NERDCommenterUncomment
" For commenting Snippets plugin.
"let g:NERDCustomDelimiters = {
"        \ 'snippets': { 'left': '#' },
" Apparently .tex works. But why not .asdf or .snippets?
        "\ 'tex': { 'left': '#' }
"\ }
"The defaults don't work either.
    "let g:NERDCustomDelimiters = {
        "\ 'ruby': { 'left': '#', 'leftAlt': 'FOO', 'rightAlt': 'BAR' },
        "\ 'grondle': { 'left': '{{', 'right': '}}' }
    "\ }

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

augroup color_scheme
    autocmd!
    autocmd VimEnter * silent SetColors all
augroup END
nnoremap <silent> <Leader>e :call NextColor(-1)<CR>
nnoremap <silent> <Leader>r :call NextColor(1)<CR>

"##############################################################################
" Snipmate
"##############################################################################

let g:snippets_dir = '~/.vim/bundle/nil/snippets'

" To reload the snippets whenever I rewrite them.
augroup snippets
    autocmd!
    " Works only for .snippets. Will reload them all once I leave its buffer.
    " This doesn't quite work out.
    " autocmd FileType snippets BufLeave call ReloadAllSnippets()
    "
    " This one does work, but it's computationally unpleasant in that I don't need to call it for /every/ file.
    autocmd BufWritePost * call ReloadAllSnippets()
augroup END

"##############################################################################
" Surround
"##############################################################################

" Let 's' be the surround function for visual mode. This defaults to 'S', but I can always 'c' in visual mode over 's' anyways.
vmap s <Plug>VSurround
" So the '\' surround command does '\[...\]'.
let g:surround_92 = "\\[\r\\]"
" Remaps \[ as shortcut to in-line surround with '\[...\]'. It requires 'map' since I need the above hotkey for 's\'.
nmap <silent> \[ yss\

" Parity Dollar Sign.

" Bug: It spits out an error if there's no '$' in the buffer.
" '$' acts like this: map! modes            Default;
"                     Normal mode           if even # of '$', then surround inner WORD with '$';
"                                           if odd $ of '$',  then append '$';
"                     Operator/Visual mode  Surround with '$' with a single key.
function! ParityDollarSign()
    normal! mz
    "Note there's no g flag because I have it as default.
    %s/\$//n
    let i = split(v:statusmsg)[0]
    if i % 2
        normal! `za$
    else
        normal! `zviW
        normal s$
        normal! E
    endif
endfunction

augroup tex_only
    autocmd!
    autocmd FileType tex nnoremap <buffer> <silent> $ :call ParityDollarSign()<CR>
augroup END

"##############################################################################
" YankRing:
"##############################################################################
" Uncomment when I put in YankRing again.
"""nnoremap <silent> <Leader>p :YRShow<CR>
"""" Clipboard unnnamed doesn't work with YankRing since it remaps p and P to something stupid. Here I'm resetting it to work again.
"augroup yanks
"   autocmd!
    """autocmd VimEnter * unmap p
    """autocmd VimEnter * unmap P
"augroup END
"""let g:yankring_min_element_length = 2

"Both Yank plugins fuck too much mapping behavior over. Also, YankStack doesn't even get a list and it fucks things over anyways, so why no YankRing?
    ""YankStack:
    ""No default keys.
    "let g:yankstack_map_keys = 0
    ""Cycle through yanks. nmap is necessary.
    ""Use <C-n>,<C-p>.
    "nmap <leader>p <Plug>yankstack_substitute_older_paste
    "nmap <leader>P <Plug>yankstack_substitute_newer_paste
    ""List yanks.
    ""nnoremap <silent> <Leader>p :Yanks<CR>
    ""So it works with clipboard=unnamed.
    "augroup yanks
        "autocmd!
        "autocmd VimEnter * unmap p
    "augroup END
" Make shift operators consistent.
    "call yankstack#setup()
nnoremap Y y$

" Command-line/Insert paste shortcuts.
cnoremap <C-v> <C-R>*<BS>
inoremap <C-v> <C-R>*

" }}}
" Specific Filetypes {{{
" -----------------------------------------------------------------------------

"##############################################################################
" LaTeX
"##############################################################################
" Always use LaTeX. It's 2013 Vim. Who needs TeX?
let g:tex_flavor = "latex"

augroup latex
    autocmd!
    autocmd FileType plaintex,tex call Macros()
    autocmd FileType plaintex,tex nnoremap <silent> <Leader>o :call OpenPDF()<CR>
augroup END

function! Macros()
    inoreabbrev tt <c-r>=<sid>Expr('tt', '\text')<cr>
    inoreabbrev latex <c-r>=<sid>Expr('latex', '\LaTeX')<cr>
endfunction

function! OpenPDF()
  silent !zathura "%:r".pdf &
endfunction

"This allows abbreviations starting with \.
function! s:Expr(default, repl)
  if getline('.')[col('.')-2]=='\'
    return "\<bs>".a:repl
  else
    return a:default
  endif
endfunction

" Temporary.
function! LaTeXBuild()
    if &filetype=='tex'
" pdflatex for TeX Live doesn't support aux directory, only output-dir.
        "silent !start /min pdflatex -aux-directory="/home/nil/.vim/auxiliary" "%" &
" rubber doesn't accept spaces in file names. And since I don't get a minimixed window prompt for linux, don't do silent for now.
         "silent !rubber -d "%" &
         !rubber -d "%" &
         silent !rubber --clean "%" &
    endif
endfunction

"##############################################################################
" Autosave
"##############################################################################
"This prevents auto-saving unsaved files or unnecessarily, and hides command-line spam.
 "This works perfectly, but since my computer fucks up right now when I try to save shit, comment out for now.
"function! FileUpdate()
    "if expand("%") == ""
    "else
        "silent update
        "call LaTeXBuild()
    "endif
"endfunction

"augroup always_update
"   autocmd!
"    autocmd CursorMoved,CursorMovedI * call FileUpdate()
"augroup END

 "Only in .tex files: Call function whenever cursor changes text in either normal or insert mode.
"augroup always_update_tex
   "autocmd!
   "autocmd FileType tex :autocmd CursorMoved,CursorMovedI * call FileUpdate()
""       How to leave this autocmd when I'm not in .tex?
"augroup END
"
"##############################################################################
" LaTeX Auto-Compile & Error Parser
"##############################################################################
" Enable auto-compile current document.
"
" Enable rubber-info to parse log for errors/warnings.
"augroup rubber
    "autocmd!
    "autocmd FileType tex set makeprg=rubber-info\ t.log
    "autocmd FileType tex set errorformat=%f:%l:\ %m
"augroup END
" Other: latexmk (more updated; not user-friendly, no log parser/bad error support, incomplete displays), rubber (outdated, incomplete displays).
"
"augroup AutorunTexbuild
    "autocmd!
    "autocmd FileType tex :if !exists('b:runtexbuild') | call system('$vim/vimfiles/bundle/texbuild-master/texbuild '.shellescape(@%)) | let b:runtexbuild=1 | endif
    "autocmd VimLeave * :call system('killall -TERM texbuild')
"augroup END
"
"augroup latex_stuff
    "autocmd!
    "autocmd FileType tex set makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode
    "autocmd FileType tex set errorformat=%f:%l:\ %m
"augroup END

" }}}
