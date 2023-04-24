function! RunGS(file_path,vertical)
  belowright call term_start('gs ' .. substitute(a:file_path, "\\~",$HOME,"g"), {'vertical': a:vertical,'term_finish': 'close', 'term_name':'GS'})
endfunction 

function AddQuote()
  let line = getline('.')
  let lineNumber = line('.')
   
  if trim(line)[0] == '%'
    call setline(lineNumber, substitute(line, '%','','g') )
  else
    call setline(lineNumber, '%' .. line)
  endif
endfunction

function! RunFileGS(...)
  let fnamemodify(a:2,':t:e')
  
  if file_extension != 'ps'
     throw 'Invalid Extension'
  endif 

  if empty(glob(a:2))
     throw 'File not found'
  endif
  
  call RunGS(a:2,a:1)
endfunction

function! RunCurrGS(...)
   let file_path = expand('%:p') 

  if &filetype != 'postscr' 
     throw 'Invalid Extension type'
     return ''
  endif

  call RunGS(file_path,a:1)     
endfunction 

function! GSProxy(...)
  if a:0  == 2
    call RunFileGS(a:1,a:2)
  elseif a:0 == 1
    call RunCurrGS(a:1)
  endif
endfunction

