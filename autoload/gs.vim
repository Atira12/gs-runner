let s:defaultTerminalParameters = #{
  \ term_finish: 'close',
  \ term_name: 'GS',
  \ vertical: 'false'
\}

let s:defaultInterpreter = 'gs'

function! gs#RunGSTerminal(filePath, overrideTerminalParameters = {})
       belowright  call term_start(s:defaultInterpreter .. ' ' .. expand(a:filePath),extend(s:defaultTerminalParameters,a:overrideTerminalParameters))
endfunction 

function! gs#Export(...)
    try
        if a:0 == 2
           let fileToExport = expand('%:p')
	elseif a:0 == 3
	   let fileToExport = expand(a:3)
	else 
	   throw 'Invalid'
	endif
       call system(s:defaultInterpreter 
       \ .. ' -sDEVICE=' .. a:1 
       \ .. ' -o ' .. a:2 .. ' '
       \ .. fileToExport)
    catch
	echoerr 'Invalid export parameters'
    endtry
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
  let filePath = expand(a:1)
  if !filereadable(filePath) || !&filetype == 'postscr'
     echoerr 'Invalid File'
     return
  endif 

  if a:0 == 1
    call gs#RunGSTerminal(a:1)     
  else
    call gs#RunGSTerminal(a:1,a:2)     
  endif
endfunction

function! gs#RunCurrGS(...)
   let filePath = expand('%:p') 

  if &filetype != 'postscr' 
     echoerr 'Invalid Extension Type'
     return
  endif
  if a:0 == 0
    call gs#RunGSTerminal(filePath)     
  else
    call gs#RunGSTerminal(filePath,a:1)     
  endif
endfunction 
