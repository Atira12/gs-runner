command! -nargs=? GS call gs#RunCurrGS(<args>)
command! -complete=file -nargs=* FGS call gs#RunFileGS(<f-args>)

command! -range -nargs=0 GSC call gs#MultiLineComment(<line1>, <line2>)

command! -complete=file -nargs=* GSExport call gs#Export(<f-args>)

