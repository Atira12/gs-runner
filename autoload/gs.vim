let s:defaultTerminalParameters = #{
  \ term_finish: 'close',
  \ term_name: 'GS',
  \ vertical: 'false'
\}

function! gs#RunGSTerminal(filePath, overrideTerminalParameters = {})
      belowright call term_start('gs ' .. substitute(a:filePath, "\\~",$HOME,"g"),extend(s:defaultTerminalParameters,a:overrideTerminalParameters))
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
  let fileExtension = fnamemodify(a:1,':t:e')
  
  if fileExtension != 'ps'
     throw 'Invalid Extension'
  endif 

  if empty(glob(a:1))
     throw 'File not found'
  endif
  echo a:0  
  if a:0 == 1
    call gs#RunGSTerminal(a:1)     
  else
    call gs#RunGSTerminal(a:1,a:2)     
  endif
endfunction

function! gs#RunCurrGS(...)
   let filePath = expand('%:p') 

  if &filetype != 'postscr' 
     throw 'Invalid Extension Type'
  endif
  if a:0 == 0
    call gs#RunGSTerminal(filePath)     
  else
    call gs#RunGSTerminal(filePath,a:1)     
  endif
  
endfunction 


