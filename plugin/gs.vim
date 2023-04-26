command! -nargs=? GS call gs#RunCurrGS(<args>)
command! -complete=file -nargs=* FGS call gs#RunFileGS(<f-args>)
command! -nargs=0 AC call gs#SingleLineComment()
command! -range -nargs=0 AMC '<,'>call gs#MultiLineComment()
