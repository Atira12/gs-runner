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
    
    normal! gg0

    let methodCalls = []
    while search('\/\W*','W') > 0
	    if getline('.')[0] == '%'
		continue
            endif
	    let currentWord = expand('<cword>')
            let methodCalls += [currentWord]
            call prop_add(line('.'), col('.'), {
            \ 'length': len(currentWord)+1,
            \ 'type': 'gs_method'
            \ }) 
    endwhile

    for methodCall in methodCalls
        execute 'syntax keyword gsMethodCalls' methodCall
    endfor 
    hi def link gsMethodCalls Method 

  finally
     call winrestview(saved_view)
  endtry
endfunction

" PostScript Command Coloring
hi SpecialCommand guifg=#22c4dd 
hi GeneralCommand guifg=#5da26b
hi StructCommand guifg=#aa55a8
hi OperationCommand guifg=#e97f16
hi DrawCommand guifg=#28c345
hi Global guifg=#96697b

" General coloring
hi Bracket guifg=#157887
hi Constant guifg=#c8c137
hi Matrix guifg=#5797a8
hi Method guifg=#22c4dd 
hi Exception guifg=#fc0307

call GSMethodMark() 
syntax match gsComment "%.*" 

syntax keyword gsException
     \ undefined rangecheck syntaxerror typecheck undefinedfilename undefinedresult
     \ unmatchedmark dictstackoverflow

syntax keyword gsMatrix
     \ matrix defaultmatrix currentmatrix scale translate rotate concat setmatrix identmatrix
     \ transform itransform concatmatrix idtransform invertmatrix

syntax keyword gsConstant
     \ true false mark 

syntax keyword gsOperationCommand
     \ if not ifelse or and lt le gt ge ne eq for forall repeat loop quit pathforall 

syntax keyword gsStructCommand
     \ array copy get put getinterval dict begin end index length

syntax keyword gsGeneralCommand
     \ exch dup count roll exec pop add sub mul div idiv abs mod 
     \ ceiling floor round truncate sqrt atan cos sin exp ln log rand neg counttomark

syntax keyword gsSpecialCommand
     \  def bind aload exit pstack aload print stack astore load pathbbox save run restore

syntax keyword gsDrawCommand
     \ stroke strokepath newpath moveto lineto rmoveto rlineto arc arcn closepath 
     \ fill chip pathbox setgray setfont setrgbcolor rcurveto curveto scalefont stringwidth showpage show shfill fill

syntax keyword gsGlobal
     \ gsave grestore currentdict currentlinewidth setdash setlinewidth setlinejoin setlinecap currentpoint

syntax match gsBracket  "[(){}\[\]]"

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

autocmd TextChanged <buffer> call GSMethodMark()
let b:current_syntax = 'gs'
