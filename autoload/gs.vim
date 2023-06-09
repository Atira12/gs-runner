" Vim Postscript syntax highlighting 
" Language:     PostScript
" Maintainer:   Anton Antov
" Origin:       https://github.com/Atira12/gs-runner

let s:defaultTerminalParameters = #{
  \ term_finish: 'close',
  \ term_name: 'GS',
  \ vertical: 0
\}

let g:interpreter = exists("g:interpreter") ? g:interpreter : 'gs'
let g:interpreterParameters = exists("g:interpreterParameters") ? g:interpreterParameters : ''

function! gs#RunGSTerminal(filePath, overrideTerminalParameters = {})
      belowright  call term_start(g:interpreter .. ' ' .. g:interpreterParameters .. ' '
      \ .. expand(a:filePath),extend(s:defaultTerminalParameters,a:overrideTerminalParameters))
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
           call system(g:interpreter 
           \ .. ' -sDEVICE=' .. a:1 
           \ .. ' -o ' .. a:2 .. ' '
           \ .. fileToExport)
        catch
      echoerr 'Invalid export parameters'
    endtry
endfunction

function! gs#Comment(startLine, endLine)
  for lineNumber in range(a:startLine, a:endLine) 
     let line = getline(lineNumber)
     if line[0] == '%'
       call setline(lineNumber, line[1:])
     else
       call setline(lineNumber, '%' .. line)
     endif
  endfor
endfunction

function! gs#RunFileGS(file,options = {})
  try
    let filePath = expand(a:file) 

    if !filereadable(filePath) 
       echoerr 'Invalid File Type'
       return
    endif

    call gs#RunGSTerminal(filePath,a:options)
  catch
    echoerr 'Unable to run GS'
  endtry
endfunction 

function! gs#RunCurrGS(options = {})
  try
    let filePath = expand('%:p') 

    if &filetype != 'postscr' 
       echoerr 'Invalid File Type'
       return
    endif

    call gs#RunGSTerminal(filePath,a:options)
  catch
    echoerr 'Unable to run GS'
  endtry
endfunction 
