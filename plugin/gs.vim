
command! -complete=file -nargs=* GS call GSProxy(0,<f-args>)
command! -complete=file -nargs=* VGS call GSProxy(1,<f-args>)
command! -nargs=0 AQ call AddQuote()
