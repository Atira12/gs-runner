function! gs#RunGS(file_path,vertical)
  belowright call term_start('gs ' .. substitute(a:file_path, "\\~",$HOME,"g"), {'vertical': a:vertical,'term_finish': 'close', 'term_name':'GS'})
endfunction 

function! gs#MultiLineComment()
  let line = getline('.')
  let lineNumber = line('.')
   
  if trim(line)[0] == '%'
    call setline(lineNumber, substitute(line, '%','','g') )
  else
    call setline(lineNumber, '%' .. line)
  endif
endfunction

function! gs#SingleLineComment()
  let line = getline('.')
  let lineNumber = line('.')
   
  if trim(line)[0] == '%'
    call setline(lineNumber, substitute(line, '%','','g') )
  else
    call setline(lineNumber, '%' .. line)
  endif
endfunction

function! gs#RunFileGS(...)
  let file_extension = fnamemodify(a:2,':t:e')
  
  if file_extension != 'ps'
     throw 'Invalid Extension'
  endif 

  if empty(glob(a:2))
     throw 'File not found'
  endif
  
  call gs#RunGS(a:2,a:1)
endfunction

function! gs#RunCurrGS(...)
   let file_path = expand('%:p') 

  if &filetype != 'postscr' 
     throw 'Invalid Extension type'
  endif

  call gs#RunGS(file_path,a:1)     
endfunction 

function! gs#GSProxy(...)
  if a:0  == 2
    call gs#RunFileGS(a:1,a:2)
  elseif a:0 == 1
    call gs#RunCurrGS(a:1)
  endif
endfunction

