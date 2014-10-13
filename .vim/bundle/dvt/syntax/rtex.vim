let b:current_syntax = ''
unlet b:current_syntax
runtime! syntax/tex.vim

let b:current_syntax = ''
unlet b:current_syntax
syntax include @TeX syntax/tex.vim

let b:current_syntax = ''
unlet b:current_syntax
syntax include @R syntax/r.vim
syntax region rCode matchgroup=Snip start="%% begin.rcode" end="%% end.rcode" containedin=@TeX contains=@R

let b:current_syntax = ''
unlet b:current_syntax
syntax include @bash syntax/sh.vim
syntax region bashCode matchgroup=Snip start="%% begin.rcode engine='bash'" end="%% end.rcode" containedin=@TeX contains=@bash

let b:current_syntax = ''
unlet b:current_syntax
syntax include @Python syntax/python.vim
syntax region pythonCode matchgroup=Snip start="%% begin.rcode engine='python'" end="%% end.rcode" containedin=@TeX contains=@Python

hi link Snip SpecialComment
let b:current_syntax = 'rtex'
