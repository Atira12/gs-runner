command! -complete=file -nargs=* GS call gs#GSProxy(0,<f-args>)
command! -complete=file -nargs=* VGS call gs#GSProxy(1,<f-args>)
command! -range -nargs=0 AC '<,'>call gs#AddComment()
