command! -nargs=? GSRun call gs#RunCurrGS(<args>)
command! -complete=file -nargs=* GSRunFile call gs#RunFileGS(<f-args>)
command! -range -nargs=0 GSComment call gs#Comment(<line1>, <line2>)
command! -complete=file -nargs=* GSExport call gs#Export(<f-args>)

