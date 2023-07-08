" Vim Postscript syntax highlighting 
" Language:     PostScript
" Maintainer:   Anton Antov
" Origin:       https://github.com/Atira12/gs-runner

if exists("b:current_syntax") && b:current_syntax == 'gs'
   finish
endif

if &filetype != 'postscr' || !has('postscript')
   finish
endif

function! GSMethodMark()
  let saved_view = winsaveview()
  try
    if empty(prop_type_get('gs_method',{'bufnr': bufnr('%')}))
            call prop_type_add('gs_method', {
              \ 'bufnr': bufnr('%'),
              \ 'highlight': 'Method',
              \ 'combine': v:true
              \ })
    endif 
    
    call prop_remove({'type': 'gs_method', 'all': v:true})
    
    normal! G$

    let methodCalls = []
    let flags = 'w'
    while search('\/\S*\s',flags) > 0
	    let flags = 'W'
	    if getline('.')[0] == '%' 
		continue
            endif
	    let currentWord = expand('<cWORD>')
            let methodCalls += [currentWord[1:]]
            call prop_add(line('.'), col('.'), {
            \ 'length': len(currentWord)+1,
            \ 'type': 'gs_method'
            \ }) 
    endwhile

    for methodCall in methodCalls
      execute 'syntax keyword  gsMethodCalls ' .. methodCall
    endfor 
    hi def link gsMethodCalls Method 
  finally
     call winrestview(saved_view)
  endtry
endfunction

" PostScript Command Coloring
hi SpecialCommand guifg=#22c4dd 
hi GeneralCommand guifg=#b24e4d
hi StructCommand guifg=#aa55a8
hi OperationCommand guifg=#e97f16
hi DrawCommand guifg=#28c345
hi FileCommand guifg=#9cf7c6
hi Global guifg=#96697b

" General coloring
hi String guifg=#619e88
hi Bracket guifg=#157887
hi Constant guifg=#b5bd85
hi Font guifg=#d8d527
hi Matrix guifg=#5797a8
hi Method guifg=#22c4dd 
hi Exception guifg=#fc0307

call GSMethodMark() 
syntax match gsComment "%.*" 

syntax keyword gsException
     \ undefined rangecheck syntaxerror typecheck 
     \ undefinedfilename undefinedresult
     \ unmatchedmark dictstackoverflow

syntax keyword gsMatrix
     \ gsave grestore
     \ matrix defaultmatrix 
     \  scale translate rotate 
     \ concat setmatrix identmatrix
     \ transform itransform concatmatrix idtransform invertmatrix

syntax keyword gsConstant
     \ true false mark 

syntax match gsGlobalConstant "[a-zA-Z0-9]"

syntax keyword gsOperationCommand
     \ if not ifelse or and lt le gt 
     \ ge ne eq for forall repeat loop clear quit pathforall 

syntax keyword gsStructCommand
     \ array copy get put  getinterval putinterval dict begin end index length string
     \ known countdictstack cleardictstack where

syntax keyword gsGeneralCommand
     \ exch dup count roll exec pop add sub mul div idiv abs mod 
     \ ceiling floor round truncate sqrt 
     \ atan cos sin exp ln log rand neg counttomark

syntax keyword gsSpecialCommand
     \ cvx undef def bind aload exit pstack aload print stack astore load pathbbox save run restore

syntax keyword gsDrawCommand
     \ stroke strokepath newpath setlinewidth setlinejoin setlinecap
     \ moveto lineto rmoveto rlineto arc arcn closepath 
     \ fill chip pathbox setgray setfont 
     \ setrgbcolor rcurveto curveto setdash  
     \ stringwidth shfill fill
     \ rectfill rectstroke ustroke ufill ueofill ustrokepath uappend infill ineofill 
     \ gstate setgstate 

syntax keyword gsFontCommand
     \ showpage show ashow widthshow awidthshow xshow setfont  
     \ yshow xyshow cshow kshow glyphshow stringwidth charpath findfont scalefont
     \  makefont selectfont  definefont

syntax keyword gsFileCommand 
     \ file read write readstring writestring readline flushfile flush  
     \ bytesavailable fileposition setfileposition resetfile deletefile renamefile token filter

syntax keyword gsGlobal
     \  currentdict currentlinewidth 
     \  currentpoint save restore currentfont currentmatrix  currentfile
     \  globaldict errordict systemdict userdict 

syntax match gsBracket  "[{}\[\]]"

syntax region gsString start="(" end=")" contains=gsGlobalContant

hi def link gsString String 
hi def link gsList String 
hi def link gsConstant Constant
hi def link gsBracket Bracket 
hi def link gsComment Comment
hi def link gsMatrix Matrix
hi def link gsException Exception

hi def link gsGeneralCommand GeneralCommand
hi def link gsStructCommand StructCommand
hi def link gsOperationCommand OperationCommand
hi def link gsDrawCommand DrawCommand
hi def link gsGlobal Global
hi def link gsSpecialCommand SpecialCommand
hi def link gsFileCommand FileCommand
hi def link gsGlobalConstant Constant
hi def link gsFontCommand DrawCommand

autocmd TextChangedI *.ps call GSMethodMark()
let b:current_syntax = 'gs'
