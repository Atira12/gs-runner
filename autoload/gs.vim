let s:defaultTerminalParameters = #{
  \ term_finish: 'close',
  \ term_name: 'GS',
  \ vertical: 'false'
\}

let s:defaultInterpreter = 'gs'

function! gs#RunGSTerminal(filePath, overrideTerminalParameters = {})
       belowright  call term_start(s:defaultInterpreter .. ' ' .. expand(a:filePath),extend(s:defaultTerminalParameters,a:overrideTerminalParameters))
endfunction 

function! gs#ExportCurr(mediaType,outputFile)
    try 
        let printCommand = s:defaultInterpreter .. ' -sDEVICE=' .. a:mediaType .. ' -o ' .. a:outputFile .. ' ' .. expand('%:p')
        call system(printCommand)
    catch
	echoerr 'Something went wrong'
    endtry
endfunction

function! gs#ExportFile(filePath,mediaType,outputFile)
    if !filereadable(expand(a:filePath)) 
       echoerr 'Invalid File path'
       return
    endif
    try 
        let printCommand = s:defaultInterpreter .. ' -sDEVICE=' .. a:mediaType .. ' -o ' .. a:outputFile .. ' ' .. a:filePath
        call system(printCommand)
    catch
	echoerr 'Something went wrong'
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
  if !filereadable(filePath) || fnamemodify(filePath,':t:e') != 'ps'
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
