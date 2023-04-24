command! -complete=file -nargs=* GS call gs#GSProxy(0,<f-args>)
command! -complete=file -nargs=* VGS call gs#GSProxy(1,<f-args>)
command! -nargs=0 AQ call gs#AddQuote()
